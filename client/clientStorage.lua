KOTH.GetPlayerLevel = function()
  local level = GetResourceKvpInt("KOTH:Level")
  if level == 0 then
    SetResourceKvpInt("KOTH:Level", 1)
    level = 1
  end
  return level
end

KOTH.GetPlayerXP = function()
  return GetResourceKvpInt("KOTH:XP")
end

KOTH.SetPlayerXP = function(amount)
  SetResourceKvpInt("KOTH:XP", amount)
end

KOTH.SetPlayerLevel = function(level)
  SetResourceKvpInt("KOTH:Level", level)
end

KOTH.GetPlayerKills = function()
  return GetResourceKvpInt("KOTH:Kills")
end

KOTH.SetPlayerKills = function(kills)
  SetResourceKvpInt("KOTH:Kills", kills)
end

KOTH.GetPlayerDeaths = function()
  return GetResourceKvpInt("KOTH:Deaths")
end

KOTH.SetPlayerDeaths = function(deaths)
  SetResourceKvpInt("KOTH:Deaths", deaths)
end

KOTH.SetPlayerModel = function(male)
  if male then
    SetResourceKvp("KOTH:Model", "mp_m_freemode_01")
  else
    SetResourceKvp("KOTH:Model", "mp_f_freemode_01")
  end
end
