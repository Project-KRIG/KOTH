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
			for k,v in pairs(KOTH.Teams) do
				local pos =  vector3(v.ShopLocation.x, v.ShopLocation.y, v.ShopLocation.z)
				KOTH.CreateObject('gr_prop_gr_bench_01a', pos.x, pos.y, pos.z)
			end
			TriggerEvent("KOTH:OpenStartUi")
			NetworkSetFriendlyFireOption(KOTH.FriendlyFire)
			SetCanAttackFriendly(PlayerPedId(), true, true)
			DisplayRadar(KOTH.ShowMap)
			
			TriggerEvent('koth:ui:money')
			TriggerEvent('koth:ui:level')
			return
		end
	end
end)
