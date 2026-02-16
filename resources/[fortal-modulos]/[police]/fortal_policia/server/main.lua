-- Incluir arquivo de utilitários
local Utils = module("fortal_police", "server/utils")

-- Incluir arquivo de funções de banco de dados
local Database = module("fortal_police", "server/database")

-- Verificar se os módulos foram carregados corretamente
if not Utils then
end

if not Database then
else
    -- Verificar se as funções estão disponíveis
    if Database.RecordOfficerStat then
    else
    end
end

-- Função para buscar jogadores próximos
function GetNearbyPlayers(source, distance)
    local nearbyPlayers = {}
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)
    
    
    -- Usar GetPlayers() nativo
    local players = GetPlayers()
    
    for _, playerId in ipairs(players) do
        local targetSource = tonumber(playerId)
        if targetSource and targetSource ~= source then
            local targetPed = GetPlayerPed(targetSource)
            local targetCoords = GetEntityCoords(targetPed)
            
            -- Calcular distância
            local dist = #(playerCoords - targetCoords)
            
            
            if dist <= distance then
                local user_id = Utils.functions.getUserId(targetSource)
                if user_id then
                    -- Verificar se o jogador é policial
                    local isPolice = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
                    
                    -- Se não for policial, adicionar à lista
                    if not isPolice then
                        local identity = Utils.functions.getUserIdentity(user_id)
                        local playerName = "Jogador " .. user_id
                        
                        if identity then
                            if identity.name and identity.name2 then
                                playerName = identity.name .. " " .. identity.name2
                            elseif identity.name then
                                playerName = identity.name
                            end
                        end
                        
                        
                        table.insert(nearbyPlayers, {
                            id = user_id,
                            name = playerName,
                            passport = tostring(user_id),
                            distance = dist
                        })
                    end
                else
                end
            end
        end
    end
    
    return nearbyPlayers
end


function GetAllOnlineUsers()
    local users = nil
    
    -- Método 1: vRP.getUsers()
    if vRP and vRP.getUsers then
        users = vRP.getUsers()
        
        if users and type(users) == 'table' then
            local count = 0
            for _ in pairs(users) do count = count + 1 end
            return users
        end
    end
    
    -- Método 2: Fallback usando GetPlayers() nativo
    local playerList = GetPlayers()
    users = {}
    
    for _, playerId in ipairs(playerList) do
        local source = tonumber(playerId)
        if source then
            local user_id = Utils.functions.getUserId(source)
            if user_id then
                users[user_id] = source
            end
        end
    end
    
    local count = 0
    for _ in pairs(users) do count = count + 1 end
    
    return users
end

-- Função para obter todos os jogadores (online e offline)
function GetAllPlayers()
    local players = {}
    
    -- Buscar jogadores online primeiro
    local users = GetAllOnlineUsers()
    
    if users then
        for user_id, source in pairs(users) do
            local identity = Utils.functions.getUserIdentity(user_id)
            local name = "Jogador " .. user_id
            
            
            if identity then
                if identity.name and identity.name2 then
                    name = identity.name .. " " .. identity.name2
                elseif identity.name then
                    name = identity.name
                end
            end
            
            table.insert(players, {
                name = name,
                passport = tostring(user_id),
                photo = nil,
                register = identity and identity.serial or tostring(user_id),
                years = (identity and identity.age) or 25,
                wanted = 'Não',
                size = 'Não',
                history = {},
                online = true
            })
        end
    end
    
    -- Buscar jogadores offline do banco de dados
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT DISTINCT player_id FROM ftpolice_history', {}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    local user_id = row.player_id
                    
                    -- Verificar se o jogador já não está na lista (online)
                    local alreadyInList = false
                    for _, player in pairs(players) do
                        if tonumber(player.passport) == user_id then
                            alreadyInList = true
                            break
                        end
                    end
                    
                    if not alreadyInList then
                        local identity = Utils.functions.getUserIdentity(user_id)
                        local name = "Jogador " .. user_id
                        
                        if identity then
                            if identity.name and identity.name2 then
                                name = identity.name .. " " .. identity.name2
                            elseif identity.name then
                                name = identity.name
                            end
                        end
                        
                        table.insert(players, {
                            name = name,
                            passport = tostring(user_id),
                            photo = nil,
                            register = identity and identity.serial or tostring(user_id),
                            years = (identity and identity.age) or 25,
                            wanted = 'Não',
                            size = 'Não',
                            history = {},
                            online = false
                        })
                    end
                end
            end
            
        end)
    end
    
    return players
end

-- Função para obter nome do jogador
function GetPlayerName(user_id)
    local identity = Utils.functions.getUserIdentity(user_id)
    local name = "Jogador " .. user_id
    
    
    if identity then
        if identity.name and identity.name2 then
            name = identity.name .. " " .. identity.name2
        elseif identity.name then
            name = identity.name
        end
    end
    
    return name
end

-- Função para buscar e enviar membros atualizados
function SendUpdatedMembers()
    local membersQuery = [[
        SELECT user_id, name, charge, rank, join_date, status 
        FROM ftpolice_members 
        WHERE status = 'Ativo' 
        ORDER BY rank ASC, join_date ASC
    ]]
    
    exports.oxmysql:execute(membersQuery, {}, function(results)
        local members = {}
        
        if results and type(results) == 'table' then
            for i, row in ipairs(results) do
                local rankInfo = Config.Hierarchy[row.rank] or {name = "Desconhecido", label = "Desconhecido"}
                
                
                local isOnline = false
                local targetSource = Utils.functions.getUserSource(row.user_id)
                if targetSource then
                    isOnline = true
                end
                
                local formattedDate = "N/A"
                if row.join_date then
                    if type(row.join_date) == 'number' then
                        local timestamp = row.join_date / 1000
                        local dateTable = os.date('*t', timestamp)
                        if dateTable then
                            formattedDate = string.format('%02d/%02d/%04d', dateTable.day, dateTable.month, dateTable.year)
                        end
                    else
                        local year, month, day = string.match(row.join_date, "(%d+)-(%d+)-(%d+)")
                        if year and month and day then
                            formattedDate = day .. "/" .. month .. "/" .. year
                        end
                    end
                end
                
                local memberData = {
                    id = row.user_id,
                    name = row.name,
                    charge = rankInfo.label or rankInfo.name, -- Usar sempre o label da configuração
                    rank = row.rank,
                    rankName = rankInfo.name,
                    rankLabel = rankInfo.label,
                    joinDate = formattedDate,
                    status = isOnline
                }
                
                table.insert(members, memberData)
            end
        end
        
     
        TriggerClientEvent('fortal_police:receiveData:getMembers', -1, members)
    end)
end

-- Event para buscar dados específicos de um jogador por ID
RegisterNetEvent('getPlayerData')
AddEventHandler('getPlayerData', function(playerId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getPlayerData', source, {})
        return 
    end
    
    local targetId = tonumber(playerId)
    if not targetId then
        TriggerClientEvent('receiveData:getPlayerData', source, {})
        return
    end
    
    -- Usar a função GetPlayerSearchData para buscar dados básicos
    local playerData = GetPlayerSearchData(targetId)
    
    if not playerData then
        TriggerClientEvent('receiveData:getPlayerData', source, {})
        return
    end
    
    -- Verificar e atualizar status de procurado
    CheckAndUpdateWantedStatus(targetId, playerData, function(updatedPlayerData)
        
        -- Buscar foto do suspeito
        exports.oxmysql:execute('SELECT photo FROM ftpolice_imagens WHERE user_id = ?', {targetId}, function(photoRows)
            if photoRows and #photoRows > 0 then
                updatedPlayerData.photo = photoRows[1].photo
            end
            
            -- Buscar histórico do banco de dados se existir
            if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT * FROM ftpolice_history WHERE player_id = ? ORDER BY created_at DESC LIMIT 20', {targetId}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    -- Converter data MySQL para formato DD/MM/YYYY
                    local dateStr = ""
                    local createdAtStr = tostring(row.created_at)
                    
                    if createdAtStr and createdAtStr ~= "" then
                        -- Verificar se é timestamp (número grande)
                        local timestamp = tonumber(createdAtStr)
                        if timestamp and timestamp > 1000000000000 then
                            -- É timestamp em milissegundos, converter para data
                            local seconds = timestamp / 1000
                            local dateTable = os.date("*t", seconds)
                            dateStr = string.format("%02d/%02d/%04d", dateTable.day, dateTable.month, dateTable.year)
                        else
                            -- Tentar diferentes formatos de data string
                            local year, month, day
                            
                            -- Formato YYYY-MM-DD
                            year, month, day = createdAtStr:match("(%d+)-(%d+)-(%d+)")
                            if not year then
                                -- Formato YYYY/MM/DD
                                year, month, day = createdAtStr:match("(%d+)/(%d+)/(%d+)")
                            end
                            
                            if year and month and day then
                                dateStr = string.format("%02d/%02d/%04d", tonumber(day), tonumber(month), tonumber(year))
                            else
                            end
                        end
                    end
                    
                    -- Montar tempo/valor
                    local timeValue = ""
                    local amountNum = tonumber(row.amount or 0)
                    local formattedAmount
                    
                    -- Formatar o valor: sem .00 se for inteiro, com .xx se tiver centavos
                    if amountNum % 1 == 0 then -- Verifica se o número é inteiro
                        formattedAmount = tostring(math.floor(amountNum))
                    else
                        formattedAmount = string.format("%.2f", amountNum)
                    end
                    
                    if row.type == "Prisão" then
                        timeValue = tostring(row.months or 0) .. "/" .. formattedAmount
                    else
                        timeValue = formattedAmount
                    end
                    
                    table.insert(playerData.history, {
                        type = row.type or "Multa",
                        date = dateStr,
                        name = row.officer_name or "Policial",
                        id = row.officer_id or 0,
                        description = row.description or "Descrição não disponível",
                        time = timeValue
                    })
                end
            else
            end
            
            TriggerClientEvent('receiveData:getPlayerData', source, updatedPlayerData)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        TriggerClientEvent('receiveData:getPlayerData', source, updatedPlayerData)
    end
        end)
    end)
end)





-- Event para buscar jogadores
RegisterNetEvent('getPlayers')
AddEventHandler('getPlayers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getPlayers', source, {})
        return 
    end
    
    local players = {}
    local foundCount = 0
    local consecutiveEmpty = 0
    local maxConsecutiveEmpty = 50 -- Para de buscar após 50 IDs consecutivos vazios
    
    
    -- Primeiro, coletar todos os jogadores
    local id = 1
    while consecutiveEmpty < maxConsecutiveEmpty do
        local playerData = GetPlayerSearchData(id)
        if playerData then
            -- Buscar foto do suspeito no banco (será feito de forma assíncrona)
            -- A foto será adicionada quando a consulta retornar
            
            table.insert(players, playerData)
            foundCount = foundCount + 1
            consecutiveEmpty = 0 -- Reset contador de vazios
        else
            consecutiveEmpty = consecutiveEmpty + 1
        end
        
        -- Log a cada 100 IDs para acompanhar o progresso
        if id % 100 == 0 then
        end
        
        id = id + 1
    end
    
    
    -- Se não há jogadores, enviar lista vazia
    if #players == 0 then
        TriggerClientEvent('receiveData:getPlayers', source, players)
        return
    end
    
    -- Agora verificar status de procurado para todos os jogadores
    local playersToCheck = #players
    local playersChecked = 0
    
    
    for i, playerData in ipairs(players) do
        local playerId = tonumber(playerData.passport)
        
        -- Buscar foto do suspeito
        exports.oxmysql:execute('SELECT photo FROM ftpolice_imagens WHERE user_id = ?', {playerId}, function(rows)
            if rows and #rows > 0 then
                playerData.photo = rows[1].photo
            end
            
            -- Verificar status de procurado
            CheckAndUpdateWantedStatus(playerId, playerData, function(updatedPlayerData)
                playersChecked = playersChecked + 1
                
                -- Se todos os jogadores foram verificados, enviar dados atualizados
                if playersChecked >= playersToCheck then
                    TriggerClientEvent('receiveData:getPlayers', source, players)
                end
            end)
        end)
    end
end)

