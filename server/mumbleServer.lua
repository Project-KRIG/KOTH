RegisterNetEvent("KOTH:ClientInitialized")
AddEventHandler("KOTH:ClientInitialized", function()
  local player = source
  KOTH.Mumble.Players[source] = {
    PlayerPos = GetEntityCoords(GetPlayerPed(source)),
    IsTalking = false,
    Channel = 0,
  }
  KOTH.TriggerClientEvent("KOTH:SyncMumblePlayers", source, {PTab = KOTH.Mumble.Players})
end)

KOTH.CreateEvent("KOTH:SetMumbleChannel", function(params)
  local player = params.source
  KOTH.DebugPrint(GetPlayerName(player) .. "'s channel has been updated to " .. params.Channel .. ".")
  KOTH.Mumble.Players[player].Channel = params.Channel
  KOTH.TriggerClientEvent("KOTH:SetMumbleChannel", -1, {Player = player, Channel = KOTH.Mumble.Players[player].Channel})
end)

KOTH.CreateEvent("KOTH:MumbleTalking", function(params)
  local bool = params.Bool
  KOTH.Mumble.Players[source].IsTalking = bool
  KOTH.TriggerClientEvent("KOTH:MumbleTalking", -1, {Player = params.source, Bool = KOTH.Mumble.Players[source].IsTalking})
end)

Citizen.CreateThread(function()
  while KOTH.Mumble.Players == nil do
    Citizen.Wait(500)
  end
  while true do
    Citizen.Wait(1000)
    for PlayerID, VoiceData in pairs(KOTH.Mumble.Players) do
      KOTH.Mumble.Players[PlayerID].PlayerPos = GetEntityCoords(GetPlayerPed(PlayerID))
    end
    KOTH.TriggerClientEvent("KOTH:SyncMumblePlayers", -1, {PTab = KOTH.Mumble.Players})
  end
end)


AddEventHandler("playerDropped", function (reason)
  KOTH.Mumble.Players[source] = nil
  KOTH.TriggerClientEvent("KOTH:SyncMumblePlayers", -1, {PTab = KOTH.Mumble.Players})
end)
