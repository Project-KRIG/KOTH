RegisterNetEvent("baseevents:onPlayerKilled")
AddEventHandler("baseevents:onPlayerKilled", function(killerid, killertab)
  KOTH.DebugPrint(GetPlayerName(source) .. " was killed by " .. GetPlayerName(tonumber(killerid)) .. ".")
  KOTH.AddKill(killerid)
  KOTH.AddDeath(source)
  TriggerClientEvent("KOTH:GetKill", killerid)
  TriggerClientEvent("KOTH:Died", source)
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
  TriggerClientEvent("KOTH:Died", source)
end)


RegisterNetEvent("baseevents:onPlayerWasted")
AddEventHandler("baseevents:onPlayerWasted", function(deathtab)
  KOTH.DebugPrint(GetPlayerName(source) .. " died.")
  KOTH.AddDeath(source)
  TriggerClientEvent("KOTH:Died", source)
end)
