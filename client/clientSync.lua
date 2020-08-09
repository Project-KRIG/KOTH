Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  if not KOTH.TimeEnabled then
    PauseClock(true)
    NetworkOverrideClockTime(KOTH.Hour, KOTH.Minute, 0)
  end
  if not KOTH.WeatherEnabled then
    SetWeatherTypeNowPersist(KOTH.Weather)
  end
end)

RegisterNetEvent("KOTH:SyncTime")
AddEventHandler("KOTH:SyncTime", function(hour, minute)
  KOTH.Hour = hour
  KOTH.Minute = minute
  NetworkOverrideClockTime(KOTH.Hour, KOTH.Minute, 0)
end)

RegisterNetEvent("KOTH:SyncWeather")
AddEventHandler("KOTH:SyncWeather", function(weather)
  KOTH.Weather = weather
  SetWeatherTypeNowPersist(KOTH.Weather)
  KOTH.DebugPrint("Weather updated, Weather: " .. KOTH.Weather)
end)
