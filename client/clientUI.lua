RegisterNetEvent("KOTH:OpenStartUi")
AddEventHandler("KOTH:OpenStartUi", function()
  SendNUIMessage({
    KOTHUI = true,
    StartUI = true,
  })
  SetNuiFocus(true, true)
  TriggerServerEvent("KOTH:RequstPlayerCount")
  KOTH.DebugPrint("Start UI Opened.")
end)

RegisterNetEvent('koth:ui:money')
AddEventHandler('koth:ui:money', function()
    local money = KOTH.GetMoney()
    print(money)
    SendNUIMessage({
      money = money
    })
end)


-- SHOP START
RegisterCommand('koth:shop:show', function(source, args, rawCommand)

  SendNUIMessage({
    ShopUI = true
  })
  SetNuiFocus(true, true)

end, false)


RegisterCommand('koth:shop:hide', function(source, args, rawCommand)
  SendNUIMessage({
    ShopUI = false
  })
  SetNuiFocus(false, false)
end, false)

RegisterNUICallback('koth:shop:close', function()
  SendNUIMessage({
    ShopUI = false
  })
  SetNuiFocus(false, false)
end)

-- SHOP END

RegisterNUICallback('WelcomeClosed', function(data, cb)
  if GetResourceKvpString("KOTH:Model") == "None" then
    SendNUIMessage({
      StartUI = false,
      KOTHUI = true,
      ChangeModel = true,
    })
    KOTH.DebugPrint("Gender menu opened.")
  else
    SendNUIMessage({
      StartUI = false,
      KOTHUI = true,
      ChooseTeam = true,
    })
    KOTH.DebugPrint("Team menu opened.")
  end
  cb('ok')
end)

RegisterNUICallback("GenderSelect", function(data, cb)
  if data.Gender then
    SetResourceKvp("KOTH:Model", "mp_m_freemode_01")
  else
    SetResourceKvp("KOTH:Model", "mp_f_freemode_01")
  end
  KOTH.SetNutral()
  SendNUIMessage({
    ChangeModel = false,
    KOTHUI = true,
    ChooseTeam = true,
  })
  KOTH.DebugPrint("Team menu opened.")
end)

RegisterNUICallback("TeamSelect", function(data, cb)
  TriggerServerEvent("KOTH:JoinTeam", data.Team)
  SendNUIMessage({
    KOTHUI = true,
    ChooseTeam = false,
  })
  SetNuiFocus(false, false)
  KOTH.DebugPrint("Player joined team " .. data.Team .. ".")
end)

RegisterNetEvent("KOTH:UpdatePlayerCount")
AddEventHandler("KOTH:UpdatePlayerCount", function(tab)
  SendNUIMessage({
    PlayerCounts = true,
    Yellow = tab.Yellow,
    Green = tab.Green,
    Blue = tab.Blue,
  })
  if KOTH.LockTeamsIfUneaven then
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
  end
  KOTH.DebugPrint("Current player counts Y:" .. tab.Yellow .. " G:" .. tab.Green .. " B:" .. tab.Blue .. ".")
end)

RegisterNetEvent("KOTH:ShowWin")
AddEventHandler("KOTH:ShowWin", function(team)
  SendNUIMessage({
    Win = true,
    WinningTeam = team
  })
  KOTH.DebugPrint("Win screen opened.")
  SetTimeout(5000, function() SendNUIMessage({Win = false}) end)
  KOTH.DebugPrint("Win screen closed.")
end)


RegisterNetEvent("KOTH:UpdatePoints")
AddEventHandler("KOTH:UpdatePoints", function(tab)
  SendNUIMessage({
    UpdatePoints = true,
    Yellow = tab.Yellow,
    Green = tab.Green,
    Blue = tab.Blue,
  })
  KOTH.DebugPrint("Current points Y:" .. tab.Yellow .. " G:" .. tab.Green .. " B:" .. tab.Blue .. ".")
end)