-- Event para buscar avisos do banco de dados
RegisterNetEvent('getWarns')
AddEventHandler('getWarns', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getWarns', source, {})
        return 
    end
    
    local warns = {}
    
    -- Tentar buscar do banco de dados usando oxmysql
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('SELECT * FROM ftpolice_warns ORDER BY id DESC LIMIT 50', {}, function(results)
            if results and type(results) == 'table' and #results > 0 then
                for _, row in pairs(results) do
                    -- Converter data MySQL DATE para formato ISO
                    local isoDate = MySQLDateToISO(row.created_at)
                    
                    
                    table.insert(warns, {
                        id = tostring(row.id),
                        title = row.title or "Título não disponível",
                        description = row.description or "Descrição não disponível",
                        author = row.author_name or "Autor desconhecido",
                        createdAt = isoDate
                    })
                end
            else
                -- Se não há avisos no banco, retornar array vazio
                warns = {}
            end
            
            TriggerClientEvent('receiveData:getWarns', source, warns)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        TriggerClientEvent('receiveData:getWarns', source, {})
    end
end)

-- Event para criar aviso no banco de dados
RegisterNetEvent('createAnnounce')
AddEventHandler('createAnnounce', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:createAnnounce', source, {})
        return 
    end
    
    if not data or not data.title or not data.message then
        TriggerClientEvent('receiveData:createAnnounce', source, {})
        return
    end
    
    local playerName = GetPlayerName(user_id)
    
    -- Tentar inserir no banco de dados
    if GetResourceState('oxmysql') == 'started' then
        -- Inserir apenas com data atual (sem hora)
        -- Forçar timezone local para evitar problemas de UTC
        local currentDate = GetCurrentDate()
        local insertQuery = "INSERT INTO ftpolice_warns (title, description, author_id, author_name, created_at) VALUES (?, ?, ?, ?, ?)"
        local insertParams = {data.title, data.message, user_id, playerName, currentDate}
        
        
        exports.oxmysql:execute(insertQuery, insertParams, function(result)
            local newWarn = {
                id = tostring((result and result.insertId) or math.random(1000, 9999)),
                title = data.title,
                description = data.message,
                author = playerName,
                createdAt = TimestampToISO(os.time())
            }
            
            
            -- Enviar o novo aviso para quem criou
            TriggerClientEvent('receiveData:createAnnounce', source, newWarn)
            
            -- Buscar todos os avisos atualizados e enviar para todos os jogadores online
            exports.oxmysql:execute('SELECT * FROM ftpolice_warns ORDER BY created_at DESC LIMIT 50', {}, function(allWarns)
                local updatedWarns = {}
                
                if allWarns and type(allWarns) == 'table' and #allWarns > 0 then
                    for _, row in pairs(allWarns) do
                        local isoDate = MySQLDateToISO(row.created_at)
                        table.insert(updatedWarns, {
                            id = tostring(row.id),
                            title = row.title or "Título não disponível",
                            description = row.description or "Descrição não disponível",
                            author = row.author_name or "Autor desconhecido",
                            createdAt = isoDate
                        })
                    end
                end
                
                
                -- Obter usuários online com método robusto
                local users = GetAllOnlineUsers()
                
                if users and type(users) == 'table' then
                    local sentCount = 0
                    for target_id, target_source in pairs(users) do
                        if target_source and tonumber(target_source) then
                            TriggerClientEvent('updateWarns', tonumber(target_source), updatedWarns)
                            sentCount = sentCount + 1
                            
                            -- Notificar outros jogadores sobre o novo aviso (exceto quem criou)
                            if target_id ~= user_id then
                                TriggerClientEvent('newWarnNotification', tonumber(target_source), {
                                    title = data.title,
                                    author = playerName
                                })
                            end
                        else
                        end
                    end
                else
                    
                    -- Fallback: enviar apenas para quem criou o aviso
                    TriggerClientEvent('updateWarns', source, updatedWarns)
                end
            end)
        end)
    else
        -- Fallback se oxmysql não estiver disponível
        local newWarn = {
            id = tostring(math.random(1000, 9999)),
            title = data.title,
            description = data.message,
            author = playerName,
            createdAt = TimestampToISO(os.time())
        }
        
        TriggerClientEvent('receiveData:createAnnounce', source, newWarn)
        
        -- Notificar todos os jogadores online
        local users = GetAllOnlineUsers()
        if users and type(users) == 'table' then
            for target_id, target_source in pairs(users) do
                if target_id ~= user_id and target_source then
                    TriggerClientEvent('newWarnNotification', tonumber(target_source), {
                        title = data.title,
                        author = playerName
                    })
                end
            end
        end
    end
end)

-- Event para deletar aviso do banco de dados
RegisterNetEvent('deleteAnnounce')
AddEventHandler('deleteAnnounce', function(announceId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('receiveData:deleteAnnounce', source, { success = false, message = "Usuário não identificado" })
        return 
    end
    
    if not announceId then
        TriggerClientEvent('receiveData:deleteAnnounce', source, { success = false, message = "ID do anúncio não fornecido" })
        return
    end
    
    -- Verificar se o usuário tem permissão para deletar anúncios
    local playerRank = GetPlayerRank(user_id)
    if not playerRank or playerRank > 6 then -- Apenas Capitão e acima podem deletar
        TriggerClientEvent('receiveData:deleteAnnounce', source, { success = false, message = "Você não tem permissão para deletar anúncios" })
        return
    end
    
    -- Tentar deletar do banco de dados
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('DELETE FROM ftpolice_warns WHERE id = ?', {announceId}, function(result)
            if result and result.affectedRows > 0 then
                -- Anúncio deletado com sucesso
                TriggerClientEvent('receiveData:deleteAnnounce', source, { success = true, message = "Anúncio deletado com sucesso" })
                
                -- Buscar todos os avisos atualizados e enviar para todos os jogadores online
                exports.oxmysql:execute('SELECT * FROM ftpolice_warns ORDER BY created_at DESC LIMIT 50', {}, function(allWarns)
                    local updatedWarns = {}
                    
                    if allWarns and type(allWarns) == 'table' and #allWarns > 0 then
                        for _, row in pairs(allWarns) do
                            local isoDate = MySQLDateToISO(row.created_at)
                            table.insert(updatedWarns, {
                                id = tostring(row.id),
                                title = row.title or "Título não disponível",
                                description = row.description or "Descrição não disponível",
                                author = row.author_name or "Autor desconhecido",
                                createdAt = isoDate
                            })
                        end
                    end
                    
                    -- Enviar atualização para todos os jogadores online
                    local users = GetAllOnlineUsers()
                    if users and type(users) == 'table' then
                        for target_id, target_source in pairs(users) do
                            if target_source and tonumber(target_source) then
                                TriggerClientEvent('updateWarns', tonumber(target_source), updatedWarns)
                            end
                        end
                    end
                end)
            else
                TriggerClientEvent('receiveData:deleteAnnounce', source, { success = false, message = "Anúncio não encontrado ou não foi possível deletar" })
            end
        end)
    else
        TriggerClientEvent('receiveData:deleteAnnounce', source, { success = false, message = "Sistema de banco de dados não disponível" })
    end
end)

-- Event para criar boletim de ocorrência
RegisterNetEvent('createOccurrence')
AddEventHandler('createOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('receiveData:createOccurrence', source, { success = false, message = "Usuário não identificado" })
        return 
    end
    
    if not data or not data.description then
        TriggerClientEvent('receiveData:createOccurrence', source, { success = false, message = "Dados inválidos" })
        return
    end
    
    -- Verificar se o usuário tem permissão para criar boletins
    local playerRank = GetPlayerRank(user_id)
    if not playerRank or playerRank > 10 then -- Ajustar conforme necessário
        TriggerClientEvent('receiveData:createOccurrence', source, { success = false, message = "Você não tem permissão para criar boletins" })
        return
    end
    
    -- Obter nome do policial
    local identity = Utils.functions.getUserIdentity(user_id)
    local playerName = "Policial Desconhecido"
    
    if identity then
        if identity.name and identity.name2 then
            playerName = identity.name .. " " .. identity.name2
        elseif identity.name then
            playerName = identity.name
        end
    end
    
    -- Tentar inserir no banco de dados
    if GetResourceState('oxmysql') == 'started' then
        -- Gerar número do boletim
        local occurrenceNumber = 'BO-' .. os.date('%Y%m%d') .. '-' .. math.random(1000, 9999)
        
        exports.oxmysql:execute('INSERT INTO ftpolice_bo (occurrence_number, type, description, applicant_id, applicant_name, suspect_id, suspect_name, officer_id, officer_name, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', {
            occurrenceNumber,
            'Boletim de Ocorrência',
            data.description,
            data.applicant_id or 0,
            data.applicant_name or 'N/A',
            data.suspect_id or 0,
            data.suspect_name or 'N/A',
            user_id,
            playerName,
            'Aberto'
        }, function(result)
            if result and result.insertId then
                -- Boletim criado com sucesso
                TriggerClientEvent('receiveData:createOccurrence', source, { success = true, message = "Boletim de ocorrência criado com sucesso" })
                
                -- Buscar todos os boletins atualizados e enviar para todos os jogadores online
                exports.oxmysql:execute('SELECT * FROM ftpolice_bo ORDER BY created_at DESC LIMIT 50', {}, function(allOccurrences)
                    local updatedOccurrences = {}
                    
                    if allOccurrences and type(allOccurrences) == 'table' and #allOccurrences > 0 then
                        for _, row in pairs(allOccurrences) do
                            local isoDate = MySQLDateToISO(row.created_at)
                            table.insert(updatedOccurrences, {
                                id = tostring(row.id),
                                date = isoDate,
                                officerName = row.officer_name or "Policial Desconhecido",
                                description = row.description or "Descrição não disponível",
                                status = row.status or "Aberto",
                                applicant = row.applicant_name or "N/A",
                                suspect = row.suspect_name or "N/A"
                            })
                        end
                    end
                    
                    -- Enviar atualização para todos os jogadores online
                    local users = GetAllOnlineUsers()
                    if users and type(users) == 'table' then
                        for target_id, target_source in pairs(users) do
                            if target_source and tonumber(target_source) then
                                TriggerClientEvent('updateOccurrences', tonumber(target_source), updatedOccurrences)
                            end
                        end
                    end
                end)
            else
                TriggerClientEvent('receiveData:createOccurrence', source, { success = false, message = "Erro ao criar boletim de ocorrência" })
            end
        end)
    else
        TriggerClientEvent('receiveData:createOccurrence', source, { success = false, message = "Sistema de banco de dados não disponível" })
    end
end)


-- Event para buscar opções de prisão
RegisterNetEvent('getOptions')
AddEventHandler('getOptions', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getOptions', source, {suspect = {}, infractions = {}})
        return 
    end
    
    local suspects = {}
    local infractions = {}
    
    -- Buscar suspeitos (jogadores próximos)
    local nearbyPlayers = GetNearbyPlayers(source, 12.0) -- Aumentar distância para 12.0
    for _, player in pairs(nearbyPlayers) do
        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    -- Buscar infrações da config de prisões
    if Config and Config.Prison then
        for _, fine in pairs(Config.Prison) do
            table.insert(infractions, {
                art = fine.art,
                description = fine.description .. ' (' .. fine.months .. ' meses e $' .. fine.price .. ')'
            })
        end
    else
        -- Infrações padrão se config não existir
        table.insert(infractions, {
            art = 101,
            description = 'Excesso de velocidade (2 meses e $500)'
        })
        table.insert(infractions, {
            art = 102,
            description = 'Direção perigosa (5 meses e $1000)'
        })
    end
    
    local options = {
        suspect = suspects,
        infractions = infractions
    }
    
    TriggerClientEvent('receiveData:getOptions', source, options)
end)

-- Event para buscar opções de multas (sem prisão)
RegisterNetEvent('getOptionsFine')
AddEventHandler('getOptionsFine', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getOptions', source, {suspect = {}, infractions = {}})
        return 
    end
    
    local suspects = {}
    local infractions = {}
    
    -- Buscar suspeitos (jogadores próximos)
    local nearbyPlayers = GetNearbyPlayers(source, 12.0) -- Aumentar distância para 12.0
    for _, player in pairs(nearbyPlayers) do
        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    -- Buscar infrações da nova config de multas
    if Config and Config.Fines then
        for _, fine in pairs(Config.Fines) do
            table.insert(infractions, {
                art = fine.art,
                description = fine.description .. ' ($' .. fine.price .. ')'
            })
        end
    else
        -- Infrações padrão se config não existir
        table.insert(infractions, {
            art = 301,
            description = 'Estacionamento irregular ($200)'
        })
        table.insert(infractions, {
            art = 302,
            description = 'Ultrapassagem proibida ($400)'
        })
        table.insert(infractions, {
            art = 303,
            description = 'Sinal vermelho ($300)'
        })
    end
    
    local options = {
        suspect = suspects,
        infractions = infractions
    }
    
    TriggerClientEvent('receiveData:getOptions', source, options)
end)

-- Event para aplicar multa
RegisterNetEvent('applyFine')
AddEventHandler('applyFine', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    local targetId = tonumber(data.targetId)
    local fineId = tonumber(data.fineId)
    local description = data.description or ""
    
    if not targetId or not fineId then
        return
    end
    
    -- Buscar informações da multa
    local fineInfo = Config.Fines[fineId]
    if not fineInfo then
        return
    end
    
    -- Aplicar multa usando vRP
    Utils.functions.addFines(targetId, fineInfo.value)
    
    -- Salvar na tabela ftpolice_fines
    local identity = Utils.functions.getUserIdentity(targetId)
    local targetName = "Jogador " .. targetId
    
    if identity then
        if identity.name and identity.name2 then
            targetName = identity.name .. " " .. identity.name2
        elseif identity.name then
            targetName = identity.name
        end
    end
    
    local query = [[
        INSERT INTO ftpolice_fines (user_id, name, fine_value, fine_description, applied_by, applied_date) 
        VALUES (?, ?, ?, ?, ?, ?)
    ]]
    local params = {targetId, targetName, fineInfo.value, description, user_id, os.date('%Y-%m-%d %H:%M:%S')}
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Salvar no histórico
            local historyQuery = [[
                INSERT INTO ftpolice_history (user_id, action, description, officer_id, date) 
                VALUES (?, ?, ?, ?, ?)
            ]]
            local historyParams = {targetId, "Multa Aplicada", "Multa de $" .. fineInfo.value .. " - " .. fineInfo.description, user_id, os.date('%Y-%m-%d %H:%M:%S')}
            
            exports.oxmysql:execute(historyQuery, historyParams, function(historyResult)
                if historyResult then
                else
                end
            end)
            

            
            -- Atualizar estatísticas gerais
            local generalStatsQuery = [[
                INSERT INTO ftpolice_stats (date, type, count) 
                VALUES (?, 'fines', 1) 
                ON DUPLICATE KEY UPDATE count = count + 1
            ]]
            local generalStatsParams = {os.date('%Y-%m-%d')}
            
            exports.oxmysql:execute(generalStatsQuery, generalStatsParams, function(generalStatsResult)
                if generalStatsResult then
                    
                    -- Atualizar estatísticas do oficial
                    local officerStatsQuery = [[
                        INSERT INTO ftpolice_officer_stats (user_id, fines_applied, total_fines_value)
                        VALUES (?, 1, ?)
                        ON DUPLICATE KEY UPDATE
                        fines_applied = fines_applied + 1,
                        total_fines_value = total_fines_value + ?
                    ]]
                    
                    exports.oxmysql:execute(officerStatsQuery, {user_id, fineInfo.value, fineInfo.value}, function(officerStatsResult)
                        if officerStatsResult then
                        else
                        end
                    end)
                    
                    -- Notificar todos os clientes para atualizar estatísticas
                    TriggerClientEvent('updateStatistics', -1)
                else
                end
            end)
            
            -- Notificar jogadores
            TriggerClientEvent('Notify', source, 'sucesso', 'Multa aplicada com sucesso!')
            
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
                TriggerClientEvent('Notify', targetSource, 'negado', 'Você recebeu uma multa de $' .. fineInfo.value)
            end
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao aplicar multa!')
        end
    end)
end)


-- Event para confirmar prisão
RegisterNetEvent('confirmPrison')
AddEventHandler('confirmPrison', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    -- Processar prisão usando o sistema fortal_prisao
    if data and data.users and data.users.suspects and type(data.users.suspects) == "table" then
        for _, suspect in pairs(data.users.suspects) do
            local targetId = tonumber(suspect.id)
            local targetSource = Utils.functions.getUserSource(targetId)
            
            if targetSource then
                -- Calcular tempo total e multa total
                local totalMonths = 0
                local totalFine = 0
                local infractionsList = {}
                local prisonType = data.prisonType or "normal"
                
                -- Verificar se infractions existe e é uma tabela
                if data.users.infractions and type(data.users.infractions) == "table" then
                    for _, infraction in pairs(data.users.infractions) do
                        -- Buscar infração na config de prisões
                        if Config and Config.Prison then
                            for _, fine in pairs(Config.Prison) do
                                if fine.art == infraction.art then
                                    totalMonths = totalMonths + fine.months
                                    totalFine = totalFine + fine.price
                                    table.insert(infractionsList, fine.description)
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- Se não há infrações, aplicar valores padrão
                if totalMonths == 0 then
                    totalMonths = 12
                    totalFine = 5000
                    table.insert(infractionsList, "Infração padrão")
                end
                
                -- Usar o sistema fortal_prisao para prender
                local description = data.description or table.concat(infractionsList, ", ")
                
                -- Chamar função do fortal_prisao usando o sistema de integração
                
                -- Chamar diretamente o evento do fortal_prisao
                TriggerEvent("fortal_prisao:imprisonFromPolice", targetId, prisonType, totalMonths, totalFine, description, source)
                
                local success = true -- Assumir sucesso se não houver erro
                local message = "Prisão aplicada com sucesso"
                
                if success then
                    -- Salvar histórico da prisão no banco de dados
                    if GetResourceState('oxmysql') == 'started' then
                        local officerName = GetPlayerName(user_id)
                        local targetName = GetPlayerName(targetId)
                        
                        -- Salvar na tabela ftpolice_history
                        local historyQuery = "INSERT INTO ftpolice_history (player_id, type, description, amount, months, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                        local historyParams = {targetId, "Prisão", description, totalFine, totalMonths, user_id, officerName}
                        
                        exports.oxmysql:execute(historyQuery, historyParams, function(historyResult)
                            if historyResult then
                                
                                                    -- Atualizar estatísticas na tabela ftpolice_stats
                    local today = os.date('%Y-%m-%d')
                    local statsQuery = "INSERT INTO ftpolice_stats (date, type, count) VALUES (?, 'arrests', 1) ON DUPLICATE KEY UPDATE count = count + 1"
                    local statsParams = {today}
                    
                    exports.oxmysql:execute(statsQuery, statsParams, function(statsResult)
                                    if statsResult then
                                        
                                        -- Atualizar estatísticas do oficial
                                        local officerStatsQuery = [[
                                            INSERT INTO ftpolice_officer_stats (user_id, arrests_made)
                                            VALUES (?, 1)
                                            ON DUPLICATE KEY UPDATE
                                            arrests_made = arrests_made + 1
                                        ]]
                                        
                                        exports.oxmysql:execute(officerStatsQuery, {user_id}, function(officerStatsResult)
                                            if officerStatsResult then
                                            else
                                            end
                                        end)
                                        
                                        -- Notificar todos os clientes para atualizar estatísticas
                                        TriggerClientEvent('updateStatistics', -1)
                                    else
                                    end
                                end)
                            else
                            end
                        end)
                    end
                    
                    -- Notificar policial
                    TriggerClientEvent("Notify", source, "verde", "Prisão aplicada com sucesso!", 5000)
                    
                    -- O fortal_prisao vai cuidar do teleporte e interface
                else
                    TriggerClientEvent("Notify", source, "vermelho", "Erro ao aplicar prisão: " .. message, 5000)
                end
                
                local targetName = GetPlayerName(targetId)
            end
        end
    end
end)

-- Event para confirmar multa
RegisterNetEvent('confirmFine')
AddEventHandler('confirmFine', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local officerName = GetPlayerName(source)
    
    -- Processar multa
    if data and data.users and data.users.suspects and type(data.users.suspects) == "table" then
        for _, suspect in pairs(data.users.suspects) do
            local targetId = tonumber(suspect.id)
            local targetSource = Utils.functions.getUserSource(targetId)
            
            if targetSource then
                -- Calcular multa total
                local totalFine = 0
                local infractionsList = {}
                
                -- Verificar se infractions existe e é uma tabela
                if data.users.infractions and type(data.users.infractions) == "table" then
                    for _, infraction in pairs(data.users.infractions) do
                        -- Buscar infração na config de multas
                        if Config and Config.Fines then
                            for _, fine in pairs(Config.Fines) do
                                if fine.art == infraction.art then
                                    totalFine = totalFine + fine.price
                                    table.insert(infractionsList, fine.description)
                                    break
                                end
                            end
                        end
                    end
                end
                
                -- Se não há infrações, aplicar valor padrão
                if totalFine == 0 then
                    totalFine = 500
                    table.insert(infractionsList, "Multa padrão")
                end
                
                -- Aplicar multa
                if totalFine > 0 then
                    Utils.functions.tryPayment(targetId, totalFine)
                end
                
                -- Salvar histórico no banco de dados
                if GetResourceState('oxmysql') == 'started' then
                    local description = table.concat(infractionsList, ", ")
                    local insertQuery = "INSERT INTO ftpolice_history (player_id, type, description, amount, months, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                    local insertParams = {targetId, "Multa", description, totalFine, 0, user_id, officerName}
                    
                    exports.oxmysql:execute(insertQuery, insertParams, function(result)
                        if result then
                        else
                        end
                    end)
                    
                    -- Salvar na tabela ftpolice_fines
                    local fineQuery = "INSERT INTO ftpolice_fines (player_id, player_name, fine_type, description, amount, officer_id, officer_name, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, CURDATE())"
                    local fineParams = {targetId, GetPlayerName(targetSource), "Multa", description, totalFine, user_id, officerName}
                    
                    exports.oxmysql:execute(fineQuery, fineParams, function(result)
                        if result then
                        else
                        end
                    end)
                    
                    -- Atualizar estatísticas na tabela ftpolice_stats
                    local today = os.date('%Y-%m-%d')
                    local statsQuery = "INSERT INTO ftpolice_stats (date, type, count) VALUES (?, 'fines', 1) ON DUPLICATE KEY UPDATE count = count + 1"
                    local statsParams = {today}
                    
                    exports.oxmysql:execute(statsQuery, statsParams, function(result)
                        if result then
                        else
                        end
                    end)
                end
                
                -- Mostrar multa para o suspeito
                TriggerClientEvent('showFineAmount', targetSource, totalFine)
                
                local targetName = GetPlayerName(targetSource)
            end
        end
    end
end)

-- Event para buscar membros
RegisterNetEvent('fortal_police:getMembers')
AddEventHandler('fortal_police:getMembers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('fortal_police:receiveData:getMembers', source, {})
        return 
    end
    
    -- Buscar membros da tabela ftpolice_members
    local query = [[
        SELECT user_id, name, charge, rank, join_date, status 
        FROM ftpolice_members 
        WHERE status = 'Ativo' 
        ORDER BY rank ASC, join_date ASC
    ]]
    
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('fortal_police:receiveData:getMembers', source, {})
        return
    end
    
    -- Primeiro, vamos verificar se há dados na tabela
    exports.oxmysql:execute('SELECT COUNT(*) as count FROM ftpolice_members', {}, function(countResult)
        
        -- Agora executar a query principal
        exports.oxmysql:execute(query, {}, function(results)
            
            local members = {}
            
            if results and type(results) == 'table' then
                
                for i, row in ipairs(results) do
                    
                    local rankInfo = Config.Hierarchy[row.rank] or {name = "Desconhecido", label = "Desconhecido"}
                    
                    -- Verificar se o jogador está online
                    local isOnline = false
                    local targetSource = Utils.functions.getUserSource(row.user_id)
                    if targetSource then
                        isOnline = true
                    end
                    
                    -- Formatar data de forma segura
                    local formattedDate = "N/A"
                    
                    if row.join_date then
                        
                        -- Se for número (timestamp), converter
                        if type(row.join_date) == 'number' then
                            local timestamp = row.join_date / 1000 -- Converter de milissegundos para segundos
                            local dateTable = os.date('*t', timestamp)
                            if dateTable then
                                formattedDate = string.format('%02d/%02d/%04d', dateTable.day, dateTable.month, dateTable.year)
                            else
                            end
                        else
                            -- Se for string, tentar extrair com regex
                            local year, month, day = string.match(row.join_date, "(%d+)-(%d+)-(%d+)")
                            
                            if year and month and day then
                                formattedDate = day .. "/" .. month .. "/" .. year
                            else
                            end
                        end
                    else
                    end
                    
                    local memberData = {
                        id = row.user_id,
                        name = row.name,
                        charge = rankInfo.label or rankInfo.name, -- Usar sempre o label da configuração
                        rank = row.rank,
                        rankName = rankInfo.name,
                        rankLabel = rankInfo.label,
                        joinDate = formattedDate,
                        status = isOnline
                    }
                    
                    table.insert(members, memberData)
                end
            else
            end
            
            TriggerClientEvent('fortal_police:receiveData:getMembers', source, members)
        end)
    end)
end)

-- Event para adicionar membro
RegisterNetEvent('addMember')
AddEventHandler('addMember', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local targetId = tonumber(data.id)
    local targetSource = Utils.functions.getUserSource(targetId)
    
    if targetSource then
        local officerName = GetPlayerName(user_id)
        local targetName = GetPlayerName(targetId)
    end
end)

-- Event para contratar membro
RegisterNetEvent('fortal_police:hireMember')
AddEventHandler('fortal_police:hireMember', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    local targetId = tonumber(data.id)
    local targetSource = Utils.functions.getUserSource(targetId)
    
    
    if not targetSource then
        TriggerClientEvent('Notify', source, 'negado', 'Jogador não está online!')
        return
    end
    
    -- Verificar se o jogador já está na tabela ftpolice_members
    local query = [[
        SELECT user_id FROM ftpolice_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]
    
    
    exports.oxmysql:execute(query, {targetId}, function(result)
        
        if result and #result > 0 then
            TriggerClientEvent('Notify', source, 'negado', 'Este jogador já é membro da corporação!')
            return
        end
        
        
        -- Se não está na tabela, pode contratar
        -- Fazer request para o jogador
        if Utils.functions.request(targetSource, "Deseja aceitar entrar na corporação da Polícia Militar?") then
            
            -- Se aceitar, adicionar à tabela ftpolice_members
            local identity = Utils.functions.getUserIdentity(targetId)
            local playerName = "Jogador " .. targetId
            
            if identity then
                if identity.name and identity.name2 then
                    playerName = identity.name .. " " .. identity.name2
                elseif identity.name then
                    playerName = identity.name
                end
            end
            
            
            local insertQuery = [[
                INSERT INTO ftpolice_members (user_id, name, charge, rank, join_date, status) 
                VALUES (?, ?, ?, ?, ?, ?)
            ]]
            local currentDate = os.date('%Y-%m-%d') -- Usar formato de data
            
            -- Usar o rank selecionado pelo usuário
            local selectedRank = 16 -- Rank padrão (Aluno)
            local selectedCharge = "Aluno" -- Cargo padrão
            
            -- Buscar o rank baseado no label do cargo selecionado
            for rank, rankData in pairs(Config.Hierarchy) do
                if rankData.label == data.rank then
                    selectedRank = rank
                    selectedCharge = rankData.label -- Sempre usar o label
                    break
                end
            end
            
            
            local params = {targetId, playerName, selectedCharge, selectedRank, currentDate, "Ativo"}
            
            exports.oxmysql:execute(insertQuery, params, function(insertResult)

                if insertResult then
                    -- Definir permissão direto com rank específico
                    Utils.functions.setPermission(targetId, Config.DefaultPermission, selectedRank)
                    
                    -- Forçar atualização das permissões do jogador contratado
                    local targetSource = Utils.functions.getUserSource(targetId)
                    if targetSource then
                        -- Notificar o jogador sobre a atualização de permissões
                        TriggerClientEvent('fortal_police:updatePermissions', targetSource)
                    end
                    
                    TriggerClientEvent('Notify', source, 'sucesso', 'Jogador contratado com sucesso!')
                    TriggerClientEvent('Notify', targetSource, 'sucesso', 'Você foi contratado como policial!')
                    
                    -- Buscar membros atualizados e enviar para todos
                    SendUpdatedMembers()
                else
                    TriggerClientEvent('Notify', source, 'negado', 'Erro ao contratar jogador!')
                end
            end)
        else
            TriggerClientEvent('Notify', source, 'negado', 'Jogador recusou a contratação!')
        end
    end)
end)


local function removePoliceItems(user_id)
  if not user_id then return end 
  local inventory = vRP.userInventory(user_id) 

  for _,data in pairs(inventory) do 
    local split = splitString(data.item, "-")
    local totalName = data.item
    local itemAmount = data.amount
    local itemName = split[1]
    for _,policeItem in pairs(Config.policeItems) do 
      if itemName == policeItem then 
        TriggerEvent("inventory:cleanAmmos",user_id,itemName) 
        Wait(2000)
        vRP.tryGetInventoryItem(user_id,totalName,itemAmount,true)
      end 
    end 
  end 
end


-- Event para remover/demitir membro
RegisterNetEvent('fortal_police:removePlayer')
AddEventHandler('fortal_police:removePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    -- Verificar permissão para demitir
    if not CanPerformAction(user_id, 'canFire') then
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem permissão para demitir membros!')
        return
    end
    
    local targetId = tonumber(data.id)
    
    if not targetId then
        TriggerClientEvent('Notify', source, 'negado', 'ID do membro inválido!')
        return
    end
    
    -- Verificar se não está tentando demitir a si mesmo
    if targetId == user_id then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode demitir a si mesmo!')
        return
    end
    
    -- Verificar se o membro existe na tabela
    local checkQuery = [[
        SELECT user_id, name, rank FROM ftpolice_members 
        WHERE user_id = ? AND status = 'Ativo'
    ]]

    exports.oxmysql:execute(checkQuery, {targetId}, function(checkResult)
        if not checkResult or #checkResult == 0 then
            TriggerClientEvent('Notify', source, 'negado', 'Membro não encontrado!')
            return
        end
        
        local memberData = checkResult[1]
        
        -- Obter rank do jogador que está demitindo
        local demoterRank = GetPlayerRank(user_id)
        if not demoterRank then
            TriggerClientEvent('Notify', source, 'negado', 'Você não tem rank válido!')
            return
        end
        
        -- Verificar se não está tentando demitir alguém de patente superior
        if memberData.rank <= demoterRank then
            TriggerClientEvent('Notify', source, 'negado', 'Você só pode demitir alguém de patente inferior!')
            return
        end
        
        -- Remover permissões de policial
        Utils.functions.remPermission(targetId, Config.DefaultPermission)
        Utils.functions.remPermission(targetId, "waitPolice")

        removePoliceItems(targetId)
        
        -- Deletar membro da tabela
        local deleteQuery = [[
            DELETE FROM ftpolice_members 
        WHERE user_id = ?
        ]]
        
        exports.oxmysql:execute(deleteQuery, {targetId}, function(deleteResult)
            if deleteResult then
                
                -- Notificar quem demitiu
                TriggerClientEvent('Notify', source, 'sucesso', 'Membro demitido com sucesso!')
                
                -- Notificar o membro demitido se estiver online
                local targetSource = Utils.functions.getUserSource(targetId)
                if targetSource then
                    -- Forçar atualização das permissões do jogador demitido
                    TriggerClientEvent('fortal_police:updatePermissions', targetSource)
                    
                    TriggerClientEvent('Notify', targetSource, 'negado', 'Você foi demitido da corporação!')
                end
                
                -- Buscar membros atualizados e enviar para todos
                SendUpdatedMembers()
                
            else
                TriggerClientEvent('Notify', source, 'negado', 'Erro ao demitir membro!')
            end
        end)
    end)
end)

-- Event para promover membro
RegisterNetEvent('fortal_police:promotePlayer')
AddEventHandler('fortal_police:promotePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    

    
    if not user_id then 

        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canPromote') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para promover membros!", 5000)
        return
    end
    
    local targetId = tonumber(data.id)
    local currentRank = tonumber(data.rank)
    
    
    if not targetId or not currentRank then

        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Verificar se não está tentando se auto-promover
    if targetId == user_id then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode se auto-promover!')
        return
    end
    
    -- Obter rank do jogador que está promovendo
    local promoterRank = GetPlayerRank(user_id)
    if not promoterRank then
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem rank válido!')
        return
    end
    
    -- Verificar se o promotor pode promover até a patente do alvo
    -- O promotor só pode promover até sua própria patente
    if currentRank <= promoterRank then
        TriggerClientEvent('Notify', source, 'negado', 'Você só pode promover até sua própria patente!')
        return
    end
    
    -- Verificar se pode ser promovido (não pode ser Secretário - rank 1)
    if currentRank <= 1 then
        TriggerClientEvent('Notify', source, 'negado', 'Este membro já está na patente máxima!')
        return
    end
    
    local newRank = currentRank - 1 -- Diminuir rank (1 = Secretário, 16 = Aluno)
    local rankInfo = Config.Hierarchy[newRank]
    
    
    if not rankInfo then
        TriggerClientEvent('Notify', source, 'negado', 'Patente inválida!')
        return
    end
    
    -- Atualizar rank na DB
    local query = [[
        UPDATE ftpolice_members 
        SET rank = ?, charge = ? 
        WHERE user_id = ?
    ]]
    local params = {newRank, rankInfo.name, targetId}
    
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            

            Utils.functions.setPermission(targetId, Config.DefaultPermission, newRank)
            
            -- Forçar atualização das permissões do jogador promovido
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
               
                TriggerClientEvent('fortal_police:updatePermissions', targetSource)
                
                TriggerClientEvent('Notify', targetSource, 'sucesso', 'Você foi promovido para ' .. rankInfo.label .. '!')
            end
            
            -- Notificar o promotor
            TriggerClientEvent('Notify', source, 'sucesso', 'Membro promovido para ' .. rankInfo.label .. '!')
            
            -- Buscar membros atualizados e enviar para todos
            SendUpdatedMembers()
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao promover membro!')
        end
    end)
end)

-- Event para rebaixar membro
RegisterNetEvent('fortal_police:demotePlayer')
AddEventHandler('fortal_police:demotePlayer', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    

    
    if not user_id then 

        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canDemote') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para rebaixar membros!", 5000)
        return
    end
    
    local targetId = tonumber(data.id)
    local currentRank = tonumber(data.rank)
    
    
    if not targetId or not currentRank then

        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Verificar se não está tentando se auto-rebaixar
    if targetId == user_id then
        TriggerClientEvent('Notify', source, 'negado', 'Você não pode se auto-rebaixar!')
        return
    end
    
    -- Obter rank do jogador que está rebaixando
    local demoterRank = GetPlayerRank(user_id)
    if not demoterRank then
        TriggerClientEvent('Notify', source, 'negado', 'Você não tem rank válido!')
        return
    end
    
    -- Verificar se o rebaixador pode rebaixar o alvo
    -- O rebaixador só pode rebaixar alguém de patente inferior ou igual
    if currentRank < demoterRank then
        TriggerClientEvent('Notify', source, 'negado', 'Você só pode rebaixar alguém de patente inferior ou igual!')
        return
    end
    
    -- Verificar se pode ser rebaixado (não pode ser Aluno - rank 16)
    if currentRank >= 16 then
        TriggerClientEvent('Notify', source, 'negado', 'Este membro já está na patente mínima!')
        return
    end
    
    local newRank = currentRank + 1 -- Aumentar rank (1 = Secretário, 16 = Aluno)
    local rankInfo = Config.Hierarchy[newRank]
    
    
    if not rankInfo then
        TriggerClientEvent('Notify', source, 'negado', 'Patente inválida!')
        return
    end
    
    -- Atualizar rank na DB
    local query = [[
        UPDATE ftpolice_members 
        SET rank = ?, charge = ? 
        WHERE user_id = ?
    ]]
    local params = {newRank, rankInfo.name, targetId}
    
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Remover permissão antiga e definir nova permissão
            Utils.functions.setPermission(targetId, Config.DefaultPermission, newRank)
            
            -- Forçar atualização das permissões do jogador rebaixado
            local targetSource = Utils.functions.getUserSource(targetId)
            if targetSource then
                -- Notificar o jogador sobre a atualização de permissões
                TriggerClientEvent('fortal_police:updatePermissions', targetSource)
                
                TriggerClientEvent('Notify', targetSource, 'negado', 'Você foi rebaixado para ' .. rankInfo.label .. '!')
            end
            
            -- Notificar o rebaixador
            TriggerClientEvent('Notify', source, 'sucesso', 'Membro rebaixado para ' .. rankInfo.label .. '!')
            
            -- Buscar membros atualizados e enviar para todos
            SendUpdatedMembers()
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao rebaixar membro!')
        end
    end)
end)

