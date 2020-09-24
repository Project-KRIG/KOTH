KOTH.CreateObject = function(object, coords, pitch, roll, yaw)
    local object = GetHashKey(object)

    RequestModel(object)
    if not HasModelLoaded(object) then
        Citizen.Wait(100)
    end
    object = CreateObject(object, coords.x, coords.y, coords.z, false, false, true)
    PlaceObjectOnGroundProperly(object)
    SetEntityRotation(object, pitch, roll, yaw, 2, true)
    FreezeEntityPosition(object, true)
    SetEntityAsMissionEntity(object)
    return object
end


KOTH.BuildBase = function()
  for k,v in pairs(KOTH.Teams) do
    KOTH.Teams[k].ShopObj = KOTH.Teams[k].ShopObj or 0
    if not DoesEntityExist(KOTH.Teams[k].ShopObj) then
      local pos =  vector3(v.Spawns.Shop.x, v.Spawns.Shop.y, v.Spawns.Shop.z)
      KOTH.Teams[k].ShopObj = KOTH.CreateObject('gr_prop_gr_bench_01a', pos, v.Spawns.Shop.p, v.Spawns.Shop.r, v.Spawns.Shop.yaw)
    end
  end
end

KOTH.CreateVehicle = function(model, price)
if KOTH.GetMoney() > price then
  if KOTH.Vehicle ~= nil then
    KOTH.DebugPrint("Player had a vehicle.")
    if DoesEntityExist(KOTH.Vehicle) then
      DeleteVehicle(KOTH.Vehicle)
      KOTH.DebugPrint("Old vehicle deleted.")
    end
    KOTH.Vehicle = nil
  end
  local model = GetHashKey(model)
  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(0)
  end
  KOTH.Vehicle = CreateVehicle(model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), true)
  KOTH.DebugPrint("Vehicle Created.")
  SetModelAsNoLongerNeeded(model)
  SetPedIntoVehicle(PlayerPedId(), KOTH.Vehicle, -1)
  KOTH.DebugPrint("Ped set into vehicle.")
  KOTH.SetMoney(KOTH.GetMoney()-price)
end
end

KOTH.DeleteVehicle = function()
if KOTH.Vehicle ~= nil then
  KOTH.DebugPrint("Player had a vehicle.")
  if DoesEntityExist(KOTH.Vehicle) then
    DeleteVehicle(KOTH.Vehicle)
    KOTH.DebugPrint("Old vehicle deleted.")
  end
  KOTH.Vehicle = nil
end
end


KOTH.SpawnBoughtVehicle = function(model, price, x, y, z, heading) 
  if KOTH.GetMoney() > price then

    if KOTH.Vehicle ~= nil then
      KOTH.DebugPrint("Player had a vehicle.")
      if DoesEntityExist(KOTH.Vehicle) then
        DeleteVehicle(KOTH.Vehicle)
        KOTH.DebugPrint("Old vehicle deleted.")
      end
      KOTH.Vehicle = nil
    end

    local model = GetHashKey(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
    Citizen.Wait(0)
    end

    KOTH.Vehicle = CreateVehicle(model, x, y, z, heading, true)
    KOTH.DebugPrint("Vehicle Created.")
    SetModelAsNoLongerNeeded(model)
    SetPedIntoVehicle(PlayerPedId(), KOTH.Vehicle, -1)
    KOTH.DebugPrint("Ped set into vehicle.")
    KOTH.SetMoney(KOTH.GetMoney()-price)

  end
end

Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  Citizen.Wait(5000)
  while true do
    local playercount = 0
    for k, v in pairs(KOTH.Mumble.Players) do
      playercount = playercount + 1
    end
		SetRichPresence("KOTH: " .. playercount .. " Players.")
		Citizen.Wait(60000)
  end
end)
