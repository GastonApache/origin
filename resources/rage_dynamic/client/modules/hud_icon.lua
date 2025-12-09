
local _timerBarPool = UITimerBarPool.New()

-- timerPool hud status burger + coca

-- Wait for RageUI to load before initializing
local function initHUDBarIconsWhenReady()
    while not UIBarIcon or not UITimerBarPool do
        Citizen.Wait(100)
    end

    -- Create bars with initial 0% (we'll update them from esx_status/esx_basicneeds)
    local Burger_hud = UIBarIcon.New("commonmenu", "burger", 0, { R = 3, G = 82, B = 253 })
    _timerBarPool:Add(Burger_hud)
    Burger_hud:SetPercentage(0)
    Burger_hud:Visible(_timerBarPool, true)

    -- use 'water' texture name for water icon (was 'cocaco' which may be invalid)
    local Coca_hud = UIBarIcon.New("commonmenu", "water", 0, { R = 3, G = 188, B = 0 })
    _timerBarPool:Add(Coca_hud)
    Coca_hud:SetPercentage(0)
    Coca_hud:Visible(_timerBarPool, true)

    -- Debug: confirm UI objects exist
    print('[rage_dynamic_menu] hud_icon.lua loaded - UIBarIcon:', tostring(UIBarIcon ~= nil), 'UITimerBarPool:', tostring(UITimerBarPool ~= nil))

    -- Make them accessible globally for update threads
    _G.Burger_hud = Burger_hud
    _G.Coca_hud = Coca_hud
end

-- Call initialization on script load
initHUDBarIconsWhenReady()

-- Local override cache for manual /sethud or immediate HUD updates
local overrideValues = { burger = 0, water = 0 }

-- Debug flag for draw loop
local debug_draw = false

-- request/response helper (ESX-only fallback via server events)
local pendingRequests = {}

local function makeRequestId()
    return tostring(GetGameTimer()) .. '-' .. tostring(math.random(100000, 999999))
end

RegisterNetEvent('rage_dynamic_menu:responseGetEsxItemCount', function(requestId, count)
    if pendingRequests[requestId] then
        pendingRequests[requestId].done = true
        pendingRequests[requestId].result = tonumber(count) or 0
    end
end)

-- Listen for explicit HUD refresh requests (from status_menu.lua after using an item)
RegisterNetEvent('rage_dynamic_menu:updateHud', function(name, count)
    if not name then return end
    overrideValues[name] = tonumber(count) or 0
end)

-- Accept percent updates for statuses (hunger/thirst)
RegisterNetEvent('rage_dynamic_menu:updateStatusPercent', function(statusKey, percent)
    if not statusKey then return end
    percent = tonumber(percent) or 0
    if not cachedStatus then cachedStatus = {} end
    if tostring(statusKey) == 'hunger' then
        cachedStatus.hunger = math.min(100, math.max(0, percent))
        -- update visual bar immediately
        if _G.Burger_hud then pcall(function() _G.Burger_hud:SetPercentage(cachedStatus.hunger) end) end
    elseif tostring(statusKey) == 'thirst' then
        cachedStatus.thirst = math.min(100, math.max(0, percent))
        if _G.Coca_hud then pcall(function() _G.Coca_hud:SetPercentage(cachedStatus.thirst) end) end
    end
end)

local function sendServerRequest(eventName, ...)
    local reqId = makeRequestId()
    pendingRequests[reqId] = { done = false, result = nil }
    TriggerServerEvent(eventName, reqId, ...)
    local timeout = 2500
    local waited = 0
    while not pendingRequests[reqId].done and waited < timeout do
        Citizen.Wait(10)
        waited = waited + 10
    end
    local res = pendingRequests[reqId].result
    pendingRequests[reqId] = nil
    return res
end

-- Helper: get item percentage (ESX.PlayerData.inventory first, then server request)
local function getStatusPercent(itemName)
    -- If user set override values via /sethud, prefer them
    if overrideValues and overrideValues[itemName] ~= nil then
        local v = tonumber(overrideValues[itemName]) or 0
        return math.min(100, math.max(0, math.floor((v / 64) * 100)))
    end
    if ESX and ESX.PlayerData and ESX.PlayerData.inventory then
        for _, item in pairs(ESX.PlayerData.inventory) do
            if item and item.name and tostring(item.name):lower() == tostring(itemName):lower() then
                return math.min(100, math.max(0, math.floor((tonumber(item.count) or tonumber(item.amount) or tonumber(item.quantity) or 0) / 64 * 100)))
            end
        end
        return 0
    end

    -- fallback to server-side query
    local val = sendServerRequest('rage_dynamic_menu:requestGetEsxItemCount', itemName)
    local percent = math.min(100, math.max(0, math.floor((tonumber(val) or 0) / 64 * 100)))
    return percent
end

-- Cached esx_status values (prefer these for HUD display)
cachedStatus = { hunger = nil, thirst = nil }

-- Thread: periodically refresh cached esx_status values using client exports or event callback
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local okH, okT = false, false

        -- Try exports['esx_status']:getStatus if present
        if exports and exports['esx_status'] then
            pcall(function()
                local sh = exports['esx_status']:getStatus('hunger')
                if sh then
                    if type(sh.getPercent) == 'function' then
                        local suc, p = pcall(sh.getPercent, sh)
                        if suc and p then cachedStatus.hunger = math.floor(tonumber(p) or 0); okH = true end
                    elseif sh.percent then
                        cachedStatus.hunger = math.floor(tonumber(sh.percent) or 0); okH = true
                    elseif sh.val then
                        cachedStatus.hunger = math.floor(tonumber(sh.val) or 0); okH = true
                    end
                end
            end)
            pcall(function()
                local st = exports['esx_status']:getStatus('thirst')
                if st then
                    if type(st.getPercent) == 'function' then
                        local suc, p = pcall(st.getPercent, st)
                        if suc and p then cachedStatus.thirst = math.floor(tonumber(p) or 0); okT = true end
                    elseif st.percent then
                        cachedStatus.thirst = math.floor(tonumber(st.percent) or 0); okT = true
                    elseif st.val then
                        cachedStatus.thirst = math.floor(tonumber(st.val) or 0); okT = true
                    end
                end
            end)
        end

        -- Fallback to event-based getter if export not available
        if not okH then
            pcall(function()
                TriggerEvent('esx_status:getStatus', 'hunger', function(s)
                    if s then
                        if type(s.getPercent) == 'function' then
                            local suc, p = pcall(s.getPercent, s)
                            if suc and p then cachedStatus.hunger = math.floor(tonumber(p) or 0) end
                        else
                            cachedStatus.hunger = math.floor(tonumber(s.percent or s.val or 0) or 0)
                        end
                    end
                end)
            end)
        end
        if not okT then
            pcall(function()
                TriggerEvent('esx_status:getStatus', 'thirst', function(s)
                    if s then
                        if type(s.getPercent) == 'function' then
                            local suc, p = pcall(s.getPercent, s)
                            if suc and p then cachedStatus.thirst = math.floor(tonumber(p) or 0) end
                        else
                            cachedStatus.thirst = math.floor(tonumber(s.percent or s.val or 0) or 0)
                        end
                    end
                end)
            end)
        end
    end
end)

