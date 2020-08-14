-- SHOP 
Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  while true do 
    Citizen.Wait(5)
      for k,v in pairs(KOTH.Teams) do
        local pos =  vector3(v.ShopLocation.x, v.ShopLocation.y, v.ShopLocation.z)
        local distance = (GetEntityCoords(PlayerPedId()) - vector3(v.ShopLocation.x, v.ShopLocation.y, v.ShopLocation.z))
        if #distance < 5.0 then
          KOTH.DrawText(v.ShopLocation.x, v.ShopLocation.y, v.ShopLocation.z, '~g~[E]~s~ to open shop')
          if IsControlJustPressed(0, 38) then
            TriggerEvent('koth:shop:show')
          end
        end
      end
  end
end)

RegisterCommand("getfuck", function(source, args, rawCommand)
  local player = PlayerPedId()
  local coords = GetEntityCoords(player)
  for k,v in ipairs(KOTH.Teams[KOTH.CurrentTeam].Spawns.Player) do
    print(v.x, v.y, v.z)
  end
end)

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

RegisterNetEvent('koth:ui:level')
AddEventHandler('koth:ui:level', function()
    local level = KOTH.GetPlayerLevel()
    local perc = KOTH.LevelPercentage()
    local curLvl = KOTH.GetPlayerXP()
    local MaxLvl = KOTH.GetLevelThreshold()
    print(level)
    SendNUIMessage({
      level = level,
      perc = perc,
      curLvl = curLvl,
      maxLvl = MaxLvl
    })
    TriggerEvent('koth:ui:sendWeapons')
    TriggerEvent('koth:ui:sendVehicles')
  end)

RegisterNetEvent('koth:ui:sendWeapons')
AddEventHandler('koth:ui:sendWeapons', function()
  local weapons = KOTH.Weapons
  local userLvl = KOTH.GetPlayerLevel()
  SendNUIMessage({
    weapons = weapons,
    userLvl = userLvl
  })
end)

RegisterNetEvent('koth:ui:sendVehicles')
AddEventHandler('koth:ui:sendVehicles', function()
  local vehicles = KOTH.Vehicles
  SendNUIMessage({
    vehicles = vehicles
  })
end)

RegisterNUICallback('koth:ui:buyWeapons', function(data)
  print("WEP: ", data.weapon, KOTH.Weapons[data.weapon].levelReq)
    GiveWeaponToPed(PlayerPedId(), GetHashKey(KOTH.Weapons[data.weapon].Model), 300, true, true)
end)

-- SHOP START
RegisterNetEvent('koth:shop:show')
AddEventHandler('koth:shop:show', function()
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

KOTH.DrawText = function(x, y, z, text)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
      SetTextScale(0.35, 0.35)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(255, 255, 255, 215)
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
      local factor = (string.len(text)) / 370
      DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
  end
end