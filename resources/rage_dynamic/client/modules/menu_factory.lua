-- menu_factory.lua
-- Small helper to create a RageUI menu from a definition and control it

local menu_factory = {}

-- Create a menu controller from a definition:
-- def = { menuName = "Title", subtitle = "sub", items = { {type='button', label='B', desc='d'}, {type='list', label='L', options={'A','B'}, index=1} } }
function menu_factory.CreateMenuFromDefinition(def)
  local controller = {}
  controller.definition = def
  controller.menu = RageUI.CreateMenu(def.menuName or "Menu", def.subtitle or "")
  controller.open = false

  function controller:toggle()
    self.open = not self.open
    RageUI.Visible(self.menu, self.open)
  end
  function controller:openMenu()
    self.open = true
    RageUI.Visible(self.menu, true)
  end
  function controller:close()
    self.open = false
    RageUI.Visible(self.menu, false)
  end
  function controller:isOpen()
    return self.open
  end

  -- allow replacing items
  function controller:setItems(items)
    self.definition.items = items or {}
  end

  -- start render thread for this menu controller
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if controller.menu and controller.open then
        RageUI.IsVisible(controller.menu, function()
          for i, it in ipairs(controller.definition.items or {}) do
            if it.type == "button" then
              RageUI.Button(it.label or "", it.desc or "", {}, true, {
                onSelected = function()
                  if it.callback then pcall(it.callback) end
                end
              })
            elseif it.type == "list" then
              RageUI.List(it.label or "", it.options or {}, it.index or 1, it.desc or "", {}, true, {
                onListChange = function(index)
                  it.index = index
                  if it.callback then pcall(it.callback, true, index) end
                end,
                onSelected = function(index)
                  if it.callback then pcall(it.callback, false, index) end
                end
              })
            elseif it.type == "separator" then
              RageUI.Separator(it.label or "----")
            end
          end
        end)
      end
    end
  end)

  return controller
end

-- expose as global for simple usage from other client scripts
MenuFactory = menu_factory

return menu_factory
