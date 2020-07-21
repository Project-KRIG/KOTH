Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  Citizen.Wait(1000)
  KOTH.SetMap(#KOTH.Maps)
  while true do
    Citizen.Wait(1000)
    KOTH.PointTicker = KOTH.PointTicker + 1
    if KOTH.PointTicker == KOTH.PointTimer then
      if KOTH.Winning ~= "None" then
        KOTH.AddTeamPoints(KOTH.Winning, 1)
      end
      KOTH.PointTicker = 0
    end
    local InCircle = KOTH.CountPlayersInCircle()
    TriggerClientEvent("KOTH:InCircleCounts", -1, InCircle)
    KOTH.Winning = KOTH.WinningTeam(InCircle)
    for _, player in ipairs(GetPlayers()) do
      KOTH.InCircle(tonumber(player))
      --print(GetEntityCoords(GetPlayerPed(player)))
    end
    KOTH.PrioCircle.Count = KOTH.PrioCircle.Count + 1
    if KOTH.PrioCircle.Count == KOTH.PrioZoneTimer then
      local CircleCoords = KOTH.Circle.Coords
      local newx = CircleCoords.x + math.random(-90, 90)
      local newy = CircleCoords.y + math.random(-90, 90)
      local newCoords = {x = newx, y = newy, z = KOTH.PrioCircle.Coords.z}
      TriggerClientEvent("KOTH:MovePriorityCircle", -1, newCoords)
      KOTH.PrioCircle.Coords = newCoords
      KOTH.DebugPrint("Priority circle updated.")
      KOTH.PrioCircle.Count = 0
    end
  end
end)


KOTH.InCircle = function(player)
  local MainCircle = (GetEntityCoords(GetPlayerPed(player)) - vector3(KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z))
	if (#MainCircle <= (KOTH.Circle.Size / 2) + 2) then
    KOTH.Circle.PlayersInside[player] = true
	else
    KOTH.Circle.PlayersInside[player] = false
	end
  local PrioCircle = (GetEntityCoords(GetPlayerPed(player)) - vector3(KOTH.PrioCircle.Coords.x, KOTH.PrioCircle.Coords.y, KOTH.PrioCircle.Coords.z))
	if (#PrioCircle <= (KOTH.PrioCircle.Size / 2)) then
    KOTH.PrioCircle.PlayersInside[player] = true
	else
    KOTH.PrioCircle.PlayersInside[player] = false
	end
end

KOTH.WinningTeam = function(InCircle)
  local WinningTeam = "None"
  if InCircle.Yellow > InCircle.Blue and InCircle.Yellow > InCircle.Green then
    WinningTeam = "Yellow"
  elseif InCircle.Blue > InCircle.Yellow and InCircle.Blue > InCircle.Green then
    WinningTeam = "Blue"
  elseif InCircle.Green > InCircle.Blue and InCircle.Green > InCircle.Yellow then
    WinningTeam = "Green"
  end
  return WinningTeam
end

KOTH.CountPlayersInCircle = function()
  local YellowCount = 0
  local BlueCount = 0
  local GreenCount = 0
  for k, v in pairs(KOTH.Circle.PlayersInside) do
    if v then
      if KOTH.Players[k] ~= nil then
        local team = KOTH.GetTeam(k)
        if team == "Yellow" then
          YellowCount = YellowCount + 1
        elseif team == "Blue" then
          BlueCount = BlueCount + 1
        elseif team == "Green" then
          GreenCount = GreenCount + 1
        end
      end
    end
  end
  for k, v in pairs(KOTH.PrioCircle.PlayersInside) do
    if v then
      if KOTH.Players[k] ~= nil then
        local team = KOTH.GetTeam(k)
        if team == "Yellow" then
          YellowCount = YellowCount + 1
        elseif team == "Blue" then
          BlueCount = BlueCount + 1
        elseif team == "Green" then
          GreenCount = GreenCount + 1
        end
      end
    end
  end
  local table = {Total = (YellowCount + BlueCount + GreenCount), Yellow = YellowCount, Blue = BlueCount, Green = GreenCount}
  return table
end

--PerformHttpRequest("https://api.ipify.org/", function (errorCode, resultData, resultHeaders)
--  print(resultData)
--end)
