Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end

  KOTH.Levels = {
    [1] = {
      Threshold = 1000,
      Rank = "Private"
    },
    [2] = {
      Threshold = 2000,
      Rank = "Private First Class"
    },
    [3] = {
      Threshold = 3000,
      Rank = "Specialist"
    },
    [4] = {
      Threshold = 4000,
      Rank = "Corporal"
    },
    [5] = {
      Threshold = 5000,
      Rank = "Sergeant"
    },
    [6] = {
      Threshold = 6000,
      Rank = "Staff Sergeant"
    },
    [7] = {
      Threshold = 7000,
      Rank = "Sergeant First Class"
    },
    [8] = {
      Threshold = 8000,
      Rank = "Master Sergeant"
    },
    [9] = {
      Threshold = 9000,
      Rank = "First Sergeant"
    },
    [10] = {
      Threshold = 1000000,
      Rank = "Sergeant Major"
    },
  }

end)
