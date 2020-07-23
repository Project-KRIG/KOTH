KOTH.GetKill = function()
  local Kills = KOTH.GetPlayerKills() + 1
  KOTH.SetPlayerKills(Kills)
  KOTH.AddXP(100)
  KOTH.SetMoney((KOTH.GetMoney() - 50))
end

KOTH.PlayerDied = function()
  local Deaths = KOTH.GetPlayerDeaths() + 1
  KOTH.SetPlayerDeaths(Deaths)
end

KOTH.GetKD = function()
  local Kills = KOTH.GetPlayerKills()
  local Deaths = KOTH.GetPlayerDeaths()
  local KD = Kills / Deaths
  return KD
end

RegisterNetEvent("KOTH:GetKill")
AddEventHandler("KOTH:GetKill", function()
  KOTH.GetKill()
end)


RegisterNetEvent("KOTH:Died")
AddEventHandler("KOTH:Died", function()
  KOTH.PlayerDied()
end)

KOTH.SpawnPoint = function()
  TriggerEvent("KOTH:SetUniform", KOTH.Teams[KOTH.CurrentTeam].Colors, KOTH.CurrentTeam)
end

KOTH.DefaultSpawn = function()
  SetEntityCoords(PlayerPedId(), KOTH.Spawn.x, KOTH.Spawn.y, KOTH.Spawn.z)
end

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
  if KOTH.CurrentTeam ~= "None" then
    KOTH.SpawnPoint()
  else
    KOTH.DefaultSpawn()
  end
end)
