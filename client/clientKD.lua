KOTH.GetKill = function()
  local Kills = KOTH.GetPlayerKills() + 1
  KOTH.SetPlayerKills(Kills)
  KOTH.AddXP(100)
  KOTH.SetMoney((KOTH.GetMoney() + 50))
  KOTH.DebugPrint("Player got a kill and now has ".. Kills .." kills.")
end

KOTH.PlayerDied = function()
  local Deaths = KOTH.GetPlayerDeaths() + 1
  KOTH.SetPlayerDeaths(Deaths)
  KOTH.DebugPrint("Player died and now has ".. Deaths .." deaths.")
end

KOTH.GetKD = function()
  local Kills = KOTH.GetPlayerKills()
  local Deaths = KOTH.GetPlayerDeaths()
  local KD = Kills / Deaths
  KOTH.DebugPrint("Player's KD is " .. KD .. ".")
  return KD
end

KOTH.CreateEvent("KOTH:GetKill", function()
  KOTH.GetKill()
end)

KOTH.CreateEvent("KOTH:Died", function()
  KOTH.PlayerDied()
end)

KOTH.SpawnPoint = function()
  KOTH.TriggerEvent("KOTH:SetUniform", {Clothes = KOTH.Teams[KOTH.CurrentTeam].Colors, Team = KOTH.CurrentTeam})
end

KOTH.DefaultSpawn = function()
  SetEntityCoords(PlayerPedId(), KOTH.Spawn.x, KOTH.Spawn.y, KOTH.Spawn.z)
end

Citizen.CreateThread(function()
  AddRelationshipGroup('Yellow')
  AddRelationshipGroup('Green')
  AddRelationshipGroup('Blue')

  SetRelationshipBetweenGroups(5, 'Yellow', 'Green')
  SetRelationshipBetweenGroups(5, 'Yellow', 'Blue')

  SetRelationshipBetweenGroups(5, 'Green', 'Yellow')
  SetRelationshipBetweenGroups(5, 'Green', 'Blue')

  SetRelationshipBetweenGroups(5, 'Blue', 'Green')
  SetRelationshipBetweenGroups(5, 'Blue', 'Yellow')
end)

RegisterNetEvent("playerSpawned")
AddEventHandler("playerSpawned", function()
  NetworkSetLocalPlayerInvincibleTime(1000)
  if KOTH.CurrentTeam ~= "None" then
    KOTH.SpawnPoint()
  else
    KOTH.DefaultSpawn()
  end
end)
