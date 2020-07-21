Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  KOTH.DebugPrint = function(text)
    if KOTH.Debug then
      print("[KOTH DEBUG] " .. text)
    end
  end
end)
