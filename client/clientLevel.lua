KOTH.AddXP = function(amount)
  local XPAfter = KOTH.GetPlayerXP() + amount
  local XP = XPAfter
  local LevelThreshold = KOTH.GetLevelThreshold()
  if XPAfter > LevelThreshold then
    XP = XPAfter - LevelThreshold
    KOTH.LevelUp()
  end
  KOTH.SetPlayerXP(XP)
  KOTH.DebugPrint(amount .. " XP added.")
  KOTH.TriggerEvent('koth:ui:level')
end

KOTH.GetLevelThreshold = function()
  return KOTH.Levels[KOTH.GetPlayerLevel()].Threshold
end

KOTH.XPTicker = function()
  local InCircle = KOTH.InCircle()
  local XPToAdd = 0
  if InCircle ~= false then
    XPToAdd = 5
    if InCircle == "InPrio" then
      XPToAdd = 10
    end
  end
  if XPToAdd ~= 0 then
    KOTH.AddXP(XPToAdd)
  end
  SetTimeout(KOTH.XPTimer * 1000, KOTH.XPTicker)
end

KOTH.LevelUp = function()
  local Level = KOTH.GetPlayerLevel() + 1
  KOTH.SetPlayerLevel(Level)
  KOTH.DebugPrint("Player leveled up.")
  KOTH.TriggerEvent('koth:ui:level')
end

KOTH.LevelPercentage = function()
  local max = KOTH.GetLevelThreshold()
  local cur = KOTH.GetPlayerXP()

  local perc = round(((cur/max)*100), 0)
  return perc
end
