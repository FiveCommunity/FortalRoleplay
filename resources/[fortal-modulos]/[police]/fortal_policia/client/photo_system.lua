-- Sistema de captura de foto para suspeitos
local isCapturingPhoto = false
local targetUserId = nil

-- Event para iniciar captura de foto
RegisterNetEvent('startPhotoCapture')
AddEventHandler('startPhotoCapture', function(userId)
    targetUserId = userId
    
    -- Fechar NUI primeiro
    SendNUIMessage({
        action = 'setVisibility',
        data = nil
    })
    SetNuiFocus(false, false)
    
    -- Aguardar um pouco para a NUI fechar
    Citizen.Wait(500)
    
    -- Iniciar captura
    startPhotoCapture()
end)

-- Event para confirmar que a foto foi salva
RegisterNetEvent('photoSaved')
AddEventHandler('photoSaved', function(success)
    if success then
        SendNUIMessage({
            action = 'photoSaved',
            success = true
        })
        
        -- Atualizar lista de jogadores para mostrar a nova foto
        TriggerServerEvent('getPlayers')
    else
        SendNUIMessage({
            action = 'photoSaved',
            success = false
        })
    end
end)

function startPhotoCapture()
    if isCapturingPhoto then
        return
    end
    
    isCapturingPhoto = true
    
    -- Mudar para primeira pessoa rapidamente
    SetFollowPedCamViewMode(4) -- Primeira pessoa
    SetCamViewModeForContext(0, 4)
    
    -- Mostrar instruções
    TriggerEvent("Notify", "importante", "Pressione ENTER para tirar a foto ou ESC para cancelar", 5000)
    
    -- Iniciar loop de captura
    Citizen.CreateThread(function()
        while isCapturingPhoto do
            Citizen.Wait(0)
            
            -- Verificar se pressionou ENTER
            if IsControlJustPressed(0, 191) then -- ENTER
                takePhoto()
                break
            end
            
            -- Verificar se pressionou ESC
            if IsControlJustPressed(0, 322) then -- ESC
                cancelPhotoCapture()
                break
            end
        end
    end)
end

function takePhoto()
    -- Mostrar notificação de captura
    TriggerEvent("Notify", "sucesso", "Capturando foto...", 2000)
    
    -- Usar sistema nativo do FiveM para captura
    Citizen.CreateThread(function()
        -- Salvar targetUserId em variável local para não perder no callback
        local currentTargetUserId = targetUserId
        
        -- Forçar primeira pessoa de forma mais rápida
        for i = 1, 10 do
            SetFollowPedCamViewMode(4) -- Primeira pessoa
            SetCamViewModeForContext(0, 4)
            Citizen.Wait(10)
        end
        
        -- Aguardar menos tempo para ser mais fluido
        Citizen.Wait(200)
        
        -- Verificar se realmente está em primeira pessoa
        local camMode = GetFollowPedCamViewMode()
        if camMode ~= 4 then
            -- Se não estiver em primeira pessoa, forçar novamente
            for i = 1, 5 do
                SetFollowPedCamViewMode(4)
                SetCamViewModeForContext(0, 4)
                Citizen.Wait(20)
            end
            Citizen.Wait(100)
        end
        
        -- Capturar screenshot usando sistema nativo
        local success = pcall(function()
            -- Usar exports do screenshot-basic se disponível
            if GetResourceState('screenshot-basic') == 'started' then
                -- Forçar primeira pessoa uma última vez antes de capturar
                SetFollowPedCamViewMode(4)
                SetCamViewModeForContext(0, 4)
                Citizen.Wait(100) -- Aguardar menos tempo para ser mais fluido
                
                -- Usar exports do screenshot-basic
                exports['screenshot-basic']:requestScreenshotUpload('https://discord.com/api/webhooks/1417139028913819679/aikuQlnAYovlrdaXUr9u6knUKVB3fH2prla7YaaoCsVokHFmtcGF6jnp722tn6TQel4Z', 'image/png', function(data)
                    -- Fazer parse do JSON se for string
                    local parsedData = data
                    if type(data) == "string" then
                        parsedData = json.decode(data)
                    end
                    
                    if parsedData and parsedData.attachments and parsedData.attachments[1] and parsedData.attachments[1].url then
                        -- Enviar foto para o servidor
                        local photoUrl = parsedData.attachments[1].url
                        TriggerServerEvent('saveSuspectPhoto', currentTargetUserId, photoUrl)
                        TriggerEvent("Notify", "sucesso", "Foto capturada com sucesso!", 3000)
                    else
                        TriggerEvent("Notify", "negado", "Erro ao processar foto - URL não encontrada", 3000)
                    end
                    
                    -- SÓ DEPOIS de processar a foto, voltar para terceira pessoa
                    Citizen.Wait(200) -- Aguardar processamento da foto (reduzido para ser mais fluido)
                    SetFollowPedCamViewMode(1) -- Terceira pessoa
                    SetCamViewModeForContext(0, 1)
                    
                    -- Reabrir a UI após voltar para terceira pessoa
                    SendNUIMessage({
                        action = 'setVisibility',
                        data = '/panel'
                    })
                    SetNuiFocus(true, true)
                end)
            else
                -- Fallback: simular foto capturada (para teste)
                local fakePhotoUrl = "https://via.placeholder.com/800x600/000000/FFFFFF?text=Foto+do+Suspeito"
                TriggerServerEvent('saveSuspectPhoto', currentTargetUserId, fakePhotoUrl)
                TriggerEvent("Notify", "sucesso", "Foto capturada com sucesso! (Modo teste)", 3000)
                
                -- Voltar para terceira pessoa
                SetFollowPedCamViewMode(1) -- Terceira pessoa
                SetCamViewModeForContext(0, 1)
                
                -- Reabrir a UI após voltar para terceira pessoa
                SendNUIMessage({
                    action = 'setVisibility',
                    data = '/panel'
                })
                SetNuiFocus(true, true)
            end
        end)
        
        if not success then
            TriggerEvent("Notify", "negado", "Erro ao capturar foto", 3000)
        end
        
        -- Finalizar captura após tentativa
        isCapturingPhoto = false
        targetUserId = nil
    end)
end

function cancelPhotoCapture()
    isCapturingPhoto = false
    targetUserId = nil
    
    -- Restaurar câmera para terceira pessoa
    SetFollowPedCamViewMode(1) -- Terceira pessoa
    SetCamViewModeForContext(0, 1)
    
    -- Reabrir a UI imediatamente
    SendNUIMessage({
        action = 'setVisibility',
        data = '/panel'
    })
    SetNuiFocus(true, true)
    
    TriggerEvent("Notify", "aviso", "Captura de foto cancelada", 3000)
end
