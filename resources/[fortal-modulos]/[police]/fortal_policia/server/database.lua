-- ===== FUNÇÕES DE BANCO DE DADOS =====

-- Incluir arquivo de utilitários
local Utils = module("fortal_police", "server/utils")

-- Função para converter data MySQL para formato ISO
function MySQLDateToISO(mysqlDate)
    if not mysqlDate or mysqlDate == "" then
        return os.date('%Y-%m-%dT00:00:00Z', os.time())
    end
    
    if type(mysqlDate) == "number" then
        local seconds = mysqlDate / 1000
        local dateTable = os.date('*t', seconds)
        
        local result = string.format('%04d-%02d-%02dT00:00:00', dateTable.year, dateTable.month, dateTable.day)
        return result
    end
    
    if type(mysqlDate) == "string" then
        local year, month, day = mysqlDate:match("(%d+)-(%d+)-(%d+)")
        
        if year and month and day then
            local timestamp = os.time({
                year = tonumber(year),
                month = tonumber(month),
                day = tonumber(day),
                hour = 0,
                min = 0,
                sec = 0
            })
            local result = os.date('%Y-%m-%dT00:00:00', timestamp)
            return result
        end
    end
    
    return os.date('%Y-%m-%dT00:00:00', os.time())
end

-- Função para obter data atual no formato correto
function GetCurrentDate()
    local currentTime = os.time()
    local dateTable = os.date('*t', currentTime)
    return string.format('%04d-%02d-%02d', dateTable.year, dateTable.month, dateTable.day)
end

-- Função para converter timestamp para formato ISO
function TimestampToISO(timestamp)
    return os.date('%Y-%m-%dT00:00:00', timestamp)
end

