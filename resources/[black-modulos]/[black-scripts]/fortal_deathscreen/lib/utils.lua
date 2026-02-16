
if IsDuplicityVersion() then 
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRPC = Tunnel.getInterface("vRP")
    vRP = Proxy.getInterface("vRP")
    vPLAYER = Tunnel.getInterface("coreP")
    src = {}
    Tunnel.bindInterface("survival",src)
    clientAPI = Tunnel.getInterface("survival")
else
    local Tunnel = module("vrp","lib/Tunnel")
    local Proxy = module("vrp","lib/Proxy")
    vRP = Proxy.getInterface("vRP")
    vRPS = Tunnel.getInterface("vRP")
    src = {}
    Tunnel.bindInterface("survival",src)
    serverAPI = Tunnel.getInterface("survival")
end 