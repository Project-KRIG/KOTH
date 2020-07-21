AddEventHandler("playerConnecting", function(name, callback, deferrals)
  print("[KOTH] " .. name .. " has joined the game.")
end)

RegisterNetEvent("KOTH:ClientInitialized")
AddEventHandler("KOTH:ClientInitialized", function(CLevel, CXP)
  local player = source
  local name = GetPlayerName(player)
  print("[KOTH] " .. name .. " has been initialized, they are level " .. CLevel .. " and have " .. CXP .. " XP.")
  KOTH.Players[player] = {
    Team = "No Team",
    Level = CLevel,
    XP = CXP
  }
end)

AddEventHandler("playerDropped", function (reason)
	local player = source
	local name = GetPlayerName(player)
	print("[KOTH] " .. name .. " left the game.")
  if KOTH.Players[player].Team ~= "No Team" then
	  KOTH.Teams[KOTH.Players[player].Team].Players[player] = false
  end
  KOTH.Players[player] = nil
  KOTH.GetPlayerCounts()
end)
