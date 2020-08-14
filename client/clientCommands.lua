RegisterCommand("resetgender", function(source, args, rawCommand)
  SetResourceKvp("KOTH:Model", "None")
end)

RegisterCommand('money', function(source, args, rawCommand)
  KOTH.SetMoney(tonumber(args[1]))
end, false)