-- Event para sair da organização
RegisterNetEvent('leaveOrg')
AddEventHandler('leaveOrg', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    local playerName = GetPlayerName(user_id)
end)

-- Debug: Verificar se o servidor está funcionando
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
    end
end)

-- ===== SISTEMA DE ESTATÍSTICAS =====

-- Event para buscar estatísticas
RegisterNetEvent('getStatistics')
AddEventHandler('getStatistics', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getStatistics', source, {})
        return 
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('receiveData:getStatistics', source, {})
        return
    end
    
    -- Buscar todas as estatísticas disponíveis
    
    local query = [[
        SELECT date, type, count
        FROM ftpolice_stats 
        ORDER BY date DESC, type ASC
    ]]
    
    exports.oxmysql:execute(query, {}, function(results)
        local statistics = {}
        local statsByDate = {}
        
        -- Inicializar com todas as datas encontradas no banco
        local datesInDB = {}
        
        -- Primeiro, vamos coletar todas as datas únicas dos resultados
        if results and type(results) == 'table' then
            for _, row in pairs(results) do
                local dateString = row.date
                if type(row.date) == 'number' then
                    dateString = os.date('%Y-%m-%d', row.date / 1000)
                end
                datesInDB[dateString] = true
            end
        end
        
        -- Se não há dados no banco, usar os últimos 30 dias como fallback
        if not next(datesInDB) then
            local currentTime = os.time()
            for i = 29, 0, -1 do
                local date = os.date('%Y-%m-%d', currentTime - (i * 24 * 60 * 60))
                datesInDB[date] = true
            end
        end
        
        -- Inicializar statsByDate com as datas encontradas
        for date, _ in pairs(datesInDB) do
            statsByDate[date] = {
                seized_items = 0,
                seized_vehicles = 0,
                occurrences = 0,
                arrests = 0,
                fines = 0
            }
        end
        
        for date, _ in pairs(statsByDate) do
        end
        
        -- Preencher com dados reais do banco (se existirem)
        if results and type(results) == 'table' then
            for _, row in pairs(results) do
                
                -- Converter timestamp para string de data se necessário
                local dateString = row.date
                if type(row.date) == 'number' then
                    dateString = os.date('%Y-%m-%d', row.date / 1000) -- Converter de milissegundos para segundos
                elseif type(row.date) == 'string' then
                    -- Se for string, extrair apenas a data (YYYY-MM-DD)
                    local year, month, day = string.match(row.date, "(%d+)-(%d+)-(%d+)")
                    if year and month and day then
                        dateString = year .. "-" .. month .. "-" .. day
                    end
                end
                
                if statsByDate[dateString] then
                    
                    if row.type == 'seized_items' then
                        statsByDate[dateString].seized_items = row.count
                    elseif row.type == 'seized_vehicles' then
                        statsByDate[dateString].seized_vehicles = row.count
                    elseif row.type == 'occurrences' then
                        statsByDate[dateString].occurrences = row.count
                    elseif row.type == 'arrests' then
                        statsByDate[dateString].arrests = row.count
                    elseif row.type == 'fines' then
                        statsByDate[dateString].fines = row.count
                    else
                    end
                else
                    for key, _ in pairs(statsByDate) do
                    end
                end
            end
        else
        end
        
        -- Converter para formato do frontend
        for date, stats in pairs(statsByDate) do
            
            -- Converter data para formato ISO
            local year, month, day = string.match(date, "(%d+)-(%d+)-(%d+)")
            local isoDate = nil
            
            if year and month and day then
                isoDate = os.date('%Y-%m-%dT00:00:00Z', os.time({
                    year = tonumber(year),
                    month = tonumber(month),
                    day = tonumber(day)
                }))
            else
                isoDate = os.date('%Y-%m-%dT00:00:00Z', os.time())
            end
            
            local statData = {
                date = isoDate,
                data = {
                    {
                        name = "Itens apreendidas",
                        Valor = stats.seized_items
                    },
                    {
                        name = "Veículos apreendidos",
                        Valor = stats.seized_vehicles
                    },
                    {
                        name = "B.O's registrados",
                        Valor = stats.occurrences
                    },
                    {
                        name = "Prisões realizadas",
                        Valor = stats.arrests
                    },
                    {
                        name = "Multas aplicadas",
                        Valor = stats.fines
                    }
                }
            }
            
            table.insert(statistics, statData)
        end
        
        TriggerClientEvent('receiveData:getStatistics', source, statistics)
    end)
end)

