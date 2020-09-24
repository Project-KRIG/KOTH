Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(0)
  end
  KOTH.Maps = {
    [1] = {
      Circle = {Coords = {x = 1391.81, y = 3136.89, z = 40.7851},Size = 300.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1370.23, y = 2797.582, z = 49.87}, Shop = {x = 1385.81, y = 2802.07, z = 50.00, p = 3.0, r = 30.0, yaw = 4.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 200.0, y = 999.0, z = 555.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1394.71, y = 3476.89, z = 35.02}, Shop = {x = 1838.15, y = 3950.02, z = 32.10}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 1723.60, y = 3211.77, z = 43.05}, Shop = {x = 1718.92, y = 3219.07, z = 41.40}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
      },
    },
    [2] = {
      Circle = {Coords = {x = 1882.54, y = 3786.0, z = 32.8061},Size = 200.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1732.87, y = 3684.40, z = 34.7}, Shop = {x = 1741.97, y = 3690.58, z = 33.55, p = 10.0, r = 30.0, yaw = 4.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1833.72, y = 3958.39, z = 33.22}, Shop = {x = 1409.16, y = 3480.50, z = 34.50}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 2044.645, y = 3866.09, z = 31.94}, Shop = {x = 2041.24, y = 3872.82, z = 30.80}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
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
      for k, v in pairs(KOTH.Players) do
        KOTH.TriggerClientEvent("KOTH:SetMap", k, {CurrentMap = id})
      end
    else
      KOTH.CreateBlips()
      KOTH.BuildBase()
    end
  end
end)
