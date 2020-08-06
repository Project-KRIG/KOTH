--[[
THIS FILE IS A MODIFIED VERSION OF https://github.com/FrazzIe/mumble-voip/blob/master/client.lua I HAVE JUST MADE THIS WORK IN ONESYNC
INFINITY AND ADAPTED IT FOR THIS RESOURCE.
]]

LocalServerID = GetPlayerServerId(PlayerId())

RegisterNetEvent("KOTH:SyncMumblePlayers")
AddEventHandler("KOTH:SyncMumblePlayers", function(PTab)
  KOTH.Mumble.Players = PTab
end)

RegisterNetEvent("KOTH:SetMumbleChannel")
AddEventHandler("KOTH:SetMumbleChannel", function(source, channel)
  KOTH.Mumble.Players[source].Channel = channel
end)

RegisterNetEvent("KOTH:MumbleTalking")
AddEventHandler("KOTH:MumbleTalking", function(source, bool)
  KOTH.Mumble.Players[source].IsTalking = bool
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

Citizen.CreateThread(function()
  while KOTH.Mumble.Players[LocalServerID] == nil do
    Citizen.Wait(500)
  end
  while true do
    Citizen.Wait(0)

    local RadioActive = KOTH.Mumble.Players[LocalServerID].IsTalking or false

    if RadioActive then
			SetControlNormal(0, 249, 1.0)
			SetControlNormal(1, 249, 1.0)
			SetControlNormal(2, 249, 1.0)
		end

    if not RadioActive then
      if IsControlJustPressed(0, KOTH.Mumble.Config.RadioControl) then
        TriggerServerEvent("KOTH:MumbleTalking", true)
        RadioActive = true
        Citizen.CreateThread(function()
          while IsControlPressed(0, KOTH.Mumble.Config.RadioControl) do
            Citizen.Wait(0)
          end

          TriggerServerEvent("KOTH:MumbleTalking", false)
          RadioActive = false
        end)
      end
    end



  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    local LocalPed = PlayerPedId()
    local LocalPos = GetEntityCoords(LocalPed)
    local LocalData = KOTH.Mumble.Players[LocalServerID]

    local PlayersToHear = {}

    --[[ FIGURE OUT WHICH PLAYERS TO HEAR ]]
    for ServerID, VoiceData in pairs(KOTH.Mumble.Players) do
      if ServerID ~= LocalServerID then
        local OtherPos = VoiceData.PlayerPos
        local Distance = #(LocalPos - OtherPos)

        if Distance <= KOTH.Mumble.Config.Range then
          if VoiceData.IsTalking and VoiceData.Channel == LocalData.Channel then
            PlayersToHear[ServerID] = 1.0
          else
            PlayersToHear[ServerID] = round(1.0 - (Distance / KOTH.Mumble.Config.Range) + 0.0001, 2)
          end
        else
          if VoiceData.IsTalking and VoiceData.Channel == LocalData.Channel then
            PlayersToHear[ServerID] = 1.0
          else
            PlayersToHear[ServerID] = 0.0
          end
        end
      end
    end

    --[[ NOW LETS ACTUALLY HEAR THOSE PLAYERS ]]
    for ServerID, Volume in pairs(PlayersToHear) do
      MumbleSetVolumeOverride(GetPlayerFromServerId(ServerID), Volume)
    end

  end
end)
