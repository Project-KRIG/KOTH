fx_version "bodacious"
games { "gta5" }

name "KOTH"
author "Neco (Lewis)"
description "A standalone King Of The Hill resource."
version "1.0"

dependency "baseevents"

ui_page "client/html/index.html"

shared_scripts {
  "shared/*.lua",
}

client_scripts {
  "client/*.lua",
  "client/ClientGarage.net.dll"
}

server_scripts {
	"server/*.lua",
}

server_export "SetConfValue"
server_export "GetPlayerKills"
server_export "GetPlayerDeaths"
server_export "GetPlayerKD"

files {
    "client/html/index.html",
    "client/html/style.css",
    "client/html/reset.css",
    "client/html/listener.js",
    "client/html/assets/*.png",
    "client/html/assets/*.jpg"
}
