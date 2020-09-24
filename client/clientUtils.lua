KOTH.CreateObject = function(object, coords, pitch, roll, yaw)
    local object = GetHashKey(object)

    RequestModel(object)
    if not HasModelLoaded(object) then
        Citizen.Wait(100)
    end
    CreateObject(object, coords.x, coords.y, coords.z, false, false, true)

    local handle = object
    SetEntityRotation(handle, pitch, roll, yaw, 2, true)
end


KOTH.BuildBase = function()
    for k,v in ipairs(KOTH.Shop) do
        local pos =  vector3(v.x, v.y, v.z)
        KOTH.CreateObject('gr_prop_gr_bench_01a', pos, v.p, v.r, v.yaw)
        print(v.p, v.r, v.yaw)
    end
end

-- DEV COMMAND
RegisterCommand("bike", function(source, args, rawCommand)
  print(args[1])
  KOTH.CreateVehicle(args[1], 100)
end)


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
  