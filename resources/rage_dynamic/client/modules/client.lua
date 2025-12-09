-- client.lua - Menu dynamique avec persistence serveur JSON
-- Commande: /dynamicmenu  Touche: F8

local mainMenu = nil
local open = false
local items = {}
local menuName = "Menu dynamique"
local currentMenuName = "default"  -- Track which menu is being edited

-- ===== DÉFINITION DES FONCTIONS =====

-- Ajouter un bouton
local function addButton(label, desc)
  local cb = function() 
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Pressed: '..label} })
  end
  table.insert(items, { type = "button", label = label, desc = desc or "", callback = cb })
end

-- Ajouter une liste
local function addList(label, options, defaultIndex)
  local cb = function(fromList, value)
    if fromList then
      TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Liste changée: ' .. tostring(value)} })
    else
      TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Liste sélectionnée'} })
    end
  end
  table.insert(items, { type = "list", label = label, options = options or {}, index = defaultIndex or 1, callback = cb })
end

-- Ajouter un séparateur
local function addSeparator(label)
  table.insert(items, { type = "separator", label = label or "----" })
end

-- Vider les items
local function clearItems()
  items = {}
end

-- ===== KEYBOARD INPUT FUNCTIONS =====

-- Simple keyboard input helper
local function openKeyboardInput(title, initialText, maxChars)
  initialText = initialText or ""
  maxChars = maxChars or 64
  
  AddTextEntry('KEYBOARD_DYMENU', title)
  DisplayOnscreenKeyboard(1, 'KEYBOARD_DYMENU', '', initialText, '', '', '', maxChars)
  
  local input = ""
  local cancelled = false
  local done = false
  while not done do
    Citizen.Wait(0)
    local status = UpdateOnscreenKeyboard()
    if status == 1 then
      input = GetOnscreenKeyboardResult()
      done = true
    elseif status == 2 then
      cancelled = true
      done = true
    end
  end
  
  return cancelled and "" or input
end

