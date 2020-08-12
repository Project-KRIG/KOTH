AddEventHandler('koth:getObject', function(cb)
	cb(KOTH)
end)

function getSharedObject()
	return KOTH
end


KOTH.VersionFile = LoadResourceFile(GetCurrentResourceName(), "version.json")
KOTH.Version = json.decode(KOTH.VersionFile).version

PerformHttpRequest("https://raw.githubusercontent.com/The-Neco/KOTH/master/version.json", function (errorCode, resultData, resultHeaders)
  print("^1==================================================================================\n^7[^5KOTH^7] Checking if ^5KOTH^7 is up to date")
  if resultData ~= nil then
    local data = json.decode(resultData)
    if KOTH.Version ~= data.version and KOTH.Version < data.version then
      print("[^5KOTH^7] ^8WARNING: ^5KOTH ^7is not up to date.\nYou are currently using ^8" .. KOTH.Version .. "^7 the latest version is ^2" .. data.version .. ".\n^7Please download the latest version from https://github.com/The-Neco/KOTH/releases")
    else
      if KOTH.Version > data.version then
        print("[^5KOTH^7] ^8WARNING: ^7You are using a pre-release version of ^5KOTH ^7there may be bugs.")
      else
        print("[^5KOTH^7] ^5KOTH ^7is up to date.")
      end
    end
  else
    print("[^5KOTH^7] ^7Failed to check if ^5KOTH ^7is up to date.")
  end
  print("^1==================================================================================^7")
end)
