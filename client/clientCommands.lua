RegisterCommand("resetgender", function(source, args, rawCommand)
  SetResourceKvp("KOTH:Model", "None")
end)

peds = {}

RegisterCommand("spawnpeds", function(source, args, rawCommand)
  local model = `mp_m_freemode_01`
  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(1)
  end
  for k, v in pairs(KOTH.Teams) do
    for i = 1, 20 do
      local ped = CreatePed(1, model, v.Spawns.Player.x, v.Spawns.Player.y, v.Spawns.Player.z, 0.0, true)
      SetPedPropIndex(ped, 0, 133, v.Colors.Hat-1, 2)
      SetPedComponentVariation(ped, 11, 289, v.Colors.Shirt, 2)
      SetPedComponentVariation(ped, 8, 6, 0, 2)
      SetPedComponentVariation(ped, 3, 11, 0, 2)
      SetPedComponentVariation(ped, 4, 114, v.Colors.Legs, 2)
      SetPedComponentVariation(ped, 6, 89, 0, 2)
      GiveWeaponToPed(ped, `weapon_carbinerifle`, 100, false, true)
      SetCurrentPedWeapon(ped, `weapon_carbinerifle`, true)
      SetPedInfiniteAmmo(ped, true, `weapon_carbinerifle`)
      --TaskGoStraightToCoord(ped, KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z, 5.0, -1, 0.0, 5.0)
      TaskGoToCoordAndAimAtHatedEntitiesNearCoord(ped, KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z, KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z, 5.0, true, 5.0, 1.0,false,16,1,-957453492)
      SetPedRelationshipGroupHash(ped, k)
      peds[#peds+1] = ped
    end
  end
  --Citizen.CreateThread(function()
  --  while #peds > 1 do
  --    Citizen.Wait(500)
  --    for k, v in pairs(peds) do
  --      ForcePedMotionState(v, -1115154469, 0, 0, 0)
  --    end
  --  end
  --end)
end)

RegisterCommand("deletepeds", function(source, args, rawCommand)
  for k, v in pairs(peds) do
    DeletePed(v)
  end
  peds = {}
end)
