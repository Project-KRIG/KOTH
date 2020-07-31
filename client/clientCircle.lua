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

function drawTxt2(x,y,font, scale, text, r,g,b,a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextCentre()
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function round2(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

RegisterNetEvent("KOTH:SetMap")
AddEventHandler("KOTH:SetMap", function(map)
  KOTH.SetMap(map)
end)

RegisterNetEvent("KOTH:MovePriorityCircle")
AddEventHandler("KOTH:MovePriorityCircle", function(coords)
  KOTH.PrioCircle.Coords = coords
  KOTH.CreateBlips()
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

KOTH.CreateBlips = function()
  if KOTH.Circle.Blip == nil then
    KOTH.Circle.Blip = AddBlipForCoord(KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z)
    SetBlipSprite(KOTH.Circle.Blip, 1)
    SetBlipDisplay(KOTH.Circle.Blip, 2)
    SetBlipScale(KOTH.Circle.Blip, 1.0)
    SetBlipColour(KOTH.Circle.Blip, 3)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Objective")
    EndTextCommandSetBlipName(KOTH.Circle.Blip)
    KOTH.DebugPrint("Priority Circle Blip Created.")
  else
    SetBlipCoords(KOTH.Circle.Blip, KOTH.Circle.Coords.x, KOTH.Circle.Coords.y, KOTH.Circle.Coords.z)
    KOTH.DebugPrint("Circle blip moved.")
  end
  if KOTH.PrioCircle.Blip == nil then
    KOTH.PrioCircle.Blip = AddBlipForCoord(KOTH.PrioCircle.Coords.x, KOTH.PrioCircle.Coords.y, KOTH.PrioCircle.Coords.z)
    SetBlipSprite(KOTH.PrioCircle.Blip, 1)
    SetBlipDisplay(KOTH.PrioCircle.Blip, 2)
    SetBlipScale(KOTH.PrioCircle.Blip, 1.0)
    SetBlipColour(KOTH.PrioCircle.Blip, 5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Priority Objective")
    EndTextCommandSetBlipName(KOTH.PrioCircle.Blip)
    KOTH.DebugPrint("Priority Circle Blip Created.")
  else
    SetBlipCoords(KOTH.PrioCircle.Blip, KOTH.PrioCircle.Coords.x, KOTH.PrioCircle.Coords.y, KOTH.PrioCircle.Coords.z)
    KOTH.DebugPrint("Priority Circle Blip Moved.")
  end
end