-- Event para registrar item apreendido (simplificado)
RegisterNetEvent('registerSeizedItem')
AddEventHandler('registerSeizedItem', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.player_id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local playerName = GetPlayerName(data.player_id)
    
    -- Registrar como histórico simples
    local query = [[
        INSERT INTO ftpolice_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, 'Item', 'Item apreendido', 0, 0, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        data.player_id,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Event para registrar veículo apreendido (simplificado)
RegisterNetEvent('registerSeizedVehicle')
AddEventHandler('registerSeizedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.player_id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local playerName = GetPlayerName(data.player_id)
    
    -- Registrar como histórico simples
    local query = [[
        INSERT INTO ftpolice_history 
        (player_id, type, description, amount, months, officer_id, officer_name, created_at)
        VALUES (?, 'Veículo', 'Veículo apreendido', 0, 0, ?, ?, CURRENT_DATE)
    ]]
    
    local params = {
        data.player_id,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar estatísticas do dia
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Event para registrar B.O.
RegisterNetEvent('registerOccurrence')
AddEventHandler('registerOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.description or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local officerName = GetPlayerName(user_id)
    local occurrenceNumber = 'BO-' .. os.date('%Y%m%d') .. '-' .. math.random(1000, 9999)
    
    local query = [[
        INSERT INTO ftpolice_bo 
        (occurrence_number, type, description, location, applicant_id, applicant_name, suspect_id, suspect_name, officer_id, officer_name, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Aberto', CURRENT_DATE)
    ]]
    
    local params = {
        occurrenceNumber,
        data.type or 'Roubo',
        data.description,
        data.location,
        data.applicant_id or nil,
        data.applicant_name or nil,
        data.suspect_id or nil,
        data.suspect_name or nil,
        user_id,
        officerName
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            
            -- Atualizar estatísticas na tabela ftpolice_stats
            local today = os.date('%Y-%m-%d')
            local statsQuery = "INSERT INTO ftpolice_stats (date, type, count) VALUES (?, 'occurrences', 1) ON DUPLICATE KEY UPDATE count = count + 1"
            local statsParams = {today}
            
            exports.oxmysql:execute(statsQuery, statsParams, function(statsResult)
                if statsResult then
                    
                    -- Notificar todos os clientes sobre a atualização das estatísticas
                    TriggerClientEvent('updateStatistics', -1)
                else
                end
            end)
            
            -- Atualizar estatísticas do dia (mantido para compatibilidade)
            UpdateDailyStats(os.date('%Y-%m-%d'))
        else
        end
    end)
end)

-- Atualizar estatísticas quando histórico é salvo
local originalSaveHistory = SavePlayerHistory
function SavePlayerHistory(playerId, type, description, amount, months, officerId, officerName)
    -- Chamar função original
    originalSaveHistory(playerId, type, description, amount, months, officerId, officerName)
    
    -- Atualizar estatísticas do dia
    UpdateDailyStats(os.date('%Y-%m-%d'))
end

-- ===== SISTEMA DE PROCURADOS =====

-- Event para buscar pessoas procuradas
RegisterNetEvent('getWantedUsers')
AddEventHandler('getWantedUsers', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        SELECT id, name, description, last_seen, location, photo, created_at, status
        FROM ftpolice_wanted_users 
        WHERE status = 'Ativo'
        ORDER BY created_at DESC
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local wantedUsers = {}
            for _, row in ipairs(result) do
                table.insert(wantedUsers, {
                    id = row.id,
                    name = row.name,
                    description = row.description,
                    lastSeen = row.last_seen,
                    location = row.location,
                    photo = row.photo,
                    date = os.date('%d/%m/%Y', os.time(os.date('*t', os.time())))
                })
            end
            TriggerClientEvent('receiveData:getWantedUsers', source, wantedUsers)
        else
            TriggerClientEvent('receiveData:getWantedUsers', source, {})
        end
    end)
end)

-- Event para buscar veículos procurados
RegisterNetEvent('getWantedVehicles')
AddEventHandler('getWantedVehicles', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        SELECT id, model, specifications, last_seen, location, created_at, status
        FROM ftpolice_wanted_vehicles 
        WHERE status = 'Ativo'
        ORDER BY created_at DESC
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local wantedVehicles = {}
            for _, row in ipairs(result) do
                table.insert(wantedVehicles, {
                    id = row.id,
                    model = row.model,
                    specifications = row.specifications,
                    lastSeen = row.last_seen,
                    location = row.location,
                    date = os.date('%d/%m/%Y', os.time(os.date('*t', os.time())))
                })
            end
            TriggerClientEvent('receiveData:getWantedVehicles', source, wantedVehicles)
        else
            TriggerClientEvent('receiveData:getWantedVehicles', source, {})
        end
    end)
end)

-- Event para adicionar pessoa procurada
RegisterNetEvent('addWantedUser')
AddEventHandler('addWantedUser', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.name or not data.description or not data.lastSeen or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftpolice_wanted_users 
        (name, description, last_seen, location, photo, officer_id, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, 'Ativo', CURRENT_TIMESTAMP)
    ]]
    
    local params = {
        data.name,
        data.description,
        data.lastSeen,
        data.location,
        data.photo or nil,
        user_id
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de procurados para todos os policiais
            TriggerClientEvent('updateWantedUsers', -1)
            -- Atualizar status de procurado na busca
            TriggerClientEvent('updatePlayerHistory', -1)
        else
        end
    end)
end)

-- Event para adicionar veículo procurado
RegisterNetEvent('addWantedVehicle')
AddEventHandler('addWantedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.model or not data.specifications or not data.lastSeen or not data.location then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        INSERT INTO ftpolice_wanted_vehicles 
        (model, specifications, last_seen, location, officer_id, status, created_at)
        VALUES (?, ?, ?, ?, ?, 'Ativo', CURRENT_TIMESTAMP)
    ]]
    
    local params = {
        data.model,
        data.specifications,
        data.lastSeen,
        data.location,
        user_id
    }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de veículos procurados para todos os policiais
            TriggerClientEvent('updateWantedVehicles', -1)
        else
        end
    end)
