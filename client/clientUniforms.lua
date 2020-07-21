RegisterNetEvent("KOTH:SetUniform")
AddEventHandler("KOTH:SetUniform", function(tab, team)
  KOTH.CurrentTeam = team
  local male = true
  if GetEntityModel(PlayerPedId()) == -1667301416 then
    male = false
  end
  if male then
    local model = `mp_m_freemode_01`
    RequestModel(model)
    while not HasModelLoaded(model) do
      Citizen.Wait(1)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    SetPedPropIndex(PlayerPedId(), 0, 133, tab.Hat-1, 2)
    SetPedComponentVariation(PlayerPedId(), 11, 289, tab.Shirt, 2)
    SetPedComponentVariation(PlayerPedId(), 8, 6, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 3, 11, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 4, 114, tab.Legs, 2)
    SetPedComponentVariation(PlayerPedId(), 6, 89, 0, 2)
  else
    local model = `mp_f_freemode_01`
    RequestModel(model)
    while not HasModelLoaded(model) do
      Citizen.Wait(1)
    end
    SetPlayerModel(PlayerId(), model)
    SetModelAsNoLongerNeeded(model)
    SetPedPropIndex(PlayerPedId(), 0, 132, tab.Hat-1, 2)
    SetPedComponentVariation(PlayerPedId(), 0, 21, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 11, 302, tab.Shirt, 2)
    SetPedComponentVariation(PlayerPedId(), 8, 4, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 3, 4, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 4, 121, tab.Legs, 2)
    SetPedComponentVariation(PlayerPedId(), 6, 93, 0, 2)
  end
end)

function SetNutral()
  local model = `mp_m_freemode_01`
  local male = true
  local saved = GetResourceKvpString("KOTH:Model")
  if saved == "mp_f_freemode_01" then
    model = `mp_f_freemode_01`
    male = false
  end
  RequestModel(model)
  while not HasModelLoaded(model) do
    Citizen.Wait(1)
  end
  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  if male then
    SetPedPropIndex(PlayerPedId(), 0, 133, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 11, 289, 2, 2)
    SetPedComponentVariation(PlayerPedId(), 8, 6, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 3, 11, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 4, 114, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 6, 89, 0, 2)
  else
    SetPedPropIndex(PlayerPedId(), 0, 132, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 0, 21, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 11, 302, 2, 2)
    SetPedComponentVariation(PlayerPedId(), 8, 4, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 3, 4, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 4, 121, 0, 2)
    SetPedComponentVariation(PlayerPedId(), 6, 93, 0, 2)
  end
end
