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
            KOTH.TriggerEvent('koth:shop:show')
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

KOTH.CreateEvent("KOTH:OpenStartUi", function()
  SendNUIMessage({
    KOTHUI = true,
    StartUI = true,
  })
  SetNuiFocus(true, true)
  KOTH.TriggerServerEvent("KOTH:RequstPlayerCount")
  KOTH.DebugPrint("Start UI Opened.")
end)

KOTH.CreateEvent("koth:ui:money", function()
  local money = KOTH.GetMoney()
  print(money)
  SendNUIMessage({
    money = money
  })
end)

KOTH.CreateEvent("koth:ui:level", function()
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
  KOTH.TriggerEvent('koth:ui:sendWeapons')
  KOTH.TriggerEvent('koth:ui:sendVehicles')
end)

KOTH.CreateEvent("koth:ui:sendWeapons", function()
  local weapons = KOTH.Weapons
  local userLvl = KOTH.GetPlayerLevel()
  SendNUIMessage({
    weapons = weapons,
    userLvl = userLvl
  })
end)

KOTH.CreateEvent("koth:ui:sendVehicles", function()
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
KOTH.CreateEvent("koth:shop:show", function()
  SendNUIMessage({
    ShopUI = true
  })
  SetNuiFocus(true, true)
end)


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
  KOTH.TriggerServerEvent("KOTH:JoinTeam", {Team = data.Team})
  SendNUIMessage({
    KOTHUI = true,
    ChooseTeam = false,
  })
  SetNuiFocus(false, false)
  KOTH.DebugPrint("Player joined team " .. data.Team .. ".")
end)

KOTH.CreateEvent("KOTH:UpdatePlayerCount", function(params)
  SendNUIMessage({
    PlayerCounts = true,
    Yellow = params.Yellow,
    Green = params.Green,
    Blue = params.Blue,
  })
  if KOTH.LockTeamsIfUneaven then
    if params.Yellow > params.Blue or params.Yellow > params.Green then
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
    if params.Blue > params.Yellow or params.Blue > params.Green then
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
    if params.Green > params.Blue or params.Green > params.Yellow then
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
  KOTH.DebugPrint("Current player counts Y:" .. params.Yellow .. " G:" .. params.Green .. " B:" .. params.Blue .. ".")
end)


KOTH.CreateEvent("KOTH:ShowWin", function()
  SendNUIMessage({
    Win = true,
    WinningTeam = team
  })
  KOTH.DebugPrint("Win screen opened.")
  SetTimeout(5000, function() SendNUIMessage({Win = false}) end)
  KOTH.DebugPrint("Win screen closed.")
end)

KOTH.CreateEvent("KOTH:UpdatePoints", function(params)
  local tab = params.Points
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