-- Polling thread: update bars every second
-- Polling thread: update bars every second
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local hunger = getStatusPercent('burger') or 0
        local thirst = getStatusPercent('water') or 0

        -- protect SetPercentage calls
        if _G.Burger_hud then
            local ok1, err1 = pcall(function() _G.Burger_hud:SetPercentage(hunger) end)
            if not ok1 then print(('[rage_dynamic_menu] error setting Burger_hud percentage: %s'):format(tostring(err1))) end
        end

        if _G.Coca_hud then
            local ok2, err2 = pcall(function() _G.Coca_hud:SetPercentage(thirst) end)
            if not ok2 then print(('[rage_dynamic_menu] error setting Coca_hud percentage: %s'):format(tostring(err2))) end
        end
    end
end)

-- Periodic send to server (in case events are missed)
Citizen.CreateThread(function()
    -- (no periodic server report needed when using ESX server queries)
    while true do Citizen.Wait(0) break end
end)

-- Draw loop (existing) keeps drawing the pool
Citizen.CreateThread(function()
    local lastDebugPrint = 0
    while true do
        Citizen.Wait(1)
        -- Controlled debug print once per second when enabled
        if debug_draw then
            local now = GetGameTimer()
            if now - lastDebugPrint >= 1000 then
                lastDebugPrint = now
                local bcount = getStatusPercent('burger') or 0
                local wcount = getStatusPercent('water') or 0
                print(('[rage_dynamic_menu] Draw called - burger=%s water=%s'):format(tostring(bcount), tostring(wcount)))
            end
        end

        _timerBarPool:Draw()
    end
end)

