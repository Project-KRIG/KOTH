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

KOTH.CreateEvent("KOTH:SyncTime", function(params)
  KOTH.Hour = params.hour
  KOTH.Minute = params.minute
  NetworkOverrideClockTime(KOTH.Hour, KOTH.Minute, 0)
end)

KOTH.CreateEvent("KOTH:SyncWeather", function(params)
  KOTH.Weather = params.weather
  SetWeatherTypeNowPersist(KOTH.Weather)
  KOTH.DebugPrint("Weather updated, Weather: " .. KOTH.Weather)
end)
