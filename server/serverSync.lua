Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  while true do
    Citizen.Wait(2000)
    if KOTH.TimeEnabled then
      if KOTH.Minute == 59 then
        KOTH.Minute = 0
        if KOTH.Hour == 23 then
          KOTH.Hour = 0
        else
          KOTH.Hour = KOTH.Hour + 1
        end
      else
        KOTH.Minute = KOTH.Minute + 1
      end
      for k, v in pairs(KOTH.Players) do
        KOTH.TriggerClientEvent("KOTH:SyncTime", k, {hour = KOTH.Hour, minute = KOTH.Minute})
      end
    end
    if KOTH.WeatherEnabled then
      if KOTH.WeatherTimer == 150 then
        KOTH.WeatherTimer = 0
        if math.random(1, 100) < KOTH.WeatherChance then
          KOTH.Weather = KOTH.WeatherTypes[math.random(1, #KOTH.WeatherTypes)]
          for k, v in pairs(KOTH.Players) do
            KOTH.TriggerClientEvent("KOTH:SyncWeather", k, {weather = KOTH.Weather})
          end
        end
      end
      KOTH.WeatherTimer = KOTH.WeatherTimer + 1
    end
  end
end)
