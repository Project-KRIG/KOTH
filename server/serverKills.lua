RegisterNetEvent("baseevents:onPlayerKilled")
AddEventHandler("baseevents:onPlayerKilled", function(killerid, killertab)
  KOTH.DebugPrint(GetPlayerName(source) .. " was killed by " .. GetPlayerName(tonumber(killerid)) .. ".")
  TriggerClientEvent("KOTH:GetKill", killerid)
  TriggerClientEvent("KOTH:Died", source)
end)

RegisterNetEvent("baseevents:onPlayerDied")
AddEventHandler("baseevents:onPlayerDied", function(killertype, killertab)
  KOTH.DebugPrint(GetPlayerName(source) .. " died.")
  TriggerClientEvent("KOTH:Died", source)
end)


RegisterNetEvent("baseevents:onPlayerWasted")
AddEventHandler("baseevents:onPlayerWasted", function(deathtab)
  KOTH.DebugPrint(GetPlayerName(source) .. " died.")
  TriggerClientEvent("KOTH:Died", source)
end)