end)

-- Event para remover pessoa procurada (marcar como capturada)
RegisterNetEvent('removeWantedUser')
AddEventHandler('removeWantedUser', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        UPDATE ftpolice_wanted_users 
        SET status = 'Capturado', updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de procurados para todos os policiais
            TriggerClientEvent('updateWantedUsers', -1)
            -- Atualizar status de procurado na busca
            TriggerClientEvent('updatePlayerHistory', -1)
        else
        end
    end)
end)

-- Event para remover veículo procurado (marcar como recuperado)
RegisterNetEvent('removeWantedVehicle')
AddEventHandler('removeWantedVehicle', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        UPDATE ftpolice_wanted_vehicles 
        SET status = 'Recuperado', updated_at = CURRENT_TIMESTAMP
        WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de veículos procurados para todos os policiais
            TriggerClientEvent('updateWantedVehicles', -1)
        else
        end
    end)
end)

-- ===== SISTEMA DE BOLETINS DE OCORRÊNCIA (B.O.) =====

-- Event para buscar B.O.s do banco de dados
RegisterNetEvent('getOccurrences')
AddEventHandler('getOccurrences', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getOccurrences', source, {})
        return 
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        TriggerClientEvent('receiveData:getOccurrences', source, {})
        return
    end
    
    local query = [[
        SELECT id, occurrence_number, type, description,
               applicant_name, suspect_name, officer_id, officer_name, 
               COALESCE(status, 'Aberto') as status, 
               created_at
        FROM ftpolice_bo 
        ORDER BY created_at DESC
        LIMIT 50
    ]]
    
    exports.oxmysql:execute(query, {}, function(result)
        if result then
            local occurrences = {}
            for _, row in ipairs(result) do
                local status = row.status or "Aberto"
                if status == "" then
                    status = "Aberto"
                end
                table.insert(occurrences, {
                    id = row.id,
                    occurrenceNumber = row.occurrence_number,
                    type = row.type,
                    description = row.description,
                    location = row.location or "Local não informado",
                    applicantName = row.applicant_name or "Não informado",
                    suspectName = row.suspect_name or "Não informado",
                    officerId = row.officer_id,
                    officerName = row.officer_name,
                    status = status,
                    date = os.date('%d/%m/%Y', os.time())
                })
            end
            TriggerClientEvent('receiveData:getOccurrences', source, occurrences)
        else
            TriggerClientEvent('receiveData:getOccurrences', source, {})
        end
    end)
end)

