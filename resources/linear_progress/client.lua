-- client.lua : FiveM client helper to control the linear progress NUI
-- Lit LinearProgressConfig (défini par config.lua) et l'envoie au NUI
-- Fournit StartProgressDuration/StopProgressDuration pour animer la progression sur une durée

local visible = false
local current = 10
local autoRunning = false
local durationRunning = false
local autoThread = nil
local durationThread = nil

-- safe default if LinearProgressConfig not set
local function getConfigOrDefault()
  local c = LinearProgressConfig or {}
  local function toPx(v)
    if not v then return nil end
    if type(v) == 'number' then return tostring(v) .. 'px' end
    return v
  end
  return {
    barColor = c.barColor or '#1976d2',
    bgColor = c.bgColor or 'rgba(200,200,200,0.4)',
    textColor = c.textColor or '#222',
    right = toPx(c.right) or '40px',
    top = toPx(c.top) or '40px',
    left = c.left and toPx(c.left) or nil,
    bottom = c.bottom and toPx(c.bottom) or nil,
    width = toPx(c.width) or '300px',
    height = toPx(c.height) or '18px',
    borderRadius = c.borderRadius or '10px',
    showPercent = (c.showPercent == nil) and true or c.showPercent,
    percentSpacing = toPx(c.percentSpacing) or '8px',
    zIndex = tonumber(c.zIndex) or 5000,
    fontFile = c.fontFile,
    fontFamily = c.fontFamily or 'sans-serif',
    fontWeight = c.fontWeight or '500',
    fontSizeScale = tonumber(c.fontSizeScale) or 0.9,
    autoStartOnResource = c.autoStartOnResource or false
  }
end

local function sendUI(display)
  visible = display
  SendNUIMessage({ type = 'ui', display = display })
end

local function sendProgress(val)
  current = math.max(0, math.min(100, math.floor(val)))
  SendNUIMessage({ type = 'progress', value = current })
end

local function StartAuto()
  if autoRunning then return end
  autoRunning = true
  autoThread = CreateThread(function()
    while autoRunning do
      Wait(800)
      current = (current >= 100) and 10 or (current + 10)
      sendProgress(current)
    end
  end)
end

local function StopAuto()
  if not autoRunning then return end
  autoRunning = false
  autoThread = nil
end

-- Duration-based progress: animate from start (default 0) to 100 over durationSeconds.
-- If hideOnComplete == true then hide the UI when finished.
local function StartProgressDuration(durationSeconds, hideOnComplete)
  if durationRunning then return end
  durationRunning = true
  durationThread = CreateThread(function()
    local duration = tonumber(durationSeconds) or 1
    if duration <= 0 then duration = 1 end
    local startTime = GetGameTimer()
    local endTime = startTime + (duration * 1000)
    sendProgress(0)
    sendUI(true)
    while durationRunning do
      local now = GetGameTimer()
      local t = (now - startTime) / (duration * 1000)
      if t >= 1.0 then
        sendProgress(100)
        break
      else
        sendProgress(math.floor(t * 100))
      end
      Wait(50)
    end
    durationRunning = false
    durationThread = nil
    if hideOnComplete then
      sendUI(false)
    end
  end)
end

local function StopProgressDuration()
  if not durationRunning then return end
  durationRunning = false
  durationThread = nil
end

-- Exports
exports('SetProgress', function(val)
  sendProgress(val)
end)

exports('Show', function()
  sendUI(true)
end)

exports('Hide', function()
  sendUI(false)
end)

exports('StartAuto', function()
  sendUI(true)
  StartAuto()
end)

exports('StopAuto', function()
  StopAuto()
end)

exports('StartProgressDuration', function(durationSeconds, hideOnComplete)
  StartProgressDuration(durationSeconds, hideOnComplete)
end)

exports('StopProgressDuration', function()
  StopProgressDuration()
end)

-- Command for quick testing
RegisterCommand('lprogress', function(source, args, raw)
  local cmd = args[1]
  if not cmd then
    print("Usage: /lprogress start|stop|set <0-100>|show|hide|duration <seconds> [hide]")
    return
  end
  if cmd == 'start' then
    sendUI(true)
    StartAuto()
  elseif cmd == 'stop' then
    StopAuto()
    sendUI(false)
  elseif cmd == 'set' then
    local v = tonumber(args[2]) or 0
    sendProgress(v)
    sendUI(true)
  elseif cmd == 'show' then
    sendUI(true)
  elseif cmd == 'hide' then
    sendUI(false)
  elseif cmd == 'duration' then
    local s = tonumber(args[2]) or 5
    local hide = args[3] == 'hide'
    StartProgressDuration(s, hide)
  else
    print("Usage: /lprogress start|stop|set <0-100>|show|hide|duration <seconds> [hide]")
  end
end, false)

-- Envoyer la config NUI au démarrage
CreateThread(function()
  Wait(500)
  local cfg = getConfigOrDefault()
  SendNUIMessage({
    type = 'config',
    config = cfg
  })
  SendNUIMessage({ type = 'progress', value = current })

  if cfg.autoStartOnResource then
    sendUI(true)
    StartAuto()
  end
end)