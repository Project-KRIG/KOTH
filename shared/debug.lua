Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  KOTH.DebugPrint = function(text)
    if KOTH.Debug then
      print("[^5KOTH^7] ^1DEBUG^7: ^3" .. text)
    end
  end
end)
