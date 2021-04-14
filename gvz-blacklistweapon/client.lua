Citizen.CreateThread(function()
	while true do
		local sleep = 1
        Citizen.Wait(sleep)
		
        local playerPed = GetPlayerPed(-1)
        local nothing, weapon = GetCurrentPedWeapon(playerPed, true)
        local blacklisted, name = isWeaponBlacklisted(weapon)

		if blacklisted then
			RemoveWeaponFromPed(playerPed, weapon)
            if Config.BlacklistWeaponLog then
                TriggerServerEvent('blacklist:dclog', 'Yasaklı Silah Alındı : '..name)
            end
            if Config.KickPlayer then
                TriggerServerEvent('blacklist:drop')
            end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(Config.BlacklistedWeapons) do
		if model == GetHashKey(blacklistedWeapon) then
			return true, blacklistedWeapon
		end
	end

	return false, nil
end

