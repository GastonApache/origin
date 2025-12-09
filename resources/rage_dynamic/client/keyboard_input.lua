-- keyboard_input.lua - Simple keyboard input helper for FiveM
-- Usage: local result = openKeyboardInput("Title", "initialText", maxChars)

local function openKeyboardInput(title, initialText, maxChars)
  initialText = initialText or ""
  maxChars = maxChars or 64
  
  -- Register the text entry key
  AddTextEntry('KEYBOARD_INPUT_TITLE', title)
  
  -- Display the keyboard
  DisplayOnscreenKeyboard(1, 'KEYBOARD_INPUT_TITLE', '', initialText, '', '', '', maxChars)
  
  -- Wait for input
  local input = ""
  local cancelled = false
  local done = false
  while not done do
    Citizen.Wait(0)
    local status = UpdateOnscreenKeyboard()
    if status == 1 then
      -- Confirmed
      input = GetOnscreenKeyboardResult()
      done = true
    elseif status == 2 then
      -- Cancelled
      cancelled = true
      done = true
    end
  end
  
  return cancelled and "" or input
end

return { openKeyboardInput = openKeyboardInput }