-- Verificar e criar tabela se necessário
RegisterNetEvent('checkAndCreateTable')
AddEventHandler('checkAndCreateTable', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local checkQuery = [[
        SELECT COUNT(*) as count FROM information_schema.tables 
        WHERE table_schema = DATABASE() AND table_name = 'ftpolice_bo'
    ]]
    
    exports.oxmysql:execute(checkQuery, {}, function(result)
        if result and result[1] and result[1].count == 0 then
            
            local createQuery = [[
                CREATE TABLE IF NOT EXISTS `ftpolice_bo` (
                  `id` int(11) NOT NULL AUTO_INCREMENT,
                  `occurrence_number` varchar(50) NOT NULL,
                  `type` varchar(100) NOT NULL DEFAULT 'Boletim de Ocorrência',
                  `description` text NOT NULL,
                  `applicant_id` int(11) DEFAULT NULL,
                  `applicant_name` varchar(255) DEFAULT NULL,
                  `suspect_id` int(11) DEFAULT NULL,
                  `suspect_name` varchar(255) DEFAULT NULL,
                  `officer_id` int(11) NOT NULL,
                  `officer_name` varchar(255) NOT NULL,
                  `status` enum('Aberto','Em Andamento','Resolvido','Arquivado') NOT NULL DEFAULT 'Aberto',
                  `created_at` date NOT NULL DEFAULT (CURRENT_DATE),
                  `updated_at` date DEFAULT NULL,
                  PRIMARY KEY (`id`),
                  KEY `officer_id` (`officer_id`),
                  KEY `applicant_id` (`applicant_id`),
                  KEY `suspect_id` (`suspect_id`),
                  KEY `created_at` (`created_at`),
                  KEY `status` (`status`),
                  UNIQUE KEY `occurrence_number` (`occurrence_number`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            ]]
            
            exports.oxmysql:execute(createQuery, {}, function(createResult)
                if createResult then
                else
                end
            end)
        else
        end
    end)
end)

-- Event para atualizar status do boletim de ocorrência
RegisterNetEvent('updateOccurrenceStatus')
AddEventHandler('updateOccurrenceStatus', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = false, message = "Usuário não identificado" })
        return 
    end
    
    if not data or not data.id or not data.status then
        TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = false, message = "Dados inválidos" })
        return
    end
    
    -- Verificar se o usuário tem permissão para atualizar boletins
    local playerRank = GetPlayerRank(user_id)
    if not playerRank or playerRank > 10 then
        TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = false, message = "Você não tem permissão para alterar o status de boletins." })
        return
    end

    -- Tentar atualizar no banco de dados
    if GetResourceState('oxmysql') == 'started' then
        exports.oxmysql:execute('UPDATE ftpolice_bo SET status = ? WHERE id = ?', {
            data.status,
            data.id
        }, function(result)
            if result and result.affectedRows > 0 then
                -- Status atualizado com sucesso
                TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = true, message = "Status atualizado com sucesso" })
                
                -- Atualizar lista de B.O.s para todos os policiais
                TriggerClientEvent('updateOccurrences', -1)
            else
                TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = false, message = "Erro ao atualizar status do boletim" })
            end
        end)
    else
        TriggerClientEvent('receiveData:updateOccurrenceStatus', source, { success = false, message = "Sistema de banco de dados não disponível" })
    end
end)


RegisterNetEvent('deleteOccurrence')
AddEventHandler('deleteOccurrence', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then return end
    
    if not data or not data.id then
        return
    end
    
    if not GetResourceState('oxmysql') == 'started' then
        return
    end
    
    local query = [[
        DELETE FROM ftpolice_bo WHERE id = ?
    ]]
    
    local params = { data.id }
    
    exports.oxmysql:execute(query, params, function(result)
        if result then
            -- Atualizar lista de B.O.s para todos os policiais
            TriggerClientEvent('updateOccurrences', -1)
        else
        end
    end)
end)



-- Event para verificar permissões de páginas
RegisterNetEvent('checkPagePermission')
AddEventHandler('checkPagePermission', function(page)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('pagePermissionResult', source, false)
        return 
    end
    
    local canAccess = CanAccessPage(user_id, page)
    TriggerClientEvent('pagePermissionResult', source, canAccess)
end)

-- Event para obter informações da patente do jogador
RegisterNetEvent('getPlayerRankInfo')
AddEventHandler('getPlayerRankInfo', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('playerRankInfo', source, nil)
        return 
    end
    
    -- Verificar se tem permissão de policial
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    
    if not hasPermission then
        TriggerClientEvent('playerRankInfo', source, nil)
        return
    end
    
    -- Sempre buscar o rank atualizado da DB
    local rank = Database.GetPlayerRank(user_id)
    
    -- Se tem permissão mas não está na tabela, enviar dados padrão com acesso total
    if not rank then
        local defaultData = {
            rank = 1, -- Rank 1 (Secretário) em vez de 0
            name = "Secretário",
            label = "Secretário",
            restrictedPages = {}, -- Sem páginas restritas = acesso total
            permissions = {
                canHire = true,
                canFire = true,
                canPromote = true,
                canDemote = true,
                canAnnounce = true,
                canWanted = true,
                canRemoveWanted = true,
                canViewHistory = true,
                canEditHistory = true,
                canViewStats = true,
                canViewMembers = true,
                canEditMembers = true,
                canPrison = true,
                canFine = true,
                canSearch = true,
                canLocked = true
            }
        }
        
        TriggerClientEvent('playerRankInfo', source, defaultData)
        return
    end
    
    local rankInfo = Config.Hierarchy[rank]
    
    if not rankInfo then
        TriggerClientEvent('playerRankInfo', source, nil)
        return
    end
    
    local data = {
        rank = rank,
        name = rankInfo.name,
        label = rankInfo.label,
        restrictedPages = rankInfo.restrictedPages or {},
        permissions = rankInfo.permissions or {}
    }
    
    TriggerClientEvent('playerRankInfo', source, data)
end)

-- Event para verificar permissão de abertura do painel
RegisterNetEvent('fortal_police:checkPanelPermission')
AddEventHandler('fortal_police:checkPanelPermission', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('fortal_police:panelPermissionResult', source, false)
        return 
    end
    
    -- Verificar se tem permissão de policial
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission, 2)
    
    if hasPermission then
        TriggerClientEvent('fortal_police:panelPermissionResult', source, true)
        return
    end
    
    -- Se não tem permissão, verificar se está na tabela de membros
    local rank = GetPlayerRank(user_id)
    local finalPermission = rank ~= nil
    
    -- Enviar resultado para o cliente
    TriggerClientEvent('fortal_police:panelPermissionResult', source, finalPermission)
