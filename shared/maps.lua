Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(0)
  end
  KOTH.Maps = {
    [1] = {
      Circle = {Coords = {x = 1391.81, y = 3136.89, z = 40.7851},Size = 300.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1370.23, y = 2797.582, z = 49.87}, Shop = {x = 1387.274, y = 2799.048, z = 51.25308, p = 0.0, r = 0.0, yaw = 190.0}, Car = {x = 1433.72, y = 2795.57, z = 52.45, h = 12.74}, Helicopter = {x = 1338.76, y = 2751.17, z = 51.59, h = 3.59}},
        ["Blue"] = {Player = {x = 1394.71, y = 3476.89, z = 35.02}, Shop = {x = 1402.27, y = 3476.544, z = 34.77193, p = 0.0, r = 0.0, yaw = 270.0}, Car = {x = 1420.77, y = 3486.58, z = 36.0, h = 186.82}, Helicopter = {x = 1377.9, y = 3486.53, z = 35.73, h = 191.6}},
        ["Green"] = {Player = {x = 1723.60, y = 3211.77, z = 43.05}, Shop = {x = 1718.92, y = 3219.07, z = 41.40, p = 0.0, r = 0.0, yaw = 15.0}, Car = {x = 1730.34, y = 3246.08, z = 41.29, h = 119.82}, Helicopter = {x = 1770.37, y = 3239.73, z = 42.13, h = 101.29}},
      },
    },
    [2] = {
      Circle = {Coords = {x = 1882.54, y = 3786.0, z = 32.8061},Size = 200.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1732.87, y = 3684.40, z = 34.7}, Shop = {x = 1741.97, y = 3690.58, z = 33.55, p = 0.0, r = 0.0, yaw = -65.0}, Car = {x = 1719.49, y = 3674.17, z = 34.69, h = 201.66}, Helicopter = {x = 1737.15, y = 3668.72, z = 34.74, h = 288.85}},
        ["Blue"] = {Player = {x = 1833.72, y = 3958.39, z = 33.22}, Shop = {x = 1838.379, y = 3954.987, z = 33.02042, p = 0.0, r = 0.0, yaw = -90.0}, Car = {x = 1824.45, y = 3927.42, z = 33.45, h = 7.07}, Helicopter = {x = 1812.6, y = 3944.3, z = 33.62, h = 279.97}},
        ["Green"] = {Player = {x = 2044.645, y = 3866.09, z = 31.94}, Shop = {x = 2041.24, y = 3872.82, z = 30.80, p = 0.0, r = 0.0, yaw = 40.0}, Car = {x = 2973.27, y = 3853.22, z = 33.48, h = 120.31}, Helicopter = {x = 2047.13, y = 3898.21, z = 31.78, h = 167.49}},
      },
    },
    [3] = {
      Circle = {Coords = {x = -1336.38, y = -3044.13, z = 13.9455},Size = 300.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = -1219.56, y = -2859.36, z = 13.945}, Shop = {x = 1741.97, y = 3690.58, z = 33.55, p = 0.0, r = 0.0, yaw = -65.0}, Car = {x = 1719.49, y = 3674.17, z = 34.69, h = 201.66}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Blue"] = {Player = {x = -999.715, y = -3196.29, z = 14.3109}, Shop = {x = 1838.379, y = 3954.987, z = 33.02042, p = 0.0, r = 0.0, yaw = -90.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = -1677.14, y = -2792.4, z = 13.94}, Shop = {x = 2041.24, y = 3872.82, z = 30.80, p = 0.0, r = 0.0, yaw = 40.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
      },
    }
  }

  KOTH.SetMap = function(id)
    local OldTeam = KOTH.Teams
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
      for k,v in pairs(OldTeam) do
        KOTH.Teams[k].ShopObj = KOTH.Teams[k].ShopObj or 0
        if DoesEntityExist(KOTH.Teams[k].ShopObj) then
          DeleteObject(KOTH.Teams[k].ShopObj)
        end
      end
      KOTH.CreateBlips()
      KOTH.BuildBase()
    end
  end
end)
