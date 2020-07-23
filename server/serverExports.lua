SetConfValue = function(key, value)
  KOTH.DebugPrint(key .. " was set to " .. value .. ".")
  KOTH[key] = value
end

GetPlayerKills = function(player)
  KOTH.DebugPrint(GetPlayerName(player) .. "'s Kills: "  .. KOTH.Players[player].Kills .. ".")
  return KOTH.Players[player].Kills
end

GetPlayerDeaths = function(player)
  KOTH.DebugPrint(GetPlayerName(player) .. "'s Deaths: "  .. KOTH.Players[player].Deaths .. ".")
  return KOTH.Players[player].Deaths
end

GetPlayerKD = function(player)
  local Kills = KOTH.GetPlayerKills(player)
  local Deaths = KOTH.GetPlayerDeaths(player)
  local KD = Kills / Deaths
  KOTH.DebugPrint(GetPlayerName(player) .. "'s KD is "  .. KD .. ".")
  return KD
end
