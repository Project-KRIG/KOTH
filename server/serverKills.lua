RegisterNetEvent("baseevents:onPlayerKilled")
AddEventHandler("baseevents:onPlayerKilled", function(killerid, killertab)
  KOTH.DebugPrint(GetPlayerName(source) .. " was killed by " .. GetPlayerName(tonumber(killerid)) .. ".")
  KOTH.AddKill(killerid)
  KOTH.AddDeath(source)
  if KOTH.Players[source].Team ~= KOTH.Players[killerid].Team then
    KOTH.TriggerClientEvent("KOTH:GetKill", killerid)
    KOTH.TriggerClientEvent("KOTH:Died", source)
  end
end)

KOTH.AddKill = function(player)
  KOTH.DebugPrint("Kill added to " .. GetPlayerName(player) .. ".")
  KOTH.Players[player].Kills = KOTH.Players[player].Kills + 1
end

KOTH.AddDeath = function(player)
  KOTH.DebugPrint("Death added to " .. GetPlayerName(player) .. ".")
  KOTH.Players[player].Deaths = KOTH.Players[player].Deaths + 1
end

RegisterNetEvent("baseevents:onPlayerDied")
AddEventHandler("baseevents:onPlayerDied", function(killertype, killertab)
  KOTH.DebugPrint(GetPlayerName(source) .. " died.")
  KOTH.AddDeath(source)
  KOTH.TriggerClientEvent("KOTH:Died", source)
end)