-- Função para obter rank do jogador
function GetPlayerRank(user_id)
    if not GetResourceState('oxmysql') == 'started' then
        return nil
    end
    
    local query = [[
        SELECT rank FROM ftpolice_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    local result = exports.oxmysql:executeSync(query, {user_id})
    
    if result and result[1] then
        return result[1].rank
    end
    
    return nil
end

-- Função para atualizar estatísticas simplificadas
function UpdateStats(date, type, count)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local dateString = date
    if type(date) == 'number' then
        dateString = os.date('%Y-%m-%d', date / 1000)
    end
    
    local query = [[
        INSERT INTO ftpolice_stats (date, type, count)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE
        count = VALUES(count),
        updated_at = CURRENT_TIMESTAMP
    ]]
    
    exports.oxmysql:execute(query, {dateString, type, count}, function(result)
        if result then
            -- Sucesso
        else
            -- Erro
        end
    end)
end

-- Função para calcular e atualizar todas as estatísticas do dia
function UpdateDailyStats(date)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local seizedItemsQuery = "SELECT COUNT(*) as count FROM ftpolice_history WHERE type = 'Item' AND DATE(created_at) = ?"
    local seizedVehiclesQuery = "SELECT COUNT(*) as count FROM ftpolice_history WHERE type = 'Veículo' AND DATE(created_at) = ?"
    local occurrencesQuery = "SELECT COUNT(*) as count FROM ftpolice_bo WHERE DATE(created_at) = ?"
    local arrestsQuery = "SELECT COUNT(*) as count FROM ftpolice_history WHERE type = 'Prisão' AND DATE(created_at) = ?"
    local finesQuery = "SELECT COUNT(*) as count FROM ftpolice_history WHERE type = 'Multa' AND DATE(created_at) = ?"
    
    local completedQueries = 0
    local totalQueries = 5
    
    local function checkCompletion()
        completedQueries = completedQueries + 1
        if completedQueries >= totalQueries then
            -- Todas as queries foram completadas
        end
    end
    
    -- Itens apreendidos
    exports.oxmysql:execute(seizedItemsQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'seized_items', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Veículos apreendidos
    exports.oxmysql:execute(seizedVehiclesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'seized_vehicles', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- B.O.s registrados
    exports.oxmysql:execute(occurrencesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'occurrences', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Prisões
    exports.oxmysql:execute(arrestsQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'arrests', result[1].count or 0)
        end
        checkCompletion()
    end)
    
    -- Multas
    exports.oxmysql:execute(finesQuery, {date}, function(result)
        if result and result[1] then
            UpdateStats(date, 'fines', result[1].count or 0)
        end
        checkCompletion()
    end)
end

-- Função para salvar histórico do jogador
function SavePlayerHistory(playerId, type, description, amount, months, officerId, officerName)
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftpolice_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        playerId,
        type,
        description,
        amount or 0,
        months or 0,
        officerId,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
            -- Erro ao salvar histórico
        end
    end)
end

-- Função para verificar se um jogador está procurado
function CheckAndUpdateWantedStatus(userId, playerData, callback)
    if not userId or userId == 0 or not playerData then
        if callback then callback(playerData) end
        return
    end
    
    local data = Utils.functions.getUserIdentity(userId)
    if not data then
        if callback then callback(playerData) end
        return
    end
    
    local playerName = "Jogador " .. userId
    if data.name and data.name2 then
        playerName = data.name .. " " .. data.name2
    elseif data.name then
        playerName = data.name
    end
    
    local query = [[
        SELECT id, name, description, status
        FROM ftpolice_wanted_users 
        WHERE name = ? AND status = 'Ativo'
        LIMIT 1
    ]]
    
    exports.oxmysql:execute(query, {playerName}, function(result)
        local isWanted = false
        if result and #result > 0 then
            isWanted = true
        end
        
        if playerData then
            playerData.wanted = isWanted and 'Sim' or 'Não'
        end
        
        if callback then callback(playerData) end
    end)
end

-- Função para buscar dados de um jogador específico
function GetPlayerSearchData(userId)
    if not userId or userId == 0 then
        return false
    end
    
    local data = Utils.functions.getUserIdentity(userId)
    
    if data then
        local name = "Jogador " .. userId
        
        if data.name and data.name2 then
            name = data.name .. " " .. data.name2
        elseif data.name then
            name = data.name
        end
        
        return {
            name = name,
            passport = tostring(userId),
            photo = nil,
            register = data.phone or tostring(userId),
            years = data.age or 25,
            wanted = 'Não',
            size = 'Não',
            history = {}
        }
    else
        return false
    end
end

-- Função para verificar se jogador pode acessar página
function CanAccessPage(user_id, page)
    local rank = GetPlayerRank(user_id)
    if not rank then return false end
    
    local rankConfig = Config.Hierarchy[rank]
    if not rankConfig then return false end
    
    if not rankConfig.restrictedPages or #rankConfig.restrictedPages == 0 then
        return true
    end
    
    for _, restrictedPage in ipairs(rankConfig.restrictedPages) do
        if restrictedPage == page then
            return false
        end
    end
    
    return true
end

-- Função para verificar permissão de ação
function CanPerformAction(user_id, action)
    local rank = GetPlayerRank(user_id)
    if not rank then return false end
    
    local rankConfig = Config.Hierarchy[rank]
    if not rankConfig then return false end
    
    if not rankConfig.permissions then return false end
    
    return rankConfig.permissions[action] == true
end

-- Função para verificar se tem permissão de policial
function HasPolicePermission(user_id)
    if not user_id then return false end
    
    -- Verificar se tem permissão de policial
    if Utils.functions.hasPermission(user_id, Config.DefaultPermission) then
        return true
    end
    
    -- Verificar se está na tabela de membros
    local query = [[
        SELECT user_id FROM ftpolice_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    local result = exports.oxmysql:executeSync(query, {user_id})
    if result and result[1] then
        return true
    end
    
    return false
end

-- Função para obter estatísticas de um oficial específico
function GetOfficerStats(officerId, days)
    if not GetResourceState('oxmysql') == 'started' then
        return {}
    end
    
    local daysFilter = days or 30
    local query = [[
        SELECT 
            type,
            SUM(count) as total_count
        FROM ftpolice_stats 
        WHERE DATE(created_at) >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
        GROUP BY type
    ]]
    
    local result = exports.oxmysql:executeSync(query, {daysFilter})
    return result or {}
end

-- Função para obter estatísticas completas de um oficial
function GetOfficerCompleteStats(officerId)
    if not GetResourceState('oxmysql') == 'started' then
        return {}
    end

    local stats = {
        arrests_made = 0,
        fines_applied = 0,
        total_fines_value = 0,
        total_working_hours = 0,
        vehicles_seized = 0,
        reports_registered = 0
    }
    
    -- Buscar estatísticas da tabela ftpolice_officer_stats
    local officerStatsQuery = "SELECT * FROM ftpolice_officer_stats WHERE user_id = ?"
    local officerStatsResult = exports.oxmysql:executeSync(officerStatsQuery, {officerId})

    if officerStatsResult and #officerStatsResult > 0 then
        local officerData = officerStatsResult[1]
        stats.arrests_made = officerData.arrests_made or 0
        stats.fines_applied = officerData.fines_applied or 0
        stats.total_fines_value = officerData.total_fines_value or 0
        stats.total_working_hours = officerData.total_working_hours or 0
        stats.vehicles_seized = officerData.vehicles_seized or 0
        stats.reports_registered = officerData.reports_registered or 0
    end
    
    -- Buscar histórico da tabela ftpolice_history
    local historyQuery = "SELECT COUNT(*) as total FROM ftpolice_history WHERE officer_id = ?"
    local historyResult = exports.oxmysql:executeSync(historyQuery, {officerId})

    return stats
end

-- Função para obter histórico de um oficial
function GetOfficerHistory(officerId, limit)
    if not GetResourceState('oxmysql') == 'started' then
        return {}
    end
    
    local limitCount = limit or 50
    local query = [[
        SELECT 
            h.id,
            h.player_id,
            h.type,
            h.description,
            h.amount,
            h.months,
            h.officer_id,
            h.officer_name,
            h.created_at
        FROM ftpolice_history h
        WHERE h.officer_id = ?
        ORDER BY h.created_at DESC
        LIMIT ?
    ]]
    
    local result = exports.oxmysql:executeSync(query, {officerId, limitCount})
    return result or {}
end

-- Função para registrar estatística
function RecordOfficerStat(date, type, count)
    if not GetResourceState('oxmysql') == 'started' then
        return false
    end
    
    local query = [[
        INSERT INTO ftpolice_stats (date, type, count)
        VALUES (?, ?, ?)
        ON DUPLICATE KEY UPDATE
        count = count + VALUES(count),
        updated_at = CURRENT_TIMESTAMP
    ]]
    
    local success = exports.oxmysql:executeSync(query, {date, type, count})
    return success ~= nil
end

-- Função para registrar ação do oficial (prisão, multa, etc.)
function RecordOfficerAction(officerId, actionType, playerId, description, amount, months)
    if not GetResourceState('oxmysql') == 'started' then
        return false
    end
    
    local currentDate = os.date('%Y-%m-%d')
    
    -- Registrar na tabela de histórico
    local historyQuery = [[
        INSERT INTO ftpolice_history (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())
    ]]
    
    -- Obter nome do oficial
    local officerName = "Oficial"
    local memberQuery = "SELECT name FROM ftpolice_members WHERE user_id = ?"
    local memberResult = exports.oxmysql:executeSync(memberQuery, {officerId})
    if memberResult and memberResult[1] then
        officerName = memberResult[1].name
    end
    
    local historySuccess = exports.oxmysql:executeSync(historyQuery, {
        playerId, actionType, description, amount or 0, months or 0, officerId, officerName
    })
    
    -- Registrar estatística
    local statSuccess = RecordOfficerStat(currentDate, actionType, 1)
    
    return historySuccess ~= nil and statSuccess
end

-- Retornar todas as funções para o módulo
return {
    GetPlayerRank = GetPlayerRank,
    UpdateStats = UpdateStats,
    UpdateDailyStats = UpdateDailyStats,
    GetOfficerStats = GetOfficerStats,
    GetOfficerCompleteStats = GetOfficerCompleteStats,
    GetOfficerHistory = GetOfficerHistory,
    RecordOfficerStat = RecordOfficerStat,
    RecordOfficerAction = RecordOfficerAction
}

 