-- Input button name and description
local function inputButtonNameDesc()
  local name = openKeyboardInput("Nom du bouton", "Bouton " .. (#items+1), 50)
  if name == "" then return nil end
  
  local desc = openKeyboardInput("Description (optionnel)", "", 100)
  
  return { name = name, desc = desc }
end

-- Input list name and options
local function inputListNameOptions()
  local name = openKeyboardInput("Nom de la liste", "Liste " .. (#items+1), 50)
  if name == "" then return nil end
  
  local optStr = openKeyboardInput("Options séparées par des virgules", "Option1,Option2,Option3", 200)
  if optStr == "" then optStr = "Option1,Option2,Option3" end
  
  -- Split by comma
  local options = {}
  for opt in string.gmatch(optStr, "([^,]+)") do
    table.insert(options, opt:match("^%s*(.-)%s*$")) -- trim
  end
  
  return { name = name, options = options }
end

-- Charger les items depuis le serveur
local function loadItems()
  TriggerServerEvent("dynamic_menu:getMenuData")
end

-- Recevoir les données du serveur
RegisterNetEvent("dynamic_menu:receiveMenuData", function(menuData)
  menuName = menuData.menuName or "Menu dynamique"
  items = {}
  for _, item in ipairs(menuData.items or {}) do
    if item.type == "button" then
      addButton(item.label, item.desc)
    elseif item.type == "list" then
      addList(item.label, item.options, item.index or 1)
    elseif item.type == "separator" then
      addSeparator(item.label)
    end
  end
  if mainMenu then
    mainMenu = RageUI.CreateMenu(menuName, "Créer/suppr éléments")
  end
  if #menuData.items > 0 then
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu chargé (' .. #menuData.items .. ' items)'} })
  end
end)

-- Créer le menu RageUI au démarrage
Citizen.CreateThread(function()
  while not RageUI do Citizen.Wait(100) end
  mainMenu = RageUI.CreateMenu(menuName, "Créer/suppr éléments")
  loadItems()
end)

-- Toggle du menu
local function toggleMenu()
  if not mainMenu then return end
  open = not open
  RageUI.Visible(mainMenu, open)
end

-- ===== COMMANDES ET KEYMAPPING =====

RegisterCommand("dynamicmenu", function() toggleMenu() end)
RegisterKeyMapping("dynamicmenu", "Open dynamic menu", "keyboard", "F8")

RegisterCommand("addbtn", function(src, args)
  local label = #args > 0 and table.concat(args, " ") or ("Button " .. (#items+1))
  addButton(label, "généré dynamiquement")
  TriggerServerEvent("dynamic_menu:addButton", label, "généré dynamiquement")
end, false)

RegisterCommand("addlist", function(src, args)
  local label = #args > 0 and table.concat(args, " ") or "Liste"
  addList(label, {"Option 1", "Option 2", "Option 3"}, 1)
  TriggerServerEvent("dynamic_menu:addList", label, {"Option 1", "Option 2", "Option 3"})
end, false)

RegisterCommand("clearitems", function()
  clearItems()
  TriggerServerEvent("dynamic_menu:clearItems")
end, false)

RegisterCommand("setmenuname", function(src, args)
  if #args > 0 then
    menuName = table.concat(args, " ")
    if mainMenu then
      mainMenu = RageUI.CreateMenu(menuName, "Créer/suppr éléments")
    end
    TriggerServerEvent("dynamic_menu:setMenuName", menuName)
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu renamed to: ' .. menuName} })
  else
    TriggerEvent('chat:addMessage', { args = {'^1Error', 'Usage: /setmenuname <nom>'} })
  end
end, false)

-- util: deep copy table (simple)
local function deepCopy(orig)
  local orig_type = type(orig)
  if orig_type ~= 'table' then return orig end
  local copy = {}
  for k, v in pairs(orig) do copy[deepCopy(k)] = deepCopy(v) end
  return copy
end

-- Create a full RageUI menu from current definition using the factory
RegisterCommand("createmenu", function(src, args)
  if not MenuFactory then
    TriggerEvent('chat:addMessage', { args = {'^1Error', 'MenuFactory not available'} })
    return
  end
  local def = {
    menuName = menuName,
    subtitle = "Generated menu",
    items = deepCopy(items)
  }
  local controller = MenuFactory.CreateMenuFromDefinition(def)
  controller:openMenu()
  -- if a name is provided, save the menu server-side under that name
  if args and args[1] and args[1] ~= "" then
    local name = args[1]
    TriggerServerEvent("dynamic_menu:saveNamedMenu", name, def)
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu créé et sauvegardé comme: ' .. name} })
  else
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu créé et ouvert via /createmenu'} })
  end
end, false)

-- List saved menus
RegisterCommand("listmenus", function()
  TriggerServerEvent("dynamic_menu:listNamedMenus")
end, false)

RegisterNetEvent("dynamic_menu:namedMenus", function(names)
  if not names or #names == 0 then
    TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Aucun menu sauvegardé'} })
    return
  end
  TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menus sauvegardés: ' .. table.concat(names, ', ')} })
end)

-- Load and open a named menu for PLAYING (not editing)
RegisterCommand("loadmenu", function(src, args)
  if not args or not args[1] then
    TriggerEvent('chat:addMessage', { args = {'^1Dynamic', 'Usage: /loadmenu <name>'} })
    return
  end
  TriggerServerEvent("dynamic_menu:getNamedMenu", args[1])
end, false)

RegisterNetEvent("dynamic_menu:receiveNamedMenu", function(name, def)
  if not MenuFactory then
    TriggerEvent('chat:addMessage', { args = {'^1Error', 'MenuFactory not available'} })
    return
  end
  local controller = MenuFactory.CreateMenuFromDefinition(def)
  controller:openMenu()
  TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu chargé et ouvert: ' .. tostring(name)} })
end)

-- Load a named menu for EDITING (load items into editor)
RegisterCommand("editmenu", function(src, args)
  if not args or not args[1] then
    TriggerEvent('chat:addMessage', { args = {'^1Dynamic', 'Usage: /editmenu <name>'} })
    return
  end
  TriggerServerEvent("dynamic_menu:getNamedMenuForEdit", args[1])
end, false)

RegisterNetEvent("dynamic_menu:receiveNamedMenuForEdit", function(name, def)
  -- Load this menu into the editor
  currentMenuName = name
  menuName = def.menuName or name
  items = {}
  for _, item in ipairs(def.items or {}) do
    if item.type == "button" then
      addButton(item.label, item.desc)
    elseif item.type == "list" then
      addList(item.label, item.options, item.index or 1)
    elseif item.type == "separator" then
      addSeparator(item.label)
    end
  end
  if mainMenu then
    mainMenu = RageUI.CreateMenu(menuName, "Édition: " .. currentMenuName)
  end
  open = true
  RageUI.Visible(mainMenu, true)
  TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Menu chargé en édition: ' .. tostring(name) .. ' (' .. #items .. ' items)'} })
end)

-- Notification when other clients add new menus
RegisterNetEvent("dynamic_menu:menuSavedBroadcast", function(name)
  TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Nouveau menu sauvegardé: ' .. tostring(name)} })
end)

-- ===== BOUCLE DE RENDU =====

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if mainMenu then
      RageUI.IsVisible(mainMenu, function()
        RageUI.Button("Renommer le menu", "Utilise /setmenuname <nom>", {}, true, {
          onSelected = function()
            TriggerEvent('chat:addMessage', { args = {'^2Dynamic', 'Utilise /setmenuname <nom>'} })
          end
        })

        RageUI.Separator("~r~Menu en édition: " .. currentMenuName)

        RageUI.Button("Ajouter un bouton", "Ajoute un nouveau bouton avec keyboard input", {}, true, {
          onSelected = function()
            local data = inputButtonNameDesc()
            if data then
              addButton(data.name, data.desc)
              TriggerServerEvent("dynamic_menu:addButton", data.name, data.desc, currentMenuName)
            end
          end
        })

        RageUI.Button("Ajouter une liste", "Ajoute une nouvelle liste avec keyboard input", {}, true, {
          onSelected = function()
            local data = inputListNameOptions()
            if data then
              addList(data.name, data.options, 1)
              TriggerServerEvent("dynamic_menu:addList", data.name, data.options, currentMenuName)
            end
          end
        })

        RageUI.Separator("=== Items dynamiques (qty: " .. (#items) .. ") ===")

        for i, it in ipairs(items) do
          if it.type == "button" then
            RageUI.Button(it.label, it.desc or "", {}, true, {
              onSelected = function()
                if it.callback then it.callback() end
              end
            })
          elseif it.type == "list" then
            RageUI.List(it.label, it.options or {"Opt1", "Opt2"}, it.index or 1, "", {}, true, {
              onListChange = function(Index)
                it.index = Index
                if it.callback then it.callback(true, Index) end
              end,
              onSelected = function(Index)
                if it.callback then it.callback(false, Index) end
              end
            })
          elseif it.type == "separator" then
            RageUI.Separator(it.label or "----")
          end
        end

        RageUI.Separator("---")
        RageUI.Button("Vider tous les items", nil, {}, true, {
          onSelected = function()
            clearItems()
            TriggerServerEvent("dynamic_menu:clearItems")
          end
        })
        RageUI.Button("Fermer", nil, {}, true, {
          onSelected = function() toggleMenu() end
        })
      end)
    end
  end
end)