-- Commands: /sethud to force HUD values and /togglehuddebug to enable draw debug prints
RegisterCommand('sethud', function(_src, args, raw)
    -- Usage:
    -- /sethud 50 30          -> set burger=50, water=30
    -- /sethud burger 50      -> set burger=50
    -- /sethud water 30       -> set water=30
    if not args or #args == 0 then
        TriggerEvent('chat:addMessage', { args = { '^3sethud', 'Usage: /sethud <burger|water> <value>  OR /sethud <burgerValue> <waterValue>' } })
        return
    end

    local function setValueByName(name, val)
        val = tonumber(val) or 0
        overrideValues[name] = val
        -- update HUD immediately using global refs
        local percent = math.min(100, math.max(0, math.floor((val / 64) * 100)))
        local ok, err = pcall(function()
            if name == 'burger' and _G.Burger_hud then
                _G.Burger_hud:SetPercentage(percent)
            elseif name == 'water' and _G.Coca_hud then
                _G.Coca_hud:SetPercentage(percent)
            end
        end)
        if not ok then print(('[rage_dynamic_menu] sethud error setting %s: %s'):format(name, tostring(err))) end
    end

    if #args == 1 then
        -- maybe 'burger=50' style or single number apply to burger
        local a = args[1]
        local n = tonumber(a)
        if n then
            setValueByName('burger', n)
            TriggerEvent('chat:addMessage', { args = { '^3sethud', ('burger=%d set'):format(n) } })
        else
            TriggerEvent('chat:addMessage', { args = { '^3sethud', 'Invalid argument' } })
        end
        return
    end

    if #args == 2 then
        local a1, a2 = args[1], args[2]
        local n1 = tonumber(a1)
        local n2 = tonumber(a2)
        if n1 and n2 then
            -- two numbers -> burger, water
            setValueByName('burger', n1)
            setValueByName('water', n2)
            TriggerEvent('chat:addMessage', { args = { '^3sethud', ('burger=%d water=%d set'):format(n1, n2) } })
            return
        end

        -- assume key value
        if tostring(a1):lower() == 'burger' then
            setValueByName('burger', a2)
            TriggerEvent('chat:addMessage', { args = { '^3sethud', ('burger=%s set'):format(a2) } })
            return
        elseif tostring(a1):lower() == 'water' then
            setValueByName('water', a2)
            TriggerEvent('chat:addMessage', { args = { '^3sethud', ('water=%s set'):format(a2) } })
            return
        end
    end

    -- more complex pairs
    for i = 1, #args, 2 do
        local key = args[i]
        local val = args[i+1]
        if not key or not val then break end
        if tostring(key):lower() == 'burger' or tostring(key):lower() == 'water' then
            setValueByName(tostring(key):lower(), val)
        end
    end
    TriggerEvent('chat:addMessage', { args = { '^3sethud', 'sethud applied' } })
end, false)

RegisterCommand('togglehuddebug', function(_src, args, raw)
    debug_draw = not debug_draw
    TriggerEvent('chat:addMessage', { args = { '^3togglehuddebug', ('debug_draw=%s'):format(tostring(debug_draw)) } })
end, false)