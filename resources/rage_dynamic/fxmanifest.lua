fx_version 'cerulean'
games { 'gta5' }

author 'Assistant'
description 'Dynamic RageUI example - create buttons/lists at runtime with server persistence'
version '1.0.0'
lua54 'yes'

shared_scripts {
    "init.lua",
    "esx.lua",
    "@es_extended/imports.lua"

}

server_scripts {
    "server/server.lua",
    "server/hud_sync.lua",
    --"server/item_handler.lua"
}

client_scripts {
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/*.lua",
    "RageUI/timerbar/TimerBar.lua",
    "RageUI/timerbar/items/UIBasic.lua",
    "RageUI/timerbar/items/UIBarIcon.lua",
    --"client/modules/status_menu.lua",
    --"client/modules/client.lua",
    --"client/modules/menu_factory.lua",
    "client/modules/*.lua",
    --"client/modules/hud_icon.lua",
    --"client/keyboard_input.lua",
    --"client/modules/wrapper.lua",
    "examples/*.lua",
    --"nui_rage/ama.lua"
    
}

ui_page "nui_rage/new.html"

files {
    "esx.lua",
    "nui_rage/new.html",
    "nui_rage/vaj.css",
    "nui_rage/gama.js",
    --'nui/fonts/pdown.ttf',
    --'nui/fonts/bankgothic.ttf',
}
