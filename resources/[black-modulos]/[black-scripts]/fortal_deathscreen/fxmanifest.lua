

fx_version "bodacious"
game "gta5"

files {
  "client-side/nui/**",
}

ui_page "client-side/nui/index.html"

shared_scripts {
  "@vrp/lib/utils.lua",
  "shared/module.lua"
}

client_scripts {
  "lib/utils.lua",
  "client-side/shared_client.lua",
  "client-side/client.lua"
}

server_scripts {
  "lib/utils.lua",
  "server-side/*.lua"
}