-- examples/menu_structure.lua
-- Template showing how to structure a RageUI menu definition

-- Menu definition example
local exampleMenu = {
  menuName = "My Example Menu",
  subtitle = "Template",
  items = {
    { type = "button", label = "Say Hello", desc = "Simple button", callback = function() print('Hello from menu') end },
    { type = "list", label = "Choose One", options = {"One", "Two", "Three"}, index = 1, callback = function(fromList, index)
        if fromList then
          print('List changed to', index)
        else
          print('List selected', index)
        end
      end
    },
    { type = "separator", label = "--- Section ---" }
  }
}

-- Use MenuFactory to create and open
if MenuFactory then
  local menu = MenuFactory.CreateMenuFromDefinition(exampleMenu)
  -- open the menu when you want
  -- menu:openMenu()
else
  print("MenuFactory not present. Include 'menu_factory.lua' before using this template.")
end
