KOTH.SendChatMessage = function(source, message)
  TriggerClientEvent("chat:addMessage", source, {
      args = {
          "[^5KOTH^7]",
          message
      },
      color = { 255, 255, 255 }
  })
end

RegisterCommand("help", function(source, args, rawCommand)
  KOTH.SendChatMessage(source, "/shop <- Opens the shop while in spawn.")
  KOTH.SendChatMessage(source, "/kill <- Kills self.")
  KOTH.SendChatMessage(source, "/bugreport <- Coppies the link to the bug report to your clipboard.")
end)

RegisterCommand("bugreport", function(source, args, rawCommand)
  TriggerClientEvent("chat:addMessage", source, "[^5KOTH^7]: Bugreport link coppied to your clipboard, paste")
  TriggerClientEvent("chat:addMessage", source, "[^5KOTH^7]: this into your browser and fill out the fields.")
end)

RegisterCommand("kill", function(source, args, rawCommand)
  SetEntityHealth(GetPlayerPed(source), 0.0)
end)
