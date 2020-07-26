KOTH = {}
KOTH.Ready = false --DO NOT TOUCH
KOTH.Debug = false
KOTH.XPTimer = 20 -- Time in seconds it takes to gain XP while in the zone
KOTH.PointTimer = 5 -- Time in seconds it takes for the winning team to gain a point
KOTH.PrioZoneTimer = 60 -- Time in seconds it takes for the Priority Circle to move
KOTH.WinThreshold = 100 -- Amount of points required to win
KOTH.Spawn = {x = -75.5505, y = -819.929, z = 326.175} -- Set spawn for players who have not selected a team.

--DO NOT TOUCH
KOTH.Teams = {}
KOTH.Players = {}
KOTH.Teams["Yellow"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 5, Hat = 6, Legs = 3},
}
KOTH.Teams["Green"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 0, Hat = 9, Legs = 5},
}
KOTH.Teams["Blue"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 3, Hat = 7, Legs = 4},
}
KOTH.Circle = {
  Coords = {x = 0.0, y = 0.0, z = 0.0},
  Size = 300.0,
  PlayersInside = {}
}
KOTH.PrioCircle = {
  Count = 0,
  Coords = {x = 0.0, y = 0.0, z = 0.0},
  Size = 50.0,
  PlayersInside = {}
}

KOTH.ResetGame = function()
  KOTH.PrioCircle.Count = 0
  KOTH.Circle.PlayersInside = {}
  KOTH.PrioCircle.PlayersInside = {}
  KOTH.Teams["Yellow"].Players = {}
  KOTH.Teams["Green"].Players = {}
  KOTH.Teams["Blue"].Players = {}
  KOTH.Teams["Yellow"].Points = 0
  KOTH.Teams["Green"].Points = 0
  KOTH.Teams["Blue"].Points = 0
  if IsDuplicityVersion() then
    KOTH.SetMap(math.random(#KOTH.Maps))
    TriggerClientEvent("KOTH:ResetGame", -1)
    TriggerClientEvent("KOTH:UpdatePoints", -1, {Yellow = KOTH.Teams["Yellow"].Points, Green = KOTH.Teams["Green"].Points, Blue = KOTH.Teams["Blue"].Points})
  else
    SetEntityCoords(PlayerPedId(), KOTH.Spawn.x, KOTH.Spawn.y, KOTH.Spawn.z)
    KOTH.SetNutral()
    TriggerServerEvent('KOTH:ClientInitialized', KOTH.GetPlayerLevel(), KOTH.GetPlayerXP())
    TriggerEvent("KOTH:OpenStartUi")
  end
  KOTH.DebugPrint("Game reset.")
end

if not IsDuplicityVersion() then
  RegisterNetEvent("KOTH:ResetGame")
  AddEventHandler("KOTH:ResetGame", KOTH.ResetGame)
end

KOTH.CurrentMap = 0
KOTH.CurrentTeam = "None"
KOTH.PointTicker = 0
KOTH.Winning = "None"
KOTH.Ready = true
