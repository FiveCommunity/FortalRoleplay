if Config.Framework ~= "vrp" then
    return
end
local Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPC = Tunnel.getInterface("vRP")

local API = {}
API["getUserId"] = vRP.getUserId
API["itemAmount"] = vRP.itemAmount;
API["userIdentity"] = vRP.userIdentity;
API["userList"] = vRP.userList;
API["userBank"] = vRP.userBank;
API["addBank"] = vRP.addBank;
API["delBank"] = vRP.delBank;
API["query"] = vRP.query;
API["prepare"] = vRP.prepare;
API["userPlate"] = vRP.userPlate;
API["hasPermission"] = vRP.hasPermission;
API["userInventory"] = vRP.userInventory;
API["checkBroken"] = vRP.checkBroken;
local jobGroups = {
    ["Police"]= "Policial",
    ["Paramedic"]= "Paramedico",
    ["Taxi"]= "Taxista",
    ["Mechanic"]= "Mecanico"
}
local CLIENT_API = {}
CLIENT_API["createObjects"] = vRPC.createObjects
CLIENT_API["removeObjects"] = vRPC.removeObjects

function GetIdentifier(source)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    return playerId
end

function HasPhoneItem(source, number)
    if not Config.Item.Require then
        return true
    end

    local playerId = API["getUserId"](source)
    if not playerId then return false end
    if API["itemAmount"](playerId,Config.Item.Name) == 0 then return false end
    return true
end

function GetCharacterName(source)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    local identity = API["userIdentity"](playerId)
    if not identity then return "" end
    return identity["name"]
end

function GetEmployees(job)
    local tableList = {}
    for user_id, source in pairs(API["userList"]()) do
		if vRP.hasPermission(user_id, job) then
			table.insert(tableList, source)
		end
	end
    return tableList
end

function GetBalance(source)
    local playerId = API["getUserId"](source)
    if not playerId then return false end

    return tonumber(API["userBank"](playerId).bank) or 0
end

function AddMoney(source, amount)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    API["addBank"](playerId,amount)
    return true
end

function RemoveMoney(source, amount)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    if (API["userBank"](playerId).bank < tonumber(amount)) then return false end
    API["delBank"](playerId,amount)
    return true
end

function Notify(source, message)
    TriggerClientEvent("Notify",source,"important","Atenção",message,"amarelo",5000)
end

--vRP.prepare("vehicles/getVehicles","SELECT * FROM vehicles WHERE user_id = @user_id")
function GetPlayerVehicles(source)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    local playerVehicles = {}
    local vehicle = API["query"]("vehicles/getVehicles",{ user_id = playerId })
    for k,v in ipairs(vehicle) do
        if vehicle[k]["vehicle"] and vehicle[k]["work"] == "false" then
            local formatObj= { 
                plate = vehicle[k]["plate"],
                type= vehicleType(vehicle[k]["vehicle"]),
                model = vehicle[k]["vehicle"], 
                location = "Garagem",
                statistics = {
                    engine = tonumber(vehicle[k]["engine"])/10,
                    body = tonumber(vehicle[k]["body"])/10,
                    fuel = tonumber(vehicle[k]["fuel"]),
                }   
            }
            if tonumber(vehicle[k]["arrest"]) > 0 then 
                formatObj.impounded = true
                formatObj.pound = "Impound"
                formatObj.impoundReason = "Apriendido" 
                formatObj.location = "Garagem da Policia"
            end
            table.insert(playerVehicles,formatObj)
        end
    end
    return playerVehicles
end

function GetVehicle(source, plate)
    local vehicle = API["userPlate"](plate)
    if not vehicle then return false end
    return vehicle.model
end

function IsAdmin(source)
    local playerId = API["getUserId"](source)
    if not playerId then return false end
    if not (API["hasPermission"](playerId,"Admin") or API["hasPermission"](playerId,"Moderador")) then return false end
    return true
end

function GetJob(source)
    --[[ local playerId = API["getUserId"](source)
    if not playerId then return false end
    for k,v in pairs(jobGroups) do
        if API["hasPermission"](playerId, k)  then 
            return v
        end
    end ]]

    local playerId = API["getUserId"](source)

    for _, infos in pairs(Config.Companies.Services) do
        if vRP.hasPermission(playerId, infos.job) then
            return infos.job
        end
    end
end

API["numPermission"] = vRP.getUsersByPermission;

function RefreshCompanies()
    for i = 1, #Config.Companies.Services do
        local jobData = Config.Companies.Services[i]

        jobData.open = #API["numPermission"](jobData.job)
    end
end

vRP.prepare('vRP/getLbPhone', 'select phone_number from phone_phones where owner_id = @playerId')
function getPhoneData(playerId)
    local result = vRP.query('vRP/getLbPhone', {
        playerId = playerId
    })

    if type(result) == 'table' and result[1] then
        local formattedNumber = exports['lb-phone']:FormatNumber(result[1].phone_number)

        return formattedNumber
    end
end

AddEventHandler('playerConnect', function(playerId)
    local identity = vRP.userIdentity(playerId)
    local playerPhone = getPhoneData(playerId)

    if identity and playerPhone then
        if identity.phone ~= playerPhone then
            vRP.upgradePhone(playerId, playerPhone)
        end
    end
end)