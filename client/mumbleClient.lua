--[[
THIS FILE IS A MODIFIED VERSION OF https://github.com/FrazzIe/mumble-voip/blob/master/client.lua I HAVE JUST MADE THIS WORK IN ONESYNC
INFINITY AND ADAPTED IT FOR THIS RESOURCE.
]]

LocalServerID = GetPlayerServerId(PlayerId())

RegisterNetEvent("KOTH:SyncMumblePlayers")
AddEventHandler("KOTH:SyncMumblePlayers", function(PTab)
  KOTH.Mumble.Players = PTab
end)

RegisterNetEvent("KOTH:SetMumbleChannel")
AddEventHandler("KOTH:SetMumbleChannel", function(source, channel)
  KOTH.Mumble.Players[source].Channel = channel
end)

RegisterNetEvent("KOTH:MumbleTalking")
AddEventHandler("KOTH:MumbleTalking", function(source, bool)
  KOTH.Mumble.Players[source].IsTalking = bool
end)

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

Citizen.CreateThread(function()
  while KOTH.Mumble.Players[LocalServerID] == nil do
    Citizen.Wait(500)
  end
  while true do
    Citizen.Wait(0)

    local RadioActive = KOTH.Mumble.Players[LocalServerID].IsTalking or false

    if RadioActive then
			SetControlNormal(0, 249, 1.0)
			SetControlNormal(1, 249, 1.0)
			SetControlNormal(2, 249, 1.0)
		end

    if not RadioActive then
      if IsControlJustPressed(0, KOTH.Mumble.Config.RadioControl) then
        TriggerServerEvent("KOTH:MumbleTalking", true)
        RadioActive = true
        Citizen.CreateThread(function()
          while IsControlPressed(0, KOTH.Mumble.Config.RadioControl) do
            Citizen.Wait(0)
          end

          TriggerServerEvent("KOTH:MumbleTalking", false)
          RadioActive = false
        end)
      end
    end



  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)

    local LocalPed = PlayerPedId()
    local LocalPos = GetEntityCoords(LocalPed)
    local LocalData = KOTH.Mumble.Players[LocalServerID]

    local PlayersToHear = {}

    --[[ FIGURE OUT WHICH PLAYERS TO HEAR ]]
    for ServerID, VoiceData in pairs(KOTH.Mumble.Players) do
      if ServerID ~= LocalServerID then
        local OtherPos = VoiceData.PlayerPos
        local Distance = #(LocalPos - OtherPos)

        if Distance <= KOTH.Mumble.Config.Range then
          if VoiceData.IsTalking and VoiceData.Channel == LocalData.Channel then
            PlayersToHear[ServerID] = 1.0
            KOTH.Mumble.ToggleRadioEffect(ServerID, true)
          else
            KOTH.Mumble.ToggleRadioEffect(ServerID, false)
            PlayersToHear[ServerID] = round(1.0 - (Distance / KOTH.Mumble.Config.Range) + 0.0001, 2)
          end
        else
          if VoiceData.IsTalking and VoiceData.Channel == LocalData.Channel then
            PlayersToHear[ServerID] = 1.0
            KOTH.Mumble.ToggleRadioEffect(ServerID, true)
          else
            KOTH.Mumble.ToggleRadioEffect(ServerID, false)
            PlayersToHear[ServerID] = 0.0
          end
        end
      end
    end

    --[[ NOW LETS ACTUALLY HEAR THOSE PLAYERS ]]
    for ServerID, Volume in pairs(PlayersToHear) do
      MumbleSetVolumeOverrideByServerId(ServerID, Volume)
    end

  end
end)

KOTH.Mumble.ToggleRadioEffect = function(player, bool)
  if KOTH.Mumble.ClientData[player] == nil then
    KOTH.Mumble.ClientData[player] = {}
  end
  if bool and KOTH.Mumble.ClientData[player].BFN == nil then
    local p = GetPlayerFromServerId(player)
    if p == -1 then
      return
    end
    KOTH.Mumble.ClientData[player].Context = n.GET_AUDIOCONTEXT_FOR_CLIENT(p, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    KOTH.Mumble.ClientData[player].Source = n.AUDIOCONTEXT_GET_SOURCE(KOTH.Mumble.ClientData[player].Context, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    KOTH.Mumble.ClientData[player].Destination = n.AUDIOCONTEXT_GET_DESTINATION(KOTH.Mumble.ClientData[player].Context, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    local curve = distortionCurve(20) -- just any function that outputs an array of numbers to describe distortion
    local wsn = n.AUDIOCONTEXT_CREATE_WAVESHAPERNODE(KOTH.Mumble.ClientData[player].Context, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    n.WAVESHAPERNODE_SET_CURVE(wsn, makeObject(curve))
    bfn = n.AUDIOCONTEXT_CREATE_BIQUADFILTERNODE(KOTH.Mumble.ClientData[player].Context, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    n.BIQUADFILTERNODE_SET_TYPE(bfn, "lowshelf")
    n.BIQUADFILTERNODE_FREQUENCY(bfn, 1000.0)
    local f = n.BIQUADFILTERNODE_GAIN(bfn, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    n.AUDIOPARAM_SET_VALUE(f, -50.0)
    KOTH.Mumble.ClientData[player].BFN = n.AUDIOCONTEXT_CREATE_BIQUADFILTERNODE(KOTH.Mumble.ClientData[player].Context, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
    n.BIQUADFILTERNODE_SET_TYPE(KOTH.Mumble.ClientData[player].BFN, "highpass")
    n.BIQUADFILTERNODE_FREQUENCY(KOTH.Mumble.ClientData[player].BFN, 24000.0)
    n.BIQUADFILTERNODE_GAIN(KOTH.Mumble.ClientData[player].BFN, 2150.0)

    n.AUDIOCONTEXT_CONNECT(KOTH.Mumble.ClientData[player].Context, wsn, KOTH.Mumble.ClientData[player].Source, 0, 0)
    Citizen.Wait(1)
    n.AUDIOCONTEXT_CONNECT(KOTH.Mumble.ClientData[player].Context, bfn, wsn, 0, 0)
    Citizen.Wait(1)
    n.AUDIOCONTEXT_CONNECT(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].BFN, bfn, 0, 0)
    Citizen.Wait(1)
    n.AUDIOCONTEXT_CONNECT(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].BFN, 0, 0)
  elseif not bool and KOTH.Mumble.ClientData[player].BFN ~= nil then
    n.AUDIOCONTEXT_DISCONNECT(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].BFN, 0, 0)
    Citizen.Wait(1)
    n.AUDIOCONTEXT_CONNECT(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].Source, 0, 0)
    KOTH.Mumble.ClientData[player].BFN = nil
  end
end

n = setmetatable({}, {
    __index = function(t, k)
        return function(...)
            return Citizen.InvokeNative(GetHashKey(k) & 0xFFFFFFFF, ...)
        end
    end
})

function distortionCurve(k)
  local curve = {}

    local deg = math.pi / 180

    for i = 1, 42000 do
        local x = (i - 1) * 2 / 48000 - 1;
        curve[i] = ( 3 + k ) * x * 20 * deg / ( math.pi + k * math.abs(x) );
    end
    return curve
end

function makeObject(data)
    local d = msgpack.pack(data)

    return string.pack('<T', #d) .. d
end