end)

-- Event para buscar estatísticas do oficial
RegisterNetEvent('getOfficerStats')
AddEventHandler('getOfficerStats', function(officerId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if user_id then
        
        -- Buscar informações do membro
        local memberQuery = [[
            SELECT 
                user_id,
                name,
                charge,
                rank,
                join_date,
                status
            FROM ftpolice_members 
            WHERE user_id = ?
        ]]
        
        local memberResult = exports.oxmysql:executeSync(memberQuery, {officerId})
        
        if memberResult and memberResult[1] then
            local member = memberResult[1]
            
            -- Usar função do banco de dados para obter estatísticas
            local stats = Database.GetOfficerCompleteStats(officerId)
            
            -- Adicionar informações do membro
            stats.user_id = member.user_id
            stats.name = member.name
            stats.charge = member.charge
            stats.rank = member.rank
            stats.join_date = member.join_date
            stats.status = member.status
            
            
            -- Usar valores padrão para informações pessoais (já que não temos vrp_user_identities)
            stats.phone = "Não informado"
            stats.passport = officerId
            stats.age = "Não informado"
            stats.weapon_license = "Não"
            stats.full_name = stats.name or "Não informado"
            
            -- Tentar buscar informações pessoais usando vRP
            local identity = Utils.functions.getUserIdentity(officerId)
            if identity then
                -- Telefone (phone se existir, senão serial como fallback)
                if identity.phone then
                    stats.phone = identity.phone
                elseif identity.serial then
                    stats.phone = identity.serial
                end
                
                -- Idade
                if identity.age then
                    stats.age = tostring(identity.age)
                end
                
                -- Nome completo
                if identity.name and identity.name2 then
                    stats.full_name = identity.name .. " " .. identity.name2
                elseif identity.name then
                    stats.full_name = identity.name
                end
            else
            end
            
            
            -- Status de procurado (usando valor padrão já que ftpolice_wanted_users não existe)
            stats.is_wanted = false
            stats.wanted_status = "Não"
            
            TriggerClientEvent('receiveData:getOfficerStats', source, stats)
        else
            TriggerClientEvent('receiveData:getOfficerStats', source, {})
        end
    else
        TriggerClientEvent('receiveData:getOfficerStats', source, {})
    end
end)

-- Event para buscar histórico do oficial
RegisterNetEvent('getOfficerHistory')
AddEventHandler('getOfficerHistory', function(officerId)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if user_id then
        
        -- Usar função do banco de dados para obter histórico
        local history = Database.GetOfficerHistory(officerId, 50)
        
        if history and #history > 0 then
            TriggerClientEvent('receiveData:getOfficerHistory', source, history)
        else
            TriggerClientEvent('receiveData:getOfficerHistory', source, {})
        end
    else
        TriggerClientEvent('receiveData:getOfficerHistory', source, {})
    end
end)

function CanPerformAction(user_id, action)
    
    if not user_id then 
        return false 
    end
    
    local rank = GetPlayerRank(user_id)
    
    if not rank then 
        return false 
    end
    
    local rankInfo = Config.Hierarchy[rank]
    
    if not rankInfo or not rankInfo.permissions then 

        return false 
    end
    
    local hasPermission = rankInfo.permissions[action] == true

    
    return hasPermission
end

RegisterNetEvent('removeHistory')
AddEventHandler('removeHistory', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        return 
    end
    
    -- Verificar permissão
    if not CanPerformAction(user_id, 'canEditHistory') then

        TriggerClientEvent("Notify", source, "negado", "Você não tem permissão para editar histórico!", 5000)
        return
    end
    
    local playerId = tonumber(data.playerId)
    local historyId = tonumber(data.id)
    local historyTime = data.time
    
    
    if not playerId or not historyId then
        TriggerClientEvent('Notify', source, 'negado', 'Dados inválidos!')
        return
    end
    
    -- Extrair valores do tempo/valor (ex: "10/5000" -> amount = 5000)
    local amount = 0
    if historyTime and type(historyTime) == 'string' then
        local parts = {}
        for part in historyTime:gmatch("[^/]+") do
            table.insert(parts, part)
        end
        if #parts >= 2 then
            amount = tonumber(parts[2]) or 0
        end
    end
    
    
    -- Excluir registro diretamente usando LIMIT 1
    local query = [[
        DELETE FROM ftpolice_history 
        WHERE player_id = ? AND officer_id = ? AND amount = ? 
        ORDER BY created_at DESC LIMIT 1
    ]]
    
    
    exports.oxmysql:execute(query, {playerId, historyId, amount}, function(result)
        
        if result and result.affectedRows and result.affectedRows > 0 then
            
            -- Notificar o usuário
            TriggerClientEvent('Notify', source, 'sucesso', 'Registro removido com sucesso!')
            
            -- Atualizar dados do jogador para todos os clientes
            TriggerClientEvent('updatePlayerHistory', -1, playerId)
        else
            TriggerClientEvent('Notify', source, 'negado', 'Erro ao remover registro!')
        end
    end)
end)

RegisterNetEvent('getOptionsOccurrence')
AddEventHandler('getOptionsOccurrence', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        TriggerClientEvent('receiveData:getOptionsOccurrence', source, {applicant = {}, suspects = {}})
        return 
    end
    
    local applicant = {}
    local suspects = {}
    
    local nearbyPlayers = GetNearbyPlayers(source, 12.0)
    for _, player in pairs(nearbyPlayers) do
        table.insert(applicant, {
            id = tonumber(player.passport),
            name = player.name
        })

        table.insert(suspects, {
            id = tonumber(player.passport),
            name = player.name
        })
    end
    
    local options = {
        applicant = applicant,
        suspects = suspects
    }

    TriggerClientEvent('receiveData:getOptionsOccurrence', source, options)
end)

-- Event para atualizar permissões
RegisterNetEvent('getPermissions')
AddEventHandler('getPermissions', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then 
        return 
    end
    
    -- Buscar rank do jogador
    local rank = GetPlayerRank(user_id)
    if not rank then
        return
    end
    
    -- Buscar permissões baseadas no rank
    local rankInfo = Config.Hierarchy[rank]
    if not rankInfo then
        return
    end
    
    -- Enviar informações completas do rank para o cliente (igual ao DIP)
    local data = {
        rank = rank,
        name = rankInfo.name,
        label = rankInfo.label,
        restrictedPages = rankInfo.restrictedPages or {},
        permissions = rankInfo.permissions or {}
    }
    
    -- Enviar dados completos para o cliente
    TriggerClientEvent('playerRankInfo', source, data)
end)

-- Comando de debug para verificar status do jogador
RegisterCommand('checkpolice', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    -- Verificar se tem permissão de policial
    local hasPermission = Utils.functions.hasPermission(user_id, Config.DefaultPermission)
    
    -- Verificar rank na tabela
    local rank = GetPlayerRank(user_id)
    
    -- Verificar se está na tabela de membros
    local query = [[
        SELECT * FROM ftpolice_members 
        WHERE user_id = ?
    ]]
    
    local result = exports.oxmysql:executeSync(query, {user_id})
    
    local message = string.format("Status: Permissão=%s, Rank=%s, NaTabela=%s", 
        tostring(hasPermission), 
        tostring(rank or "N/A"), 
        tostring(result and #result > 0))
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", message}
    })
end, false)

-- Comando para adicionar jogador à tabela de membros
RegisterCommand('addpolice', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    -- Verificar se já está na tabela
    local checkQuery = [[
        SELECT * FROM ftpolice_members 
        WHERE user_id = ?
    ]]
    
    local checkResult = exports.oxmysql:executeSync(checkQuery, {user_id})
    
    if checkResult and #checkResult > 0 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 0},
            multiline = true,
            args = {"Sistema", "Jogador já está na tabela de membros"}
        })
        return
    end
    
    -- Obter nome do jogador
    local identity = Utils.functions.getUserIdentity(user_id)
    local playerName = "Jogador " .. user_id
    
    if identity then
        if identity.name and identity.name2 then
            playerName = identity.name .. " " .. identity.name2
        elseif identity.name then
            playerName = identity.name
        end
    end
    
    -- Inserir na tabela
    local insertQuery = [[
        INSERT INTO ftpolice_members (user_id, name, charge, rank, status, join_date)
        VALUES (?, ?, ?, ?, ?, CURRENT_DATE)
    ]]
    
    local success = exports.oxmysql:executeSync(insertQuery, {
        user_id, 
        playerName, 
        "Policial", 
        1, -- Rank 1 (Secretário)
        "Ativo"
    })
    
    if success then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Sistema", "Jogador adicionado à tabela de membros com rank 1 (Secretário)"}
        })
        
        -- Atualizar permissões imediatamente
        TriggerClientEvent('playerRankInfo', source, {
            rank = 1,
            name = "Secretário",
            label = "Secretário",
            restrictedPages = {},
            permissions = {
                canHire = true,
                canFire = true,
                canPromote = true,
                canDemote = true,
                canAnnounce = true,
                canWanted = true,
                canRemoveWanted = true,
                canViewHistory = true,
                canEditHistory = true,
                canViewStats = true,
                canViewMembers = true,
                canEditMembers = true,
                canPrison = true,
                canFine = true,
                canSearch = true,
                canLocked = true
            }
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro ao adicionar jogador à tabela"}
        })
    end
end, false)

-- Comando para popular estatísticas de exemplo
RegisterCommand('populatestats', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    -- Verificar se tem permissão
    if not CanPerformAction(user_id, 'canEditHistory') then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Você não tem permissão para executar este comando!"}
        })
        return
    end
    
    
    -- Inserir dados de exemplo na tabela ftpolice_stats
    local currentDate = os.date('%Y-%m-%d')
    local yesterday = os.date('%Y-%m-%d', os.time() - 86400)
    
    local statsData = {
        {date = currentDate, type = 'arrests', count = 5},
        {date = currentDate, type = 'fines', count = 12},
        {date = currentDate, type = 'seized_vehicles', count = 3},
        {date = currentDate, type = 'occurrences', count = 8},
        {date = currentDate, type = 'working_hours', count = 8},
        {date = yesterday, type = 'arrests', count = 3},
        {date = yesterday, type = 'fines', count = 7},
        {date = yesterday, type = 'seized_vehicles', count = 1},
        {date = yesterday, type = 'occurrences', count = 5},
        {date = yesterday, type = 'working_hours', count = 6}
    }
    
    local successCount = 0
    for _, stat in ipairs(statsData) do
        -- Usar a função diretamente do módulo Database
        local success = Database.RecordOfficerStat(stat.date, stat.type, stat.count)
        if success then
            successCount = successCount + 1
        end
    end
    
    local message = string.format("Estatísticas populadas: %d/%d registros inseridos com sucesso", successCount, #statsData)
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", message}
    })
    
end, false)

