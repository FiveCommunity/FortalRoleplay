if Config.Framework ~= "vrp" then
    return
end

CreateThread(function()
    while not NetworkIsSessionStarted() do
        Wait(500)
    end

    loaded = true

    function HasPhoneItem(number)

        if exports["coreP"].handCuff() then
            return false
        end
        
        if IsPedDeadOrDying(PlayerPedId(), false) then
            return false
        end

        local health = GetEntityHealth(PlayerPedId())
        if health <= 110 then
            return false
        end

        if exports["fortal_prisao"]:checkPrison() then
            return false
        end
    
        if not Config.Item.Require then
            return true
        end
    
        if Config.Item.Unique then
            return HasPhoneNumber(number)
        end
    
        if GetResourceState("ox_inventory") == "started" and Config.Item.Inventory == "ox_inventory" then
            local itemCount = exports.ox_inventory:Search("count", Config.Item.Name) or 0
            return itemCount > 0
        end
    
        return true
    end

    function HasJob(jobs)
        return false
    end

    ---Apply vehicle mods
    ---@param vehicle number
    ---@param vehicleData table
    function ApplyVehicleMods(vehicle, vehicleData)
    end

    ---Create a vehicle and apply vehicle mods
    ---@param vehicleData table
    ---@param coords vector3
    ---@return number? vehicle
    function CreateFrameworkVehicle(vehicleData, coords)
    end

    -- Company app
    function GetCompanyData(cb)
        cb {}
    end

    function DepositMoney(amount, cb)
        cb(false)
    end

    function WithdrawMoney(amount, cb)
        cb(false)
    end

    function HireEmployee(source, cb)
        cb(false)
    end

    function FireEmployee(identifier, cb)
        cb(false)
    end

    function SetGrade(identifier, newGrade, cb)
        cb(false)
    end

    function ToggleDuty()
        return false
    end
end)
