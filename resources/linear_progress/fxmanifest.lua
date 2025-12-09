fx_version 'cerulean'
game 'gta5'

author 'GastonApache'
description 'Linear progress NUI (client side)'

ui_page 'html/index.html'

files {
  'html/index.html',
  'html/style.css',
  'html/script.js',
  'html/fonts/*' -- place custom .ttf/.woff files here (optional)
}

client_script 'config.lua'
client_script 'client.lua'

exports {
  'SetProgress',
  'Show',
  'Hide',
  'StartAuto',
  'StopAuto',
  'StartProgressDuration',
  'StopProgressDuration'
}