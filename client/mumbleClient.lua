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
          else
            PlayersToHear[ServerID] = round(1.0 - (Distance / KOTH.Mumble.Config.Range) + 0.0001, 2)
          end
        else
          if VoiceData.IsTalking and VoiceData.Channel == LocalData.Channel then
            PlayersToHear[ServerID] = 1.0
          else
            PlayersToHear[ServerID] = 0.0
          end
        end
      end
    end

    --[[ NOW LETS ACTUALLY HEAR THOSE PLAYERS ]]
    for ServerID, Volume in pairs(PlayersToHear) do
      MumbleSetVolumeOverride(GetPlayerFromServerId(ServerID), Volume)
    end

  end
end)

--[[ MUMBLE RADIO DISTORTION ]]

KOTH.Mumble.GetPlayerAudioContext = function(PlayerServerID)
  return n.GET_AUDIOCONTEXT_FOR_CLIENT(GetPlayerFromServerId(PlayerID), Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
end

KOTH.Mumble.GetSourceDestination = function(PlayerAudioContext)
  local source = n.AUDIOCONTEXT_GET_SOURCE(PlayerAudioContext, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
  local destination = n.AUDIOCONTEXT_GET_DESTINATION(PlayerAudioContext, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
  return source, destination
end

--[[
KOTH.Mumble.AudioContextConnect(PlayerAudioContext, Source, Destination, [OPTIONAL]Filter)
CONNECTS NODES

EXAMPLES:

KOTH.Mumble.AudioContextConnect(PlayerAudioContext, source, destination) - Connects the default nodes removing all filters, must be called after clearning the filters..
KOTH.Mumble.AudioContextDisconnect(PlayerAudioContext, source, destination, filter) - Enables that specific filter.
]]


KOTH.Mumble.AudioContextConnect = function(PlayerAudioContext, Source, Destination, Filter)
  if Filter == nil then
    n.AUDIOCONTEXT_CONNECT(PlayerAudioContext, Destination, Source)
  else
    n.AUDIOCONTEXT_CONNECT(PlayerAudioContext, Filter, Source)
    n.AUDIOCONTEXT_CONNECT(PlayerAudioContext, Destination, Filter)
  end
end

--[[
KOTH.Mumble.AudioContextDisconnect(PlayerAudioContext, Node1, Node2)
DISCONNECTS NODES

EXAMPLES:

KOTH.Mumble.AudioContextDisconnect(PlayerAudioContext, source, destination) - Disconnects default nodes making it ready for filters to be added.
KOTH.Mumble.AudioContextDisconnect(PlayerAudioContext, destination, filter) - Disables that specific filter.
]]


KOTH.Mumble.AudioContextDisconnect = function(PlayerAudioContext, Node1, Node2)
  n.AUDIOCONTEXT_DISCONNECT(PlayerAudioContext, Node1, Node2)
end

KOTH.Mumble.CreateBiquadFilter = function(PlayerAudioContext, Settings)
  local bfn = n.AUDIOCONTEXT_CREATE_BIQUADFILTERNODE(PlayerAudioContext, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
  if Settings.Type ~= nil then
    n.BIQUADFILTERNODE_SET_TYPE(bfn, Settings.Type)
  end
  if Settings.Freq ~= nil then
    n.BIQUADFILTERNODE_FREQUENCY(bfn, Settings.Freq)
  end
  if Settings.Q ~= nil then
    n.BIQUADFILTERNODE_Q(bfn, Settings.Q)
  end
  if Settings.Gain ~= nil then
    n.BIQUADFILTERNODE_GAIN(bfn, Settings.Gain)
  end
  if Settings.Detune ~= nil then
    n.BIQUADFILTERNODE_DETUNE(bfn, Settings.Detune)
  end
  return bfn
end

KOTH.Mumble.DestroyBiquadFilter = function(BFN)
  n.BIQUADFILTERNODE_DESTROY(BFN)
  return nil
end

KOTH.Mumble.CreateWaveshaper = function(PlayerAudioContext, WaveAmount)
  local curve = distortionCurve(WaveAmount) -- just any function that outputs an array of numbers to describe distortion
  local wsn = n.AUDIOCONTEXT_CREATE_WAVESHAPERNODE(PlayerAudioContext, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
  n.WAVESHAPERNODE_SET_CURVE(wsn, makeObject(curve))
  return wsn
end

KOTH.Mumble.DestroyWaveshaper = function(WSN)
  n.WAVESHAPERNODE_DESTROY(WSN)
  return nil
end

KOTH.Mumble.ToggleRadioEffect = function(player, bool)
  if KOTH.Mumble.ClientData[player] == nil then
    KOTH.Mumble.ClientData[player] = {}
  end
  if bool and KOTH.Mumble.ClientData[player].WSN == nil then
    KOTH.Mumble.ClientData[player].Context = KOTH.Mumble.GetPlayerAudioContext(player) -- GETS PLAYERS AUDIO CONTEXT
    KOTH.Mumble.ClientData[player].Source, KOTH.Mumble.ClientData[player].Destination = KOTH.Mumble.GetSourceDestination(KOTH.Mumble.ClientData[player].Context) -- GETS PLAYERS SOURCE AND DESTINATION
    KOTH.Mumble.AudioContextDisconnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].Source) -- DISCONNECTS DEFAULT NODES
    KOTH.Mumble.ClientData[player].WSN = KOTH.Mumble.CreateWaveshaper(KOTH.Mumble.ClientData[player].Context, 1) -- CREATES WSN NODE
    KOTH.Mumble.ClientData[player].BFN = KOTH.Mumble.CreateBiquadFilter(KOTH.Mumble.ClientData[player].Context, {Type = "lowpass", Freq = 10000.0, Q = 0.707, Gain = 1.0}) -- CREATES BFN NODE
    KOTH.Mumble.AudioContextConnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Source, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].WSN) -- CONNECTS WSN NODE
    KOTH.Mumble.AudioContextConnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Source, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].BFN) -- CONNECTS BFN NODE
  elseif not bool and KOTH.Mumble.ClientData[player].WSN ~= nil then
    KOTH.Mumble.AudioContextDisconnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].WSN) -- REMOVES WSN NODE
    KOTH.Mumble.AudioContextDisconnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Destination, KOTH.Mumble.ClientData[player].BFN) -- REMOVES BFN NODE
    KOTH.Mumble.AudioContextConnect(KOTH.Mumble.ClientData[player].Context, KOTH.Mumble.ClientData[player].Source, KOTH.Mumble.ClientData[player].Destination) -- SETS DEFAULT NODES
    KOTH.Mumble.ClientData[player].WSN = KOTH.Mumble.DestroyWaveshaper(WSN)
    KOTH.Mumble.ClientData[player].BFN = KOTH.Mumble.DestroyBiquadFilter(BFN)
  end
