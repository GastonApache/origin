fx_version 'adamant'

author 'Ente Nico | Nopes'
version '1.0.0'
game 'gta5'
lua54 'yes'

files {
  'web/dist/**/*',
  'ragemenu.lua',
}

ui_page 'web/dist/index.html'

client_scripts {
  'config.lua',
  'utils/keys.lua',
  'utils/nui.lua',
  'ragemenu.lua',
  'gta_colors.lua',
  --'examples.lua', -- Décommentez pour activer le menu de base
}
