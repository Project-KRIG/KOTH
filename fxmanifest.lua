fx_version "bodacious"
games { "gta5" }

name "KOTH"
author 'Neco (Lewis)'
description 'A standalone King Of The Hill resource.'
version '0.1'

ui_page 'client/html/index.html'

shared_scripts {
  "shared/*.lua",
}

client_scripts {
	"client/*.lua",
}

server_scripts {
	"server/*.lua",
}

files {
    'client/html/index.html',
    'client/html/style.css',
    'client/html/listener.js',
}