end

local n = setmetatable({}, {
    __index = function(t, k)
        return function(...)
            return Citizen.InvokeNative(GetHashKey(k) & 0xFFFFFFFF, ...)
        end
    end
})

function distortionCurve(k)
  local curve = {}

    local deg = math.pi / 180

    for i = 1, 40000 do
        local x = (i - 1) * 2 / 48000 - 1;
        curve[i] = ( 3 + k ) * x * 20 * deg / ( math.pi + k * math.abs(x) );
    end
    return curve
end

function makeObject(data)
    local d = msgpack.pack(data)

    return string.pack('<T', #d) .. d
end

Citizen.CreateThread(function()
  Citizen.Wait(5000)
  for ServerID, VoiceData in pairs(KOTH.Mumble.Players) do
    Citizen.CreateThread(function()
      print(ServerID)
      local p = GetPlayerFromServerId(ServerID)
      local r = n.GET_AUDIOCONTEXT_FOR_CLIENT(p, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())

      -- original source and destination nodes
      local s = n.AUDIOCONTEXT_GET_SOURCE(r, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
      local d = n.AUDIOCONTEXT_GET_DESTINATION(r, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())

      n.AUDIOCONTEXT_DISCONNECT(r, d, s, 0, 0) -- disconnect the source from its destination so we can add a wave shaper node

      local curve = distortionCurve(1) -- just any function that outputs an array of numbers to describe distortion
      wsn = n.AUDIOCONTEXT_CREATE_WAVESHAPERNODE(r, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
      n.WAVESHAPERNODE_SET_CURVE(wsn, makeObject(curve))
      bfn = n.AUDIOCONTEXT_CREATE_BIQUADFILTERNODE(r, Citizen.ResultAsLong(), Citizen.ReturnResultAnyway())
      n.BIQUADFILTERNODE_SET_TYPE(bfn, "lowpass")
      n.BIQUADFILTERNODE_FREQUENCY(bfn, 10000.0)
      n.BIQUADFILTERNODE_Q(bfn, 0.707)
      n.BIQUADFILTERNODE_GAIN(bfn, 1.0)

      n.AUDIOCONTEXT_CONNECT(r, wsn, s, 0, 0) -- connect our new node to source
      n.AUDIOCONTEXT_CONNECT(r, d, wsn, 0, 0) -- connect the destination node to our new node
      n.AUDIOCONTEXT_CONNECT(r, bfn, s, 0, 0) -- connect our new node to source
      n.AUDIOCONTEXT_CONNECT(r, d, bfn, 0, 0) -- connect the destination node to our new node

      -- now distorted hooray!
      print("Filter set")

      Citizen.Wait(10000)
      n.AUDIOCONTEXT_DISCONNECT(r, d, bfn, 0, 0) -- disconnect the WaveShaperNode
      n.AUDIOCONTEXT_DISCONNECT(r, d, wsn, 0, 0) -- disconnect the WaveShaperNode
      n.AUDIOCONTEXT_CONNECT(r, d, s, 0, 0) -- reconnect back to the original source node
      print("Filter unset")
    end)
  end
end)
