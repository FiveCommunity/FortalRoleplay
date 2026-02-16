Utils = {}

Utils.functions = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,
    getUserIdentity = function(user_id)
        return vRP.userIdentity(user_id)
    end,
    getUserName = function(user_id)
        local identity = Utils.functions.getUserIdentity(user_id)
        if identity then
            return identity["name"].." "..identity["name2"]
        end
        return "Usuário"
    end,
    getUserBank = function(user_id)
        return vRP.getBank(user_id)
    end,
    removeBank = function(user_id, amount)
        local query = vRP.query("bank/getInfos", { user_id = user_id })
        print("^3[FORTAL_BANK] Query result:", json.encode(query))
        if query[1] and query[1]["bank"] then
            local currentBank = query[1]["bank"]
            local newBank = currentBank - amount
            print("^3[FORTAL_BANK] Current bank:", currentBank, "New bank:", newBank)
            if newBank >= 0 then
                local executeResult = vRP.execute("bank/RemBank", { user_id = user_id, amount = amount })
                print("^3[FORTAL_BANK] Execute result:", executeResult)
                return true
            end
        end
        return false
    end
}
