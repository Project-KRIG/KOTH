Citizen.CreateThread(function()
	while true do
		Wait(0)

		if NetworkIsSessionStarted() then
			TriggerServerEvent('KOTH:ClientInitialized', {Level = KOTH.GetPlayerLevel(), XP = KOTH.GetPlayerXP(), Kills = KOTH.GetPlayerKills(), Deaths = KOTH.GetPlayerDeaths()})
			Citizen.Wait(1000)
			KOTH.SetNutral()
			if GetResourceKvpString("KOTH:Model") == nil then
				SetResourceKvp("KOTH:Model", "None")
			end
			KOTH.TriggerEvent("KOTH:OpenStartUi")
			NetworkSetFriendlyFireOption(KOTH.FriendlyFire)
			SetCanAttackFriendly(PlayerPedId(), true, true)
			DisplayRadar(KOTH.ShowMap)
			
			KOTH.BuildBase()

			KOTH.TriggerEvent('koth:ui:money')
			KOTH.TriggerEvent('koth:ui:level')

			return
		end
	end
end)
