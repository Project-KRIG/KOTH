RegisterCommand("bike", function(source, args, rawCommand)
  KOTH.CreateVehicle("TriBike3", 100)
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
