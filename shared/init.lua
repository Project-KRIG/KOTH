KOTH = {}
KOTH.Mumble = {}
KOTH.Ready = false --DO NOT TOUCH
KOTH.Debug = false
KOTH.XPTimer = 20 -- Time in seconds it takes to gain XP while in the zone
KOTH.PointTimer = 5 -- Time in seconds it takes for the winning team to gain a point
KOTH.PrioZoneTimer = 60 -- Time in seconds it takes for the Priority Circle to move
KOTH.WinThreshold = 100 -- Amount of points required to win
KOTH.Spawn = {x = -75.5505, y = -819.929, z = 326.175} -- Set spawn for players who have not selected a team.
KOTH.LockTeamsIfUneaven = false -- Lock the teams if they are uneven.
KOTH.FriendlyFire = true -- Toggle friendly fire.
KOTH.TimeEnabled = true -- Wheather time should be frozen.
KOTH.WeatherEnabled = true -- Toggle weather enabled.
KOTH.WeatherChance = 20 -- Percentage chance that the weather changes every 5 minutes.
KOTH.WeatherTypes = {
  "CLEAR",
  "EXTRASUNNY",
  "CLOUDS",
  "OVERCAST",
  "RAIN",
  "THUNDER",
  "SMOG",
  "FOGGY",
}
KOTH.DiscordWebhook = "***REMOVED***"


--[[ MUMBLE CONFIG ]]

KOTH.Mumble.Config = {
  Range = 20.0, -- Local chat range. Default: 20.0
  RadioControl = 171, -- Push to talk key. Default: 171 CAPSLOCK
}

--[[ END OF MUMBLE CONFIG]]





--DO NOT TOUCH
KOTH.Teams = {}
KOTH.Players = {}
KOTH.Mumble.Channels = {}
KOTH.Mumble.Players = {}
KOTH.Mumble.ClientData = {}

KOTH.Teams["Yellow"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 100.0, y = 200.0, z = 300.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 5, Hat = 6, Legs = 3},
  Count = 0,
  Channel = 1,
}
KOTH.Teams["Green"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 0, Hat = 9, Legs = 5},
  Count = 0,
  Channel = 2,
}
KOTH.Teams["Blue"] = {
  Spawns = {Player = {x = 0.0, y = 0.0, z = 0.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
  Players = {},
  Points = 0,
  Colors = {Shirt = 3, Hat = 7, Legs = 4},
  Count = 0,
  Channel = 3,
}
KOTH.Circle = {
  Coords = {x = 0.0, y = 0.0, z = 0.0},
  Size = 300.0,
  PlayersInside = {},
  Blip = nil
}
KOTH.PrioCircle = {
  Count = 0,
  Coords = {x = 0.0, y = 0.0, z = 0.0},
  Size = 50.0,
  PlayersInside = {},
  Blip = nil
}
KOTH.Vehicle = nil

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
    for k, v in pairs(KOTH.Players) do
      TriggerClientEvent("KOTH:ResetGame", k)
      KOTH.TriggerClientEvent("KOTH:UpdatePoints", k, {Points = {Yellow = KOTH.Teams["Yellow"].Points, Green = KOTH.Teams["Green"].Points, Blue = KOTH.Teams["Blue"].Points}})
    end
  else
    SetEntityCoords(PlayerPedId(), KOTH.Spawn.x, KOTH.Spawn.y, KOTH.Spawn.z)
    KOTH.SetNutral()
    KOTH.DeleteVehicle()
    TriggerServerEvent('KOTH:ClientInitialized', KOTH.GetPlayerLevel(), KOTH.GetPlayerXP())
    KOTH.TriggerEvent("KOTH:OpenStartUi")
  end
  KOTH.DebugPrint("Game reset.")
end

if not IsDuplicityVersion() then
  RegisterNetEvent("KOTH:ResetGame")
  AddEventHandler("KOTH:ResetGame", KOTH.ResetGame)
end

KOTH.CurrentMap = 0
KOTH.Minute = 0
KOTH.Hour = 8
KOTH.WeatherTimer = 0
KOTH.Weather = "EXTRASUNNY"
KOTH.CurrentTeam = "None"
KOTH.PointTicker = 0
KOTH.Winning = "None"
KOTH.EventAuthKey = ""
KOTH.Ready = true


-- UI
KOTH.ShowMap = true

-- SHOP


KOTH.Shop = {
  -- Yellow
  {x = 1385.81, y = 2802.07, z = 50.00, p = 3.0, r = 30.0, yaw = 4.0},
  {x = 1741.97, y = 3690.58, z = 33.55, p = 10.0, r = 30.0, yaw = 4.0},
  -- Blue
  {x = 1838.15, y = 3950.02, z = 32.10},
  {x = 1409.16, y = 3480.50, z = 34.50},
  -- Green 
  {x = 1718.92, y = 3219.07, z = 41.40},
  {x = 2041.24, y = 3872.82, z = 30.80},
}

KOTH.Vehicles = {
  ['Mesa'] = {Model = 'mesa3', levelReq = 2, price = 300, type="land"},
  ['Buzzard'] = {Model = 'buzzard2', levelReq = 4, price = 1000, type="air"}
}

KOTH.Weapons = {
  ["Pistol"] = {Model = 'weapon_pistol', levelReq = 1, price = 200},
  ["SMG"] = {Model = 'weapon_smg', levelReq = 2, price = 200},
  --["RPG"] = {Model = 'weapon_rpg', levelReq = 5, price = 200},
  ["Carbine Rifle"] = {Model = 'weapon_carbinerifle', levelReq = 3, price = 200},
  ["Assault Rifle"] = {Model = 'weapon_assaultrifle', levelReq = 3, price = 200},
  ["Revolver"] = {Model = 'weapon_revolver', levelReq = 3, price = 200},
  ["Marksman Rifle"] = {Model = 'weapon_marksmanrifle', levelReq = 5, price = 200},
  ["Combat LMG"] = {Model = 'weapon_combatmg', levelReq = 5, price = 200},
  ["Knife"] = {Model = 'weapon_knife', levelReq = 5, price = 200},
  ["Special Carbine"] = {Model = 'weapon_specialcarbine', levelReq = 5, price = 200},
}
