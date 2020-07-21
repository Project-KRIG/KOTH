KOTH.AddXP = function(amount)
  local XPAfter = KOTH.GetPlayerXP() + amount
  local XP = XPAfter
  local LevelThreshold = KOTH.Levels[KOTH.GetPlayerLevel()].Threshold
  if XPAfter > LevelThreshold then
    XP = XPAfter - LevelThreshold
    KOTH.LevelUp()
  end
  KOTH.SetPlayerXP(XP)
  KOTH.DebugPrint(amount .. " XP added.")
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
end
