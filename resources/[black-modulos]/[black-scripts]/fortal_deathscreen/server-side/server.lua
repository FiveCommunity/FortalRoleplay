function src.getDeathTimer()
	local source = source 
	local user_id = Utils.functions.getUserId(source) 
	local deathTimer = 300

	if user_id then
		if Utils.functions.hasGroup(user_id, "Rm") then
			return 10
		end

		for k,v in pairs(Config.deathTimers) do 
			if k ~= "default" and Utils.functions.hasGroup(user_id, k) then 
				deathTimer = v 
				break 
			end 	
		end
	end

	return deathTimer
end

function src.clearInventory()
   local source = source
   local user_id = vRP.getUserId(source)
   	if user_id then
		TriggerEvent("inventory:clearWeapons",user_id)
		vRP.clearInventory(user_id)

		if vPLAYER.getHandcuff(source) then
			vPLAYER.toggleHandcuff(source)
		end
   	end
end	
