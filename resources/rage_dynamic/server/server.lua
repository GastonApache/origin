-- server.lua - Gestion de la persistence en JSON côté serveur
local dataFile = "resources/rage_dynamic_menu/data/menu_data.json"

-- Structure server-side: store multiple named menus
local store = {
  menus = {}
}

local function ensureDataDir()
  local dir = "resources/rage_dynamic_menu/data"
  os.execute("mkdir \"" .. dir .. "\" 2>nul")
end

local function saveMenuData()
  ensureDataDir()
  local file = io.open(dataFile, "w")
  if file then
    file:write(json.encode(store))
    file:close()
    print("^2[Dynamic Menu]^7 Données sauvegardées en JSON")
    return true
  else
    print("^1[Dynamic Menu ERROR]^7 Impossible d'écrire le fichier JSON")
    return false
  end
end

local function loadMenuData()
  local file = io.open(dataFile, "r")
  if file then
    local content = file:read("*a")
    file:close()
    if content and content ~= "" then
      local ok, parsed = pcall(function() return json.decode(content) end)
      if ok and type(parsed) == "table" and parsed.menus then
        store = parsed
        print("^2[Dynamic Menu]^7 Données chargées depuis JSON")
      else
        -- backward compatibility: previous single menu format
        if parsed and parsed.items then
          store = { menus = { default = { menuName = parsed.menuName or "Menu dynamique", items = parsed.items } } }
          saveMenuData()
        else
          print("^3[Dynamic Menu]^7 JSON invalide, initialisation par défaut")
        end
      end
    end
  else
    print("^3[Dynamic Menu]^7 Fichier JSON non trouvé, création avec données par défaut")
    store = { menus = { default = { menuName = "Menu dynamique", items = {} } } }
    saveMenuData()
  end
end

-- Helper: return list of menu names
local function listMenuNames()
  local names = {}
  for k,_ in pairs(store.menus or {}) do table.insert(names, k) end
  return names
end

-- Event: save a named menu definition
RegisterNetEvent("dynamic_menu:saveNamedMenu", function(name, menuDef)
  local src = source
  if not name or name == "" then
    TriggerClientEvent("chat:addMessage", src, { args = {'^1Dynamic', 'Nom de menu invalide'} })
    return
  end
  store.menus = store.menus or {}
  store.menus[name] = menuDef or { menuName = name, items = {} }
  saveMenuData()
  TriggerClientEvent("dynamic_menu:menuSaved", src, name, store.menus[name])
  -- broadcast to all clients that a new menu exists
  TriggerClientEvent("dynamic_menu:menuSavedBroadcast", -1, name)
  print("^2[Dynamic Menu]^7 Menu enregistré: " .. name)
end)

-- Event: request list of named menus
RegisterNetEvent("dynamic_menu:listNamedMenus", function()
  local src = source
  TriggerClientEvent("dynamic_menu:namedMenus", src, listMenuNames())
end)

-- Event: get a named menu (for display/play)
RegisterNetEvent("dynamic_menu:getNamedMenu", function(name)
  local src = source
  if store.menus and store.menus[name] then
    TriggerClientEvent("dynamic_menu:receiveNamedMenu", src, name, store.menus[name])
  else
    TriggerClientEvent("chat:addMessage", src, { args = {'^1Dynamic', 'Menu introuvable: '..tostring(name)} })
  end
end)

-- Event: get a named menu for editing (load into editor)
RegisterNetEvent("dynamic_menu:getNamedMenuForEdit", function(name)
  local src = source
  if store.menus and store.menus[name] then
    TriggerClientEvent("dynamic_menu:receiveNamedMenuForEdit", src, name, store.menus[name])
  else
    TriggerClientEvent("chat:addMessage", src, { args = {'^1Dynamic', 'Menu introuvable: '..tostring(name)} })
  end
end)

-- Backwards compatibility for old events: add to a specific menu (or default)
RegisterNetEvent("dynamic_menu:addButton", function(label, desc, menuName)
  local src = source
  menuName = menuName or "default"
  store.menus = store.menus or {}
  store.menus[menuName] = store.menus[menuName] or { menuName = menuName, items = {} }
  table.insert(store.menus[menuName].items, { type = "button", label = label, desc = desc or "" })
  saveMenuData()
  TriggerClientEvent("chat:addMessage", src, { args = {'^2Dynamic', 'Bouton sauvegardé: ' .. label} })
end)

RegisterNetEvent("dynamic_menu:addList", function(label, options, menuName)
  local src = source
  menuName = menuName or "default"
  store.menus = store.menus or {}
  store.menus[menuName] = store.menus[menuName] or { menuName = menuName, items = {} }
  table.insert(store.menus[menuName].items, { type = "list", label = label, options = options or {"Option 1","Option 2"}, index = 1 })
  saveMenuData()
  TriggerClientEvent("chat:addMessage", src, { args = {'^2Dynamic', 'Liste sauvegardée: ' .. label} })
end)

RegisterNetEvent("dynamic_menu:clearItems", function()
  local src = source
  store.menus = store.menus or {}
  store.menus.default = store.menus.default or { menuName = "Menu dynamique", items = {} }
  store.menus.default.items = {}
  saveMenuData()
  TriggerClientEvent("chat:addMessage", src, { args = {'^2Dynamic', 'Tous les items supprimés'} })
end)

-- Legacy: get default menu
RegisterNetEvent("dynamic_menu:getMenuData", function()
  local src = source
  local data = store.menus and store.menus.default or { menuName = "Menu dynamique", items = {} }
  TriggerClientEvent("dynamic_menu:receiveMenuData", src, data)
end)

-- Load at start
loadMenuData()

print("^2[Dynamic Menu]^7 Server script loaded. Saved menus: " .. tostring(#listMenuNames()))
