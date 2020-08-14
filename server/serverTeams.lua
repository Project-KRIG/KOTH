KOTH.JoinTeam = function(player, team)
  if KOTH.GetTeam(player) == "No Team" then
    KOTH.Players[player].Team = team
    KOTH.Teams[team].Players[player] = true
  else
    KOTH.Teams[KOTH.GetTeam(player)].Players[player] = false
    KOTH.Teams[team].Players[player] = true
    KOTH.Players[player].Team = team
  end
  KOTH.TriggerClientEvent("KOTH:SetUniform", player, {Clothes = KOTH.Teams[team].Colors, Team = team})
  KOTH.TriggerEvent("KOTH:SetMumbleChannel", {Channel = KOTH.Teams[team].Channel, source = player})
  KOTH.GetPlayerCounts()
end

KOTH.CreateEvent("KOTH:JoinTeam", function(params)
  KOTH.JoinTeam(params.source, params.Team)
end)

KOTH.CreateEvent("KOTH:RequstPlayerCount", function(params)
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
  KOTH.Teams["Yellow"].Count = YellowCount
  KOTH.Teams["Blue"].Count = BlueCount
  KOTH.Teams["Green"].Count = GreenCount
  KOTH.DebugPrint("Current player counts Y:" .. YellowCount .. " G:" .. GreenCount .. " B:" .. BlueCount .. ".")
  KOTH.TriggerClientEvent("KOTH:UpdatePlayerCount", -1, {Yellow = YellowCount, Green = GreenCount, Blue = BlueCount})
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


KOTH.Autobalance = function()
  local difference = 0
  difference = KOTH.Teams["Yellow"].Count - KOTH.Teams["Blue"].Count
  if difference > 2 then
    -- Yellow to Blue

  end
  difference = KOTH.Teams["Yellow"].Count - KOTH.Teams["Green"].Count
  if difference > 2 then
    -- Yellow to Green

  end
  difference = KOTH.Teams["Blue"].Count - KOTH.Teams["Yellow"].Count
  if difference > 2 then
    -- Blue to Yellow

  end
  difference = KOTH.Teams["Blue"].Count - KOTH.Teams["Green"].Count
  if difference > 2 then
    -- Blue to Green

  end
  difference = KOTH.Teams["Green"].Count - KOTH.Teams["Blue"].Count
  if difference > 2 then
    -- Green to Blue

  end
  difference = KOTH.Teams["Green"].Count - KOTH.Teams["Yellow"].Count
  if difference > 2 then
    -- Green to Yellow

  end
end
