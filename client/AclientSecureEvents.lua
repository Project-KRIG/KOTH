  
KOTH.CreateEvent = function(eventName, eventRoutine)
  RegisterNetEvent(eventName)
  AddEventHandler(eventName, function(params) if params.AuthKey == KOTH.EventAuthKey then eventRoutine(params) else KOTH.TriggerServerEvent("KOTH:KickCheater", {event = eventName}) end end)
end

KOTH.TriggerServerEvent = function(eventName, params)
  if not params then
    params = {}
  end
  params.AuthKey = KOTH.EventAuthKey
  TriggerServerEvent(eventName, params)
end

KOTH.TriggerEvent = function(eventName, params)
  if not params then
    params = {}
  end
  params.AuthKey = KOTH.EventAuthKey
  TriggerEvent(eventName, params)
end

RegisterNetEvent("KOTH:SendAuthKey")
AddEventHandler("KOTH:SendAuthKey", function(params)
  KOTH.EventAuthKey = params.AuthKey
  KOTH.DebugPrint("KOTH EventAuthKey has been set to: " .. KOTH.EventAuthKey)
end)