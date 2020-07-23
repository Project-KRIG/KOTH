Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(0)
  end
  KOTH.Maps = {
    [1] = {
      Circle = {Coords = {x = 1391.81, y = 3136.89, z = 40.7851},Size = 300.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1369.41, y = 2792.5, z = 49.9701}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1386.35, y = 3446.12, z = 39.0066}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 1735.24, y = 3298.3, z = 41.2235}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
      },
    },
    [2] = {
      Circle = {Coords = {x = 1882.54, y = 3786.0, z = 32.8061},Size = 200.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1720.23, y = 3694.25, z = 34.4837}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1833.06, y = 3939.17, z = 33.0671}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 2042.83, y = 3864.58, z = 31.941}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
      },
    }
  }


  KOTH.SetMap = function(id)
    KOTH.Circle = KOTH.Maps[id].Circle
    KOTH.Teams["Yellow"].Spawns = KOTH.Maps[id].Spawns["Yellow"]
    KOTH.Teams["Green"].Spawns = KOTH.Maps[id].Spawns["Green"]
    KOTH.Teams["Blue"].Spawns = KOTH.Maps[id].Spawns["Blue"]
    KOTH.PrioCircle.Coords = KOTH.Maps[id].Circle.Coords
    KOTH.PrioCircle.Size = KOTH.Maps[id].Circle.Size/6
    KOTH.DebugPrint("Map set to " .. id)
    if IsDuplicityVersion() then
      TriggerClientEvent("KOTH:SetMap", -1, id)
    end
  end
end)
