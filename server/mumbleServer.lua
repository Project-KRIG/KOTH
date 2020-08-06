RegisterNetEvent("KOTH:ClientInitialized")
AddEventHandler("KOTH:ClientInitialized", function()
  local player = source
  KOTH.Mumble.Players[source] = {
    PlayerPos = GetEntityCoords(GetPlayerPed(source)),
    IsTalking = false,
    Channel = 0,
  }
  TriggerClientEvent("KOTH:SyncMumblePlayers", source, KOTH.Mumble.Players)
end)

RegisterNetEvent("KOTH:SetMumbleChannel")
AddEventHandler("KOTH:SetMumbleChannel", function(channel, src)
  local player = src or source
  KOTH.DebugPrint(GetPlayerName(player) .. "'s channel has been updated to " .. channel .. ".")
  KOTH.Mumble.Players[player].Channel = channel
  TriggerClientEvent("KOTH:SetMumbleChannel", -1, player, KOTH.Mumble.Players[player].Channel)
end)

RegisterNetEvent("KOTH:MumbleTalking")
AddEventHandler("KOTH:MumbleTalking", function(bool)
  KOTH.Mumble.Players[source].IsTalking = bool
  TriggerClientEvent("KOTH:MumbleTalking", -1, source, KOTH.Mumble.Players[source].IsTalking)
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    for PlayerID, VoiceData in pairs(KOTH.Mumble.Players) do
      KOTH.Mumble.Players[PlayerID].PlayerPos = GetEntityCoords(GetPlayerPed(PlayerID))
    end
    TriggerClientEvent("KOTH:SyncMumblePlayers", -1, KOTH.Mumble.Players)
  end
end)


AddEventHandler("playerDropped", function (reason)
  KOTH.Mumble.Players[source] = nil
  TriggerClientEvent("KOTH:SyncMumblePlayers", -1, KOTH.Mumble.Players)
end)
