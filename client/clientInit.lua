Citizen.CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent('KOTH:ClientInitialized', KOTH.GetPlayerLevel(), KOTH.GetPlayerXP())
			Citizen.Wait(1000)
			KOTH.SetNutral()
			TriggerEvent("KOTH:OpenStartUi")
			NetworkSetFriendlyFireOption(true)
    	SetCanAttackFriendly(PlayerPedId(), true, true)
			return
		end
	end
end)
