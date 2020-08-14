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
  local player = params.ply
  KOTH.DebugPrint(GetPlayerName(player) .. "'s channel has been updated to " .. params.Channel .. ".")
  KOTH.Mumble.Players[player].Channel = params.Channel
  for k, v in pairs(KOTH.Players) do
    KOTH.TriggerClientEvent("KOTH:SetMumbleChannel", k, {Player = player, Channel = KOTH.Mumble.Players[player].Channel})
  end
end)

KOTH.CreateEvent("KOTH:MumbleTalking", function(params)
  local bool = params.Bool
  KOTH.Mumble.Players[source].IsTalking = bool
  for k, v in pairs(KOTH.Players) do
    KOTH.TriggerClientEvent("KOTH:MumbleTalking", k, {Player = params.source, Bool = KOTH.Mumble.Players[source].IsTalking})
  end
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
    for k, v in pairs(KOTH.Players) do
      KOTH.TriggerClientEvent("KOTH:SyncMumblePlayers", k, {PTab = KOTH.Mumble.Players})
    end
  end
end)


AddEventHandler("playerDropped", function (reason)
  KOTH.Mumble.Players[source] = nil
  for k, v in pairs(KOTH.Players) do
    KOTH.TriggerClientEvent("KOTH:SyncMumblePlayers", k, {PTab = KOTH.Mumble.Players})
  end
end)
