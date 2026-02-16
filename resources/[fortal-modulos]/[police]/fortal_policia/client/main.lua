local isUIOpen = false
local tabletProp = nil

local tabletConfig = {
    dict = "amb@code_human_in_bus_passenger_idles@female@tablet@base",
    anim = "base", 
    prop = "prop_cs_tablet",
    flag = 50,
    mao = 28422
}

function LoadAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function createObjects(dict, anim, prop, flag, mao)
    local ped = PlayerPedId()
    LoadAnimDict(dict)
    
    TaskPlayAnim(ped, dict, anim, 3.0, 3.0, -1, flag, 0, false, false, false)

    local coords = GetEntityCoords(ped)
    local object = CreateObject(GetHashKey(prop), coords.x, coords.y, coords.z + 0.2, true, true, true)
    
    AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, mao), 0.03, 0.002, -0.02, 10.0, 160.0, 0.0, true, true, false, true, 1, true)

    return object
end

function removeObjects(object)
    if object and DoesEntityExist(object) then
        DeleteEntity(object)
    end
end

function stopAnimation()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
end

function ToggleUI()
    isUIOpen = not isUIOpen
    SetNuiFocus(isUIOpen, isUIOpen)

    if isUIOpen then
        tabletProp = createObjects(tabletConfig.dict, tabletConfig.anim, tabletConfig.prop, tabletConfig.flag, tabletConfig.mao)
        
        SendNUIMessage({
            action = 'setVisibility',
            data = '/panel'
        })

        SendNUIMessage({
            action = 'setColor',
            data = '42, 82, 242'
        })
        
        -- Forçar atualização das permissões sempre que abrir o painel
        TriggerServerEvent('getPlayerRankInfo')
    else
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
        
        SendNUIMessage({
            action = 'setVisibility',
            data = nil
        })
    end
end

RegisterNUICallback('checkPanelPermission', function(data, cb)
    TriggerServerEvent('fortal_police:checkPanelPermission')

    local received = false
    local function onReceive(hasPermission)
        if not received then
            received = true
            cb({hasPermission = hasPermission})
        end
    end
    
    RegisterNetEvent('fortal_police:panelPermissionResult', onReceive)
    
    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            cb({hasPermission = false})
        end
    end)
end)

-- Evento para fechar o painel da polícia
RegisterNetEvent('fortal_police:closePanel')
AddEventHandler('fortal_police:closePanel', function()
    isUIOpen = false
    SetNuiFocus(false, false)
    
    if tabletProp then
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
    end
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
end)

-- Substituir o comando e evento de abrir painel para funcionar igual ao DIP
RegisterCommand(Config.Command, function()
    TriggerServerEvent('fortal_police:checkPanelPermission')
    
    local received = false
    
    local function onReceive(hasPermission)
        if not received then
            received = true
         
            if hasPermission then
                -- Buscar rank atualizado da DB antes de abrir o painel
                TriggerServerEvent('getPlayerRankInfo')
                ToggleUI()
            else
                TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o painel policial!')
            end
        end
    end
    
    -- Registrar temporariamente para este comando
    RegisterNetEvent('fortal_police:panelPermissionResult', onReceive)

    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            TriggerEvent('Notify', 'negado', 'Erro ao verificar permissão!')
        end
    end)
end)

-- Evento para abrir o painel via item
RegisterNetEvent('fortal_police:openPanel')
AddEventHandler('fortal_police:openPanel', function()
    TriggerServerEvent('fortal_police:checkPanelPermission')
    
    local received = false
    
    local function onReceive(hasPermission)
        if not received then
            received = true
         
            if hasPermission then
                -- Buscar rank atualizado da DB antes de abrir o painel
                TriggerServerEvent('getPlayerRankInfo')
                ToggleUI()
            else
                TriggerEvent('Notify', 'negado', 'Você não tem permissão para acessar o painel policial!')
            end
        end
    end
    
    -- Registrar temporariamente para este evento
    RegisterNetEvent('fortal_police:panelPermissionResult', onReceive)

    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            TriggerEvent('Notify', 'negado', 'Erro ao verificar permissão!')
        end
    end)
