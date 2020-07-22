Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  Citizen.Wait(1000)
  KOTH.XPTicker()
  while true do
    Citizen.Wait(0)
    DrawMarker(1, KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z-20.0, 0, 0, 0, 0, 0, 0, KOTH.Circle.Size, KOTH.Circle.Size, 100.0, 44, 165, 255, 100, false, false, 0, false)
    DrawMarker(1, KOTH.PrioCircle.Coords.x, KOTH.PrioCircle.Coords.y, KOTH.PrioCircle.Coords.z-20.0, 0, 0, 0, 0, 0, 0, KOTH.PrioCircle.Size, KOTH.PrioCircle.Size, 100.0, 230, 173, 18, 70, false, false, 0, false)
    KOTH.InCircle()
  end
end)

RegisterNetEvent("KOTH:SetMap")
AddEventHandler("KOTH:SetMap", function(map)
  KOTH.SetMap(map)
end)

RegisterNetEvent("KOTH:MovePriorityCircle")
AddEventHandler("KOTH:MovePriorityCircle", function(coords)
  KOTH.PrioCircle.Coords = coords
  KOTH.DebugPrint("Priority circle updated.")
end)

KOTH.InCircle = function()
  local InCircle = false
  local InPrio = false
  local MainCircle = (GetEntityCoords(PlayerPedId()) - vector3(KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z))
	if (#MainCircle <= (KOTH.Circle.Size / 2) + 2) then
    InCircle = true
	end
  local PrioCircle = (GetEntityCoords(PlayerPedId()) - vector3(KOTH.PrioCircle.Coords.x, KOTH.PrioCircle.Coords.y, KOTH.PrioCircle.Coords.z))
	if (#PrioCircle <= (KOTH.PrioCircle.Size / 2)) then
    InPrio = true
	end
  if InPrio then
    return "InPrio"
  elseif InCircle then
    return "InCircle"
  else
    return false
  end
end