-- Comando alternativo para popular estatísticas de exemplo (sem depender do módulo Database)
RegisterCommand('populatestats2', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    -- Verificar se tem permissão
    if not CanPerformAction(user_id, 'canEditHistory') then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Você não tem permissão para executar este comando!"}
        })
        return
    end
    
    
    -- Inserir dados de exemplo na tabela ftpolice_stats
    local currentDate = os.date('%Y-%m-%d')
    local yesterday = os.date('%Y-%m-%d', os.time() - 86400)
    
    local statsData = {
        {date = currentDate, type = 'arrests', count = 5},
        {date = currentDate, type = 'fines', count = 12},
        {date = currentDate, type = 'seized_vehicles', count = 3},
        {date = currentDate, type = 'occurrences', count = 8},
        {date = currentDate, type = 'working_hours', count = 8},
        {date = yesterday, type = 'arrests', count = 3},
        {date = yesterday, type = 'fines', count = 7},
        {date = yesterday, type = 'seized_vehicles', count = 1},
        {date = yesterday, type = 'occurrences', count = 5},
        {date = yesterday, type = 'working_hours', count = 6}
    }
    
    local successCount = 0
    for _, stat in ipairs(statsData) do
        -- Inserir diretamente usando oxmysql
        local query = [[
            INSERT INTO ftpolice_stats (date, type, count)
            VALUES (?, ?, ?)
            ON DUPLICATE KEY UPDATE
            count = count + VALUES(count),
            updated_at = CURRENT_TIMESTAMP
        ]]
        
        local success = exports.oxmysql:executeSync(query, {stat.date, stat.type, stat.count})
        if success ~= nil then
            successCount = successCount + 1
        end
    end
    
    local message = string.format("Estatísticas populadas (v2): %d/%d registros inseridos com sucesso", successCount, #statsData)
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", message}
    })
    
end, false)

-- Comando de teste para verificar se as funções do módulo Database estão funcionando
RegisterCommand('testdatabase', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    
    -- Verificar se o módulo está disponível
    if not Database then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Módulo Database não está disponível"}
        })
        return
    end
    
    
    -- Verificar funções específicas
    local functions = {
        'GetPlayerRank',
        'GetOfficerCompleteStats',
        'GetOfficerHistory',
        'RecordOfficerStat',
        'RecordOfficerAction'
    }
    
    local availableFunctions = {}
    for _, funcName in ipairs(functions) do
        if Database[funcName] then
            table.insert(availableFunctions, funcName)
        else
        end
    end
    
    local message = string.format("Funções disponíveis: %d/%d - %s", 
        #availableFunctions, 
        #functions, 
        table.concat(availableFunctions, ', '))
    
    TriggerClientEvent('chat:addMessage', source, {
        color = {0, 255, 0},
        multiline = true,
        args = {"Sistema", message}
    })
    
end, false)

-- Comando para popular estatísticas específicas para o ID 5
-- Comando removido - usando ftpolice_officer_stats agora

-- Comando para verificar e adicionar o ID 5 na tabela de membros
RegisterCommand('setupid5', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    
    local targetId = 5
    
    -- Verificar se o ID 5 já está na tabela
    local checkQuery = [[
        SELECT * FROM ftpolice_members 
        WHERE user_id = ?
    ]]
    
    local checkResult = exports.oxmysql:executeSync(checkQuery, {targetId})
    
    if checkResult and #checkResult > 0 then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 255, 0},
            multiline = true,
            args = {"Sistema", "ID 5 já está na tabela de membros"}
        })
    else
        -- Adicionar o ID 5 na tabela
        local insertQuery = [[
            INSERT INTO ftpolice_members (user_id, name, charge, rank, status, join_date)
            VALUES (?, ?, ?, ?, ?, CURRENT_DATE)
        ]]
        
        local success = exports.oxmysql:executeSync(insertQuery, {
            targetId, 
            "Rm Dev", 
            "Policial", 
            1, -- Rank 1 (Secretário)
            "Ativo"
        })
        
        if success then
            TriggerClientEvent('chat:addMessage', source, {
                color = {0, 255, 0},
                multiline = true,
                args = {"Sistema", "ID 5 adicionado à tabela de membros com rank 1 (Secretário)"}
            })
        else
            TriggerClientEvent('chat:addMessage', source, {
                color = {255, 0, 0},
                multiline = true,
                args = {"Sistema", "Erro ao adicionar ID 5 à tabela"}
            })
        end
    end
    
    -- Tabela vrp_user_identities não existe neste servidor - usando ID como passaporte
end, false)

-- Comando para alterar a tabela ftpolice_stats e adicionar user_id
RegisterCommand('fixstats', function(source, args, rawCommand)
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro: Jogador não identificado"}
        })
        return
    end
    
    
    -- Adicionar coluna user_id se não existir
    local alterQuery = [[
        ALTER TABLE ftpolice_stats 
        ADD COLUMN user_id INT DEFAULT NULL,
        ADD COLUMN officer_name VARCHAR(100) DEFAULT NULL
    ]]
    
    local success = exports.oxmysql:executeSync(alterQuery, {})
    
    if success then
        TriggerClientEvent('chat:addMessage', source, {
            color = {0, 255, 0},
            multiline = true,
            args = {"Sistema", "Tabela ftpolice_stats corrigida com sucesso!"}
        })
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Sistema", "Erro ao corrigir tabela"}
        })
    end
end, false)

RegisterCommand('populatestats5', function(source, args)
    if source == 0 then
        
        -- Inserir dados na tabela ftpolice_officer_stats
        local insertQuery = [[
            INSERT INTO ftpolice_officer_stats 
            (user_id, arrests_made, fines_applied, total_fines_value, total_working_hours, vehicles_seized, reports_registered) 
            VALUES (?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
            arrests_made = VALUES(arrests_made),
            fines_applied = VALUES(fines_applied),
            total_fines_value = VALUES(total_fines_value),
            total_working_hours = VALUES(total_working_hours),
            vehicles_seized = VALUES(vehicles_seized),
            reports_registered = VALUES(reports_registered)
        ]]
        
        local result = exports.oxmysql:executeSync(insertQuery, {
            5, -- user_id
            15, -- arrests_made
            25, -- fines_applied
            15000.00, -- total_fines_value
            120, -- total_working_hours
            8, -- vehicles_seized
            12 -- reports_registered
        })
        
        if result then
        else
        end
    end
end, false)

-- Comando para criar a tabela ftpolice_officer_stats se não existir
RegisterCommand('createtable', function(source, args)
    if source == 0 then
        
        local createTableQuery = [[
            CREATE TABLE IF NOT EXISTS ftpolice_officer_stats (
                user_id INT(11) NOT NULL,
                arrests_made INT(11) DEFAULT 0,
                fines_applied INT(11) DEFAULT 0,
                total_fines_value DECIMAL(10,2) DEFAULT 0.00,
                total_working_hours INT(11) DEFAULT 0,
                vehicles_seized INT(11) DEFAULT 0,
                reports_registered INT(11) DEFAULT 0,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                PRIMARY KEY (user_id)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4
        ]]
        
        local result = exports.oxmysql:executeSync(createTableQuery)
        
        if result then
        else
        end
    end
end, false)

-- Comando para popular estatísticas específicas para o ID 5

-- Comando para atualizar cargos dos membros existentes para usar labels
RegisterCommand('updatecharges', function(source, args)
    if source == 0 then
        
        local updateQuery = [[
            UPDATE ftpolice_members 
            SET charge = CASE rank
        ]]
        
        -- Construir a query dinamicamente baseada na configuração
        for rank, rankData in pairs(Config.Hierarchy) do
            updateQuery = updateQuery .. string.format(" WHEN %d THEN '%s'", rank, rankData.label)
        end
        
        updateQuery = updateQuery .. " ELSE charge END WHERE status = 'Ativo'"
        
        local result = exports.oxmysql:executeSync(updateQuery)
        
        if result then
            -- Recarregar membros para todos
            SendUpdatedMembers()
        else
        end
    end
end, false)

-- Event para obter cargos disponíveis para contratação
RegisterNetEvent('getChargeContract')
AddEventHandler('getChargeContract', function()
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:getChargeContract', source, {})
        return 
    end
    
    -- Verificar se tem permissão para contratar
    local rank = Database.GetPlayerRank(user_id)
    
    if not rank then
        TriggerClientEvent('receiveData:getChargeContract', source, {})
        return
    end
    
    local rankConfig = Config.Hierarchy[rank]
    
    if not rankConfig or not rankConfig.permissions or not rankConfig.permissions.canHire then
        TriggerClientEvent('receiveData:getChargeContract', source, {})
        return
    end
    
    -- Retornar cargos disponíveis baseado no rank do contratante
    local availableCharges = {}
    
    
    for chargeRank, chargeData in pairs(Config.Hierarchy) do
        -- Na sua configuração, rank 1 é o mais alto, então pode contratar cargos de rank maior ou igual
        if chargeRank >= rank then
            local charge = {
                name = chargeData.name,
                desc = chargeData.label or chargeData.name,
                rank = chargeRank,
                salary = chargeData.salary or 0
            }
            table.insert(availableCharges, charge)
        else
        end
    end
    
    
    -- Ordenar por rank (menor para maior)
    table.sort(availableCharges, function(a, b)
        return a.rank < b.rank
    end)
    
    TriggerClientEvent('receiveData:getChargeContract', source, availableCharges)
end)

-- Event para buscar jogador específico (usado no modal de suspeito)
RegisterNetEvent('searchPlayer')
AddEventHandler('searchPlayer', function(searchTerm)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    
    if not user_id then 
        TriggerClientEvent('receiveData:searchPlayer', source, {})
        return 
    end
    
    local searchResults = {}
    local searchLower = string.lower(tostring(searchTerm))
    
    
    -- Buscar por ID ou nome
    local id = 1
    local consecutiveEmpty = 0
    local maxConsecutiveEmpty = 200
    
    while consecutiveEmpty < maxConsecutiveEmpty do
        local playerData = GetPlayerSearchData(id)
        if playerData then
            local playerName = string.lower(playerData.name or "")
            local playerId = tostring(playerData.passport or "")
            
            -- Verificar se corresponde ao termo de busca
            if string.find(playerName, searchLower) or string.find(playerId, searchLower) then
                table.insert(searchResults, {
                    id = tonumber(playerData.passport),
                    name = playerData.name,
                    passport = playerData.passport,
                    photo = playerData.photo
                })
            end
            
            consecutiveEmpty = 0
        else
            consecutiveEmpty = consecutiveEmpty + 1
        end
        
        id = id + 1
    end
    
    -- Retornar apenas os resultados, sem wrapper
    TriggerClientEvent('receiveData:searchPlayer', source, searchResults)
end)

-- Event para iniciar captura de foto (chamado pelo frontend)
RegisterNetEvent('startPhotoCapture')
AddEventHandler('startPhotoCapture', function(data)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id then
        return
    end
    
    local targetUserId = data.targetUserId
    if not targetUserId then
        return
    end
    -- Enviar comando para o cliente iniciar a captura
    TriggerClientEvent('startPhotoCapture', source, targetUserId)
end)

-- Event para salvar foto capturada
RegisterNetEvent('saveSuspectPhoto')
AddEventHandler('saveSuspectPhoto', function(targetUserId, photoData)
    local source = source
    local user_id = Utils.functions.getUserId(source)
    
    if not user_id or not targetUserId or not photoData then
        return
    end
    
    -- Salvar ou atualizar foto no banco
    saveSuspectPhoto(targetUserId, photoData, function(success)
        if success then
            TriggerClientEvent('photoSaved', source, true)
        else
            TriggerClientEvent('photoSaved', source, false)
        end
    end)
end)

-- Função para salvar foto do suspeito (usando callback)
function saveSuspectPhoto(userId, photoData, callback)
    exports.oxmysql:execute('INSERT INTO ftpolice_imagens (user_id, photo) VALUES (?, ?) ON DUPLICATE KEY UPDATE photo = ?', {
        userId, 
        photoData, 
        photoData
    }, function(affectedRows)
        local success = false
        if type(affectedRows) == "table" then
            success = affectedRows.affectedRows and affectedRows.affectedRows > 0
        else
            success = affectedRows and affectedRows > 0
        end
        if callback then
            callback(success)
        end
    end)
end





