KOTH = {}
KOTH.Ready = false --DO NOT TOUCH
KOTH.Debug = true
KOTH.XPTimer = 20 -- Time in seconds it takes to gain XP while in the zone
KOTH.PointTimer = 5 -- Time in seconds it takes for the winning team to gain a point
KOTH.PrioZoneTimer = 60 -- Time in seconds it takes for the Priority Circle to move

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
KOTH.CurrentTeam = "None"
KOTH.PointTicker = 0
KOTH.Winning = "None"
KOTH.Ready = true