end)

local currentPolicePermissions = {}



-- Evento para receber informações do rank (igual ao DIP)
RegisterNetEvent('playerRankInfo')
AddEventHandler('playerRankInfo', function(rankInfo)
    if rankInfo then
        currentPolicePermissions = rankInfo.permissions or {}
        
        -- Enviar informações do rank para a interface (sempre atualizado)
        SendNUIMessage({
            type = 'playerRankInfo',
            data = rankInfo
        })
    else
        currentPolicePermissions = {}
        SendNUIMessage({
            type = 'playerRankInfo',
            data = {}
        })
    end
end)

RegisterNUICallback('nuiReady', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('removeFocus', function(data, cb)
    isUIOpen = false
    SetNuiFocus(false, false)
    
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
    cb('ok')
end)

RegisterNUICallback('getPlayers', function(data, cb)
    TriggerServerEvent('getPlayers')
    
    local received = false
    
    local function onReceive(players)
        if not received then
            received = true
            cb(players or {})
        end
    end

    RegisterNetEvent('receiveData:getPlayers', onReceive)
  
    Citizen.SetTimeout(15000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getPlayerData', function(data, cb)
    if data and data.playerId then
        TriggerServerEvent('getPlayerData', data.playerId)

        local received = false
        
        local function onReceive(playerData)
            if not received then
                received = true
                cb(playerData or {})
            end
        end
        
        RegisterNetEvent('receiveData:getPlayerData', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNUICallback('getWarns', function(data, cb)
    TriggerServerEvent('getWarns')
    
    local received = false
    
    local function onReceive(warns)
        if not received then
            received = true
            cb(warns or {})
        end
    end
    
    RegisterNetEvent('receiveData:getWarns', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getStatistics', function(data, cb)
    TriggerServerEvent('getStatistics')

    local received = false
    
    local function onReceive(statistics)
        if not received then
            received = true
            cb(statistics or {})
        end
    end

    RegisterNetEvent('receiveData:getStatistics', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(10000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('createAnnounce', function(data, cb)
    if data and data.title and data.message then
        TriggerServerEvent('createAnnounce', data)
        
        local received = false
        
        local function onReceive(newWarn)
            if not received then
                received = true
                cb(newWarn or {})
            end
        end
        
        -- Registrar handler temporário
        RegisterNetEvent('receiveData:createAnnounce', onReceive)
        
        Citizen.SetTimeout(5000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNUICallback('getOptions', function(data, cb)
    TriggerServerEvent('getOptions')
    
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {suspect = {}, infractions = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getOptions', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({suspect = {}, infractions = {}})
        end
    end)
end)

RegisterNUICallback('getOptionsFine', function(data, cb)
    TriggerServerEvent('getOptionsFine')
    
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {suspect = {}, infractions = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getOptions', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({suspect = {}, infractions = {}})
        end
    end)
end)

RegisterNUICallback('getMembers', function(data, cb)
    TriggerServerEvent('fortal_police:getMembers')
    
    local received = false
    
    local function onReceive(members)
        if not received then
            received = true
            cb(members or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('fortal_police:receiveData:getMembers', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callbacks com dados mockados para evitar erros
RegisterNUICallback('getOptionsOccurrence', function(data, cb)
    TriggerServerEvent('getOptionsOccurrence')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(options)
        if not received then
            received = true
            cb(options or {applicant = {}, suspects = {}})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getOptionsOccurrence', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({applicant = {}, suspects = {}})
        end
    end)
end)

RegisterNUICallback('getOccurrences', function(data, cb)
    TriggerServerEvent('getOccurrences')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(occurrences)
        if not received then
            received = true
            cb(occurrences or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getOccurrences', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getWantedUsers', function(data, cb)
    TriggerServerEvent('getWantedUsers')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(wantedUsers)
        if not received then
            received = true
            cb(wantedUsers or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getWantedUsers', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

RegisterNUICallback('getWantedVehicles', function(data, cb)
    TriggerServerEvent('getWantedVehicles')
    
    -- Aguardar resposta do servidor
    local received = false
    
    local function onReceive(wantedVehicles)
        if not received then
            received = true
            cb(wantedVehicles or {})
        end
    end
    
    -- Registrar handler temporário
    RegisterNetEvent('receiveData:getWantedVehicles', onReceive)
    
    -- Timeout de segurança
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callbacks de ação
RegisterNUICallback('confirmPrison', function(data, cb)
    if data and data.users then
        TriggerServerEvent('confirmPrison', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'prison'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)

RegisterNUICallback('confirmFine', function(data, cb)
    if data and data.users then
        TriggerServerEvent('confirmFine', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'fine'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)

RegisterNUICallback('applyFine', function(data, cb)
    if data and data.users then
        TriggerServerEvent('applyFine', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'applyFine'
        })
        
        -- Limpar seleções
        SendNUIMessage({
            action = 'clearSelections',
            data = {
                suspects = {},
                infractions = {}
            }
        })
    end
    cb('ok')
end)


RegisterNUICallback('confirmWantedUser', function(data, cb)
    if data and data.name and data.description and data.lastSeen and data.location then
        TriggerServerEvent('addWantedUser', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'wantedUser'
        })
    end
    cb('ok')
end)

RegisterNUICallback('addWantedUser', function(data, cb)
    if data and data.name and data.description and data.lastSeen and data.location then
        TriggerServerEvent('addWantedUser', data)
    end
    cb('ok')
end)

RegisterNUICallback('confirmWantedVehicle', function(data, cb)
    if data and data.model and data.specifications and data.lastSeen and data.location then
        TriggerServerEvent('addWantedVehicle', data)
        
        -- Fechar apenas o modal de confirmação
        SendNUIMessage({
            action = 'closeModal',
            data = 'wantedVehicle'
        })
    end
    cb('ok')
end)

RegisterNUICallback('addWantedVehicle', function(data, cb)
    if data and data.model and data.specifications and data.lastSeen and data.location then
        TriggerServerEvent('addWantedVehicle', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeWantedUser', function(data, cb)
    if data and data.id then
        TriggerServerEvent('removeWantedUser', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeWantedVehicle', function(data, cb)
    if data and data.id then
        TriggerServerEvent('removeWantedVehicle', data)
    end
    cb('ok')
end)

RegisterNUICallback('addMember', function(data, cb)
    if data and data.id then
        TriggerServerEvent('addMember', data)
    end
    cb('ok')
end)

RegisterNUICallback('hireMember', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_police:hireMember', data)
    end
    cb('ok')
end)

RegisterNUICallback('fortal_police:hireMember', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_police:hireMember', data)
    end
    cb('ok')
end)

RegisterNUICallback('leaveOrg', function(data, cb)
    TriggerServerEvent('leaveOrg')
    cb('ok')
end)

RegisterNUICallback('deleteWarn', function(data, cb)
    cb('ok')
end)

-- Callbacks adicionais
RegisterNUICallback('watchPlayer', function(data, cb)
    cb('ok')
end)

RegisterNUICallback('promotePlayer', function(data, cb)
    if data and data.id and data.rank then
        TriggerServerEvent('fortal_police:promotePlayer', data)
    end

    cb('ok')
end)

RegisterNUICallback('demotePlayer', function(data, cb)
    if data and data.id and data.rank then
        TriggerServerEvent('fortal_police:demotePlayer', data)
    end

    cb('ok')
end)

RegisterNUICallback('removePlayer', function(data, cb)
    if data and data.id then
        TriggerServerEvent('fortal_police:removePlayer', data)
    end
    cb('ok')
end)

RegisterNUICallback('removeHistory', function(data, cb)
    if data then
        TriggerServerEvent('removeHistory', data)
    end
    cb('ok')
end)

-- Callback para atualizar status do boletim de ocorrência via HTTP
RegisterNUICallback('updateOccurrenceStatus', function(data, cb)
    local statusData = data
    if not statusData or not statusData.id or not statusData.status then
        cb({ success = false, message = "Dados do status não fornecidos" })
        return
    end
    
    -- Enviar evento para o servidor
    TriggerServerEvent('updateOccurrenceStatus', statusData)
    
    -- Aguardar resposta do servidor
    local received = false
    RegisterNetEvent('receiveData:updateOccurrenceStatus')
    AddEventHandler('receiveData:updateOccurrenceStatus', function(response)
        if not received then
            received = true
            cb(response)
        end
    end)
    
    -- Timeout de segurança
    SetTimeout(5000, function()
        if not received then
            received = true
            cb({ success = false, message = "Erro de conexão" })
        end
    end)
end)

RegisterNUICallback('deleteOccurrence', function(data, cb)
    if data and data.id then
        TriggerServerEvent('deleteOccurrence', data)
    end
    cb('ok')
end)

RegisterNUICallback('checkTable', function(data, cb)
    TriggerServerEvent('checkAndCreateTable')
    cb('ok')
end)

RegisterNUICallback('checkPagePermission', function(data, cb)
    if data and data.page then
        TriggerServerEvent('checkPagePermission', data.page)
        
        local received = false
        
        local function onReceive(canAccess)
            if not received then
                received = true
                cb({canAccess = canAccess})
            end
        end
        
        RegisterNetEvent('pagePermissionResult', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({canAccess = false})
            end
        end)
    else
        cb({canAccess = false})
    end
end)

RegisterNUICallback('getPlayerRankInfo', function(data, cb)
    TriggerServerEvent('getPlayerRankInfo')

    local received = false
    
    local function onReceive(rankInfo)
        if not received then
            received = true
            cb(rankInfo or {})
        end
    end

    RegisterNetEvent('playerRankInfo', onReceive)
    
    Citizen.SetTimeout(3000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callback para buscar estatísticas do oficial
RegisterNUICallback('getOfficerStats', function(data, cb)
    if data and data.officerId then
        TriggerServerEvent('getOfficerStats', data.officerId)
        
        local received = false
        
        local function onReceive(stats)
            if not received then
                received = true
                cb(stats or {})
            end
        end
        
        RegisterNetEvent('receiveData:getOfficerStats', onReceive)
        
        Citizen.SetTimeout(10000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNUICallback('getOfficerHistory', function(data, cb)
    if data and data.id then
        TriggerServerEvent('getOfficerHistory', data.id)
        
        local received = false
        
        local function onReceive(history)
            if not received then
                received = true
                cb(history or {})
            end
        end
        
        RegisterNetEvent('receiveData:getOfficerHistory', onReceive)
        
        Citizen.SetTimeout(3000, function()
            if not received then
                received = true
                cb({})
            end
        end)
    else
        cb({})
    end
end)

RegisterNetEvent('receiveData:getPlayers')
RegisterNetEvent('receiveData:getWarns')
RegisterNetEvent('receiveData:createAnnounce')
RegisterNetEvent('receiveData:deleteAnnounce')
RegisterNetEvent('receiveData:getOptions')
RegisterNetEvent('receiveData:getMembers')
RegisterNetEvent('receiveData:getWantedUsers')
RegisterNetEvent('receiveData:getWantedVehicles')
RegisterNetEvent('receiveData:getOccurrences')

RegisterNetEvent('updateStatistics')
AddEventHandler('updateStatistics', function()
    SendNUIMessage({
        action = 'updateStatistics',
        data = {}
    })
end)

RegisterNetEvent('updateWarns')
AddEventHandler('updateWarns', function(warns)
    
    SendNUIMessage({
        action = 'updateWarns',
        data = warns
    })

end)

RegisterNetEvent('receiveData:deleteAnnounce')
AddEventHandler('receiveData:deleteAnnounce', function(data)
    SendNUIMessage({
        action = 'deleteAnnounce',
        data = data
    })
end)

RegisterNetEvent('newWarnNotification')
AddEventHandler('newWarnNotification', function(data)
    if data and data.title and data.author then end
end)

RegisterNetEvent('updateWantedUsers')
AddEventHandler('updateWantedUsers', function()
    TriggerServerEvent('getWantedUsers')
end)

RegisterNetEvent('updateWantedVehicles')
AddEventHandler('updateWantedVehicles', function()
    TriggerServerEvent('getWantedVehicles')
end)

RegisterNetEvent('updateOccurrences')
AddEventHandler('updateOccurrences', function()
    TriggerServerEvent('getOccurrences')
end)

RegisterNetEvent('updateMembers')
AddEventHandler('updateMembers', function()
    TriggerServerEvent('fortal_police:getMembers')
end)

RegisterNetEvent('fortal_police:updatePermissions')
AddEventHandler('fortal_police:updatePermissions', function()
    -- Forçar atualização das permissões no frontend
    SendNUIMessage({
        action = 'updatePermissions',
        data = {}
    })
    
    -- Fechar o painel se estiver aberto para forçar recarregamento
    if isUIOpen then
        isUIOpen = false
        SetNuiFocus(false, false)
        
        stopAnimation()
        removeObjects(tabletProp)
        tabletProp = nil
        
        SendNUIMessage({
            action = 'setVisibility',
            data = nil
        })
    end
end)



RegisterNetEvent('fortal_police:receivePermissions')
AddEventHandler('fortal_police:receivePermissions', function(permissions)
    -- Enviar permissões atualizadas para a interface
    SendNUIMessage({
        action = 'updatePermissions',
        data = permissions
    })
end)

RegisterNetEvent('fortal_police:closeNUI')
AddEventHandler('fortal_police:closeNUI', function()
    isUIOpen = false
    SetNuiFocus(false, false)
    
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
end)

RegisterNetEvent('closeNUI')
AddEventHandler('closeNUI', function()
    isUIOpen = false
    SetNuiFocus(false, false)
    
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
end)

RegisterNetEvent('showPrisonTime')
AddEventHandler('showPrisonTime', function(months, fine)
    if months and fine then
        SendNUIMessage({
            action = 'setTime',
            data = {
                month = tostring(months),
                fine = fine
            }
        })
        
        SendNUIMessage({
            action = 'setVisibility',
            data = '/time'
        })
    end
end)

RegisterNetEvent('showFineAmount')
AddEventHandler('showFineAmount', function(amount)
    TriggerEvent('Notify', 'negado', 'Você foi multado em $' .. amount)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isUIOpen then
            if IsControlJustPressed(0, 322) then -- ESC
                isUIOpen = false
                SetNuiFocus(false, false)
                
                -- Parar animação e remover prop do tablet
                stopAnimation()
                removeObjects(tabletProp)
                tabletProp = nil
                
                SendNUIMessage({
                    action = 'setVisibility',
                    data = nil
                })
            end
        end
    end
end)

exports('IsUIOpen', function()
    return isUIOpen
end)

exports('ToggleUI', function()
    ToggleUI()
end)

RegisterNUICallback('closeNUI', function(data, cb)

    isUIOpen = false
    SetNuiFocus(false, false)
    
    -- Parar animação e remover prop do tablet
    stopAnimation()
    removeObjects(tabletProp)
    tabletProp = nil
    
    -- Enviar mensagem para esconder a interface
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })

    if cb then
        cb('ok')
    end
end)

-- Event para receber dados atualizados de procurados
RegisterNetEvent('receiveData:getWantedUsers')
AddEventHandler('receiveData:getWantedUsers', function(wantedUsers)
    SendNUIMessage({
        action = 'updateWantedUsers',
        data = wantedUsers or {}
    })
end)

-- Event para receber dados atualizados de veículos procurados
RegisterNetEvent('receiveData:getWantedVehicles')
AddEventHandler('receiveData:getWantedVehicles', function(wantedVehicles)
    SendNUIMessage({
        action = 'updateWantedVehicles',
        data = wantedVehicles or {}
    })
end)

-- Event para receber dados atualizados de B.O.s
RegisterNetEvent('receiveData:getOccurrences')
AddEventHandler('receiveData:getOccurrences', function(occurrences)
    SendNUIMessage({
        action = 'updateOccurrences',
        data = occurrences or {}
    })
end)

-- Event para receber dados atualizados de membros
RegisterNetEvent('receiveData:getMembers')
AddEventHandler('receiveData:getMembers', function(members)
    SendNUIMessage({
        action = 'updateMembers',
        data = members or {}
    })
end)

-- Event para receber dados atualizados de membros (evento global)
RegisterNetEvent('fortal_police:receiveData:getMembers')
AddEventHandler('fortal_police:receiveData:getMembers', function(members)
    SendNUIMessage({
        action = 'updateMembers',
        data = members or {}
    })
end)

-- Event para atualizar histórico de jogador
RegisterNetEvent('updatePlayerHistory')
AddEventHandler('updatePlayerHistory', function(playerId)
    TriggerServerEvent('getPlayerData', playerId)
    
    SendNUIMessage({
        action = 'updatePlayerHistory',
        data = { playerId = playerId }
    })
end)

-- Callback para solicitar informações do jogador
RegisterNUICallback('requestPlayerInfo', function(data, cb)
    TriggerServerEvent('getPlayerRankInfo')
    cb('ok')
end)

-- Callback para obter cargos disponíveis para contratação
RegisterNUICallback('getChargeContract', function(data, cb)
    TriggerServerEvent('getChargeContract')
    
    local received = false
    
    local function onReceive(charges)
        if not received then
            received = true
            cb(charges or {})
        end
    end
    
    RegisterNetEvent('receiveData:getChargeContract', onReceive)
    
    Citizen.SetTimeout(5000, function()
        if not received then
            received = true
            cb({})
        end
    end)
end)

-- Callback para deletar anúncio via HTTP
RegisterNUICallback('deleteAnnounce', function(data, cb)
    local announceId = data and data.announceId
    if not announceId then
        cb({ success = false, message = "ID do anúncio não fornecido" })
        return
    end
    
    -- Enviar evento para o servidor
    TriggerServerEvent('deleteAnnounce', announceId)
    
    -- Aguardar resposta do servidor
    local received = false
    RegisterNetEvent('receiveData:deleteAnnounce')
    AddEventHandler('receiveData:deleteAnnounce', function(response)
        if not received then
            received = true
            cb(response)
        end
    end)
    
    -- Timeout de segurança
    SetTimeout(5000, function()
        if not received then
            received = true
            cb({ success = false, message = "Erro de conexão" })
        end
    end)
end)

-- Callback para criar boletim de ocorrência via HTTP
RegisterNUICallback('createOccurrence', function(data, cb)
    local occurrenceData = data and data.occurrenceData
    if not occurrenceData then
        cb({ success = false, message = "Dados do boletim não fornecidos" })
        return
    end
    
    -- Enviar evento para o servidor
    TriggerServerEvent('createOccurrence', occurrenceData)
    
    -- Aguardar resposta do servidor
    local received = false
    RegisterNetEvent('receiveData:createOccurrence')
    AddEventHandler('receiveData:createOccurrence', function(response)
        if not received then
            received = true
            cb(response)
        end
    end)
    
    -- Timeout de segurança
    SetTimeout(5000, function()
        if not received then
            received = true
            cb({ success = false, message = "Erro de conexão" })
        end
    end)
end)

-- Callback para iniciar captura de foto
RegisterNUICallback('startPhotoCapture', function(data, cb)
    local targetUserId = data and data.targetUserId
    if not targetUserId then
        cb({ success = false, message = "ID do suspeito não fornecido" })
        return
    end
    
    
    -- Enviar evento para o servidor
    TriggerServerEvent('startPhotoCapture', data)
    
    -- Resposta imediata (não precisamos aguardar resposta do servidor para esta ação)
    cb({ success = true, message = "Captura de foto iniciada" })
end)