--Citizen.CreateThread(function()
--  while true do
--    Citizen.Wait(0)
--    DrawRect(0.8, 0.7, 0.15, 0.25, 255, 255, 255, 1.0)
--  end
--end)

RegisterNetEvent("KOTH:OpenStartUi")
AddEventHandler("KOTH:OpenStartUi", function()
  SendNUIMessage({
    KOTHUI = true,
    StartUI = true,
  })
  SetNuiFocus(true, true)
  TriggerServerEvent("KOTH:RequstPlayerCount")
end)

RegisterNUICallback('WelcomeClosed', function(data, cb)
  if GetResourceKvpString("KOTH:Model") == nil then
    SendNUIMessage({
      StartUI = false,
      KOTHUI = true,
      ChangeModel = true,
    })
  else
    SendNUIMessage({
      StartUI = false,
      KOTHUI = true,
      ChooseTeam = true,
    })
  end
  cb('ok')
end)

RegisterNUICallback("GenderSelect", function(data, cb)
  if data.Gender then
    SetResourceKvp("KOTH:Model", "mp_m_freemode_01")
  else
    SetResourceKvp("KOTH:Model", "mp_f_freemode_01")
  end
  SetNutral()
  SendNUIMessage({
    ChangeModel = false,
    KOTHUI = true,
    ChooseTeam = true,
  })
end)

RegisterNUICallback("TeamSelect", function(data, cb)
  TriggerServerEvent("KOTH:JoinTeam", data.Team)
  SendNUIMessage({
    KOTHUI = true,
    ChooseTeam = false,
  })
  SetNuiFocus(false, false)
end)

RegisterNetEvent("KOTH:UpdatePlayerCount")
AddEventHandler("KOTH:UpdatePlayerCount", function(tab)
  SendNUIMessage({
    PlayerCounts = true,
    Yellow = tab.Yellow,
    Green = tab.Green,
    Blue = tab.Blue,
  })
  if tab.Yellow > tab.Blue or tab.Yellow > tab.Green then
    SendNUIMessage({
      LockTeam = true,
      TeamToLock = "Yellow",
    })
  else
    SendNUIMessage({
      UnlockTeam = true,
      TeamToUnlock = "Yellow",
    })
  end
  if tab.Blue > tab.Yellow or tab.Blue > tab.Green then
    SendNUIMessage({
      LockTeam = true,
      TeamToLock = "Blue",
    })
  else
    SendNUIMessage({
      UnlockTeam = true,
      TeamToUnlock = "Blue",
    })
  end
  if tab.Green > tab.Blue or tab.Green > tab.Yellow then
    SendNUIMessage({
      LockTeam = true,
      TeamToLock = "Green",
    })
  else
    SendNUIMessage({
      UnlockTeam = true,
      TeamToUnlock = "Green",
    })
  end
end)


RegisterNetEvent("KOTH:UpdatePoints")
AddEventHandler("KOTH:UpdatePoints", function(tab)
  SendNUIMessage({
    UpdatePoints = true,
    Yellow = tab.Yellow,
    Green = tab.Green,
    Blue = tab.Blue,
  })
end)

RegisterCommand('TestTeam', function(source, args, rawCommand)
  SendNUIMessage({
    KOTHUI = true,
    ChooseTeam = true,
  })
end, false)

--Citizen.CreateThread(function()
--  Citizen.Wait(1000)
--  SetNuiFocus(false, false)
--end)
