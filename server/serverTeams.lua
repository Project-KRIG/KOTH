KOTH.JoinTeam = function(player, team)
  if KOTH.GetTeam(player) == "No Team" then
    KOTH.Players[player].Team = team
    KOTH.Teams[team].Players[player] = true
  else
    KOTH.Teams[KOTH.GetTeam(player)].Players[player] = false
    KOTH.Teams[team].Players[player] = true
    KOTH.Players[player].Team = team
  end
  TriggerClientEvent("KOTH:SetUniform", player, KOTH.Teams[team].Colors, team)
  KOTH.GetPlayerCounts()
end

RegisterNetEvent("KOTH:JoinTeam")
AddEventHandler("KOTH:JoinTeam", function(team)
  KOTH.JoinTeam(source, team)
end)

RegisterNetEvent("KOTH:RequstPlayerCount")
AddEventHandler("KOTH:RequstPlayerCount", function()
  KOTH.GetPlayerCounts()
end)

KOTH.GetTeam = function(player)
  return KOTH.Players[player].Team
end

KOTH.GetPlayerCounts = function()
  local YellowCount = 0
  local GreenCount = 0
  local BlueCount = 0
  for k, v in pairs(KOTH.Teams["Yellow"].Players) do
    if v then
      YellowCount = YellowCount + 1
    end
  end
  for k, v in pairs(KOTH.Teams["Green"].Players) do
    if v then
      GreenCount = GreenCount + 1
    end
  end
  for k, v in pairs(KOTH.Teams["Blue"].Players) do
    if v then
      BlueCount = BlueCount + 1
    end
  end
  KOTH.DebugPrint("Current player counts Y:" .. YellowCount .. " G:" .. GreenCount .. " B:" .. BlueCount .. ".")
  TriggerClientEvent("KOTH:UpdatePlayerCount", -1, {Yellow = YellowCount, Green = GreenCount, Blue = BlueCount})
end

KOTH.AddTeamPoints = function(team, amount)
  KOTH.Teams[team].Points = KOTH.Teams[team].Points + 1
  TriggerClientEvent("KOTH:UpdatePoints", -1, {Yellow = KOTH.Teams["Yellow"].Points, Green = KOTH.Teams["Green"].Points, Blue = KOTH.Teams["Blue"].Points})
  KOTH.DebugPrint(team .. " now has " .. KOTH.Teams[team].Points .. " points.")
  if KOTH.Teams[team].Points == KOTH.WinThreshold then
    KOTH.DebugPrint(team .. " won.")
    TriggerClientEvent("KOTH:ShowWin", -1, team)
    Citizen.Wait(5000)
    KOTH.ResetGame()
  end
end
