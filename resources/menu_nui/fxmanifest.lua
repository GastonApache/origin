fx_version 'adamant'

author 'Ente Nico'
version '1.0.0'
game 'gta5'
lua54 'yes'

-- Dépendances
dependency 'ragemenu'

client_scripts {
  '@ragemenu/ragemenu.lua',
  '@ragemenu/gta_colors.lua',
  'client/example.lua',
  'client/menu_base.lua',
  'client/example_listcolor.lua', -- Décommentez pour tester ListColor (F8)
}
