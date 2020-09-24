Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(0)
  end
  KOTH.Maps = {
    [1] = {
      Circle = {Coords = {x = 1391.81, y = 3136.89, z = 40.7851},Size = 300.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1370.23, y = 2797.582, z = 49.87}, Shop = {x = 1387.274, y = 2799.048, z = 51.25308, p = 0.0, r = 0.0, yaw = 190.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 200.0, y = 999.0, z = 555.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1394.71, y = 3476.89, z = 35.02}, Shop = {x = 1402.27, y = 3476.544, z = 34.77193, p = 0.0, r = 0.0, yaw = 270.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 1723.60, y = 3211.77, z = 43.05}, Shop = {x = 1718.92, y = 3219.07, z = 41.40, p = 0.0, r = 0.0, yaw = 15.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
      },
    },
    [2] = {
      Circle = {Coords = {x = 1882.54, y = 3786.0, z = 32.8061},Size = 200.0,PlayersInside = {}},
      Spawns = {
        ["Yellow"] = {Player = {x = 1732.87, y = 3684.40, z = 34.7}, Shop = {x = 1741.97, y = 3690.58, z = 33.55, p = 0.0, r = 0.0, yaw = -65.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Blue"] = {Player = {x = 1833.72, y = 3958.39, z = 33.22}, Shop = {x = 1838.379, y = 3954.987, z = 33.02042, p = 0.0, r = 0.0, yaw = -90.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
        ["Green"] = {Player = {x = 2044.645, y = 3866.09, z = 31.94}, Shop = {x = 2041.24, y = 3872.82, z = 30.80, p = 0.0, r = 0.0, yaw = 40.0}, Car = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}, Helicopter = {x = 0.0, y = 0.0, z = 0.0, h = 0.0}},
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
