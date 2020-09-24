Citizen.CreateThread(function()
  while not KOTH.Ready do
    Citizen.Wait(500)
  end
  KOTH.CreateAuthKey()
end)

KOTH.CreateAuthKey = function()
  local random = math.random
  local template ='xxxxxxxx-xxxx-KOTH-xxxx-xxxxxxxxxxxx'
  KOTH.EventAuthKey = string.gsub(template, '[xy]', function (c)
      local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
      return string.format('%x', v)
  end)
  KOTH.DebugPrint("KOTH EventAuthKey has been set to: " .. KOTH.EventAuthKey)
end

KOTH.CreateEvent = function(eventName, eventRoutine)
  RegisterNetEvent(eventName)
  AddEventHandler(eventName, function(params) if not params then params = {} end params.source = source if params.AuthKey == KOTH.EventAuthKey then eventRoutine(params) else KOTH.DiscordLog(GetPlayerName(params.source), eventName, "Kicked.", "N/A") DropPlayer(source, "Stop cheating you fuck.") end end)
end

KOTH.CreateEvent("KOTH:KickCheater", function(params)
  KOTH.DiscordLog(GetPlayerName(params.source), params.event, "Kicked.", "N/A")
  DropPlayer(params.source, "Stop cheating you fuck.")
end)

KOTH.TriggerClientEvent = function(eventName, source, params)
  if not params then
    params = {}
  end
  params.AuthKey = KOTH.EventAuthKey
  TriggerClientEvent(eventName, source, params)
end

KOTH.TriggerEvent = function(eventName, params)
  if not params then
    params = {}
  end
  params.AuthKey = KOTH.EventAuthKey
  TriggerEvent(eventName, params)
end

KOTH.DiscordLog = function(name, event, action, extra)
  local now_date_time = os.date("!%Y%m%dT%H%M%S")
  local message = [[{
    "embeds": [
      {
        "title": "KOTH Anti-Cheat Report",
        "url": "",
        "color": 2926079,
        "timestamp": "]]..now_date_time..[[",
        "thumbnail": {
          "url": "https://cdn.discordapp.com/icons/742466843566145567/e80ffe580f1a4982bd69e07c3f919d9b.png?size=128"
        },
        "author": {
          "name": "KOTH AC",
          "url": "",
          "icon_url": "https://cdn.discordapp.com/icons/742466843566145567/e80ffe580f1a4982bd69e07c3f919d9b.png?size=128"
        },
        "fields": [
          {
          "name": "Name",
          "value": "]] .. name .. [["
          },
          {
          "name": "EVENT",
          "value": "]] .. event .. [["
          },
          {
          "name": "ACTION TAKEN",
          "value": "]] .. action .. [["
          },
          {
          "name": "Extra Info",
          "value": "]] .. extra .. [["
          }
        ]
      }
    ]
  }]]
  if KOTH.DiscordWebhook ~= "" then
    PerformHttpRequest(KOTH.DiscordWebhook, function(Error, Content, Head) end, 'POST', message, { ['Content-Type'] = 'application/json' })
  end
end
