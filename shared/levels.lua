Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end

  KOTH.Levels = {
    [1] = {
      Threshold = 1000,
      Rank = "Recruit"
    },
    [2] = {
      Threshold = 2000,
      Rank = "Cadet"
    }
  }
  
end)
