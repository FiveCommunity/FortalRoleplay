Utils = {}

Utils.functions = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,
    hasGroup = function(user_id,group)
        return vRP.hasGroup(user_id,group)
    end
}

RegisterCommand('kill', function(source, args)
    local playerId = vRP.getUserId(source)
    if playerId and vRP.hasPermission(playerId, 'Admin') then
        local playerToSet = args[1] and tonumber(args[1]) or playerId

        local playerSource = vRP.userSource(playerToSet)
        if playerSource then
            vRPC.setHealth(playerSource, 101)

            exports["config"]:SendLog("Kill",user_id,playerToSet,{})
        end
    end
end)

RegisterCommand("armour", function(source, args, rawCommand)
    local user_id = vRP.getUserId(source)
    if user_id then
        if vRP.hasPermission(user_id, "Admin") then
            if args[1] then
                local nplayer = vRP.getUserSource(parseInt(args[1]))
                if nplayer then
                    vRPC.setArmour(nplayer, 100)
                    TriggerClientEvent("resetBleeding", nplayer)
                    TriggerClientEvent("resetDiagnostic", nplayer)
                    SendWebhookMessage(webhookosarmour,
                        "```prolog\n[ARMOUR]\n[ID:] " ..
                        user_id ..
                        "\n[ID QUE RECEBEU:] " ..
                        parseInt(args[1]) .. "\n" .. os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
                end
            else
                vRPC.setArmour(source, 100)
                TriggerClientEvent("resetBleeding", source)
                TriggerClientEvent("resetDiagnostic", source)
                SendWebhookMessage(webhookosarmour,
                    "```prolog\n[ARMOUR]\n[ID:] " ..
                    user_id ..
                    "\n[ID QUE RECEBEU:] " ..
                    parseInt(args[1]) .. "\n" .. os.date("[Data]: %d/%m/%Y [Hora]: %H:%M:%S") .. " \r```")
            end
        end
    end
end)

 RegisterCommand("re", function(source, args, rawCommand)
     local user_id = vRP.getUserId(source)
     if user_id then
         if vRP.hasPermission(user_id, "Paramedic") or vRP.hasPermission(user_id, "Police") then
             local nplayer = vRPC.nearestPlayer(source, 2)
             if nplayer then
                 if not vCLIENT.deadPlayer(source) then
                     if vCLIENT.deadPlayer(nplayer) then
                         TriggerClientEvent("Progress", source, 10000)
                         TriggerClientEvent("cancelando", source, true)
                         vRPC._playAnim(source, false, { "mini@cpr@char_a@cpr_str", "cpr_pumpchest" }, true)
                         SetTimeout(10000, function()
                             vRPC._removeObjects(source)
                             vCLIENT._revivePlayer(nplayer, 110)
                             TriggerClientEvent("resetBleeding", nplayer)
                             TriggerClientEvent("cancelando", source, false)
                         end)
                     end
                 end
             end
         end
     end
 end)
