-- ESX-only F5 Status menu (no ox_inventory, no ox_lib)

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

RegisterNetEvent('rage_dynamic_menu:responseRemoveEsxItem', function(requestId, success)
    if pendingRequests[requestId] then
        pendingRequests[requestId].done = true
        pendingRequests[requestId].result = success and true or false
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

-- Helper: get item count (tries client ESX cache first, then server request)
local function getItemCountCached(name)
    if ESX and ESX.PlayerData and ESX.PlayerData.inventory then
        for _, item in pairs(ESX.PlayerData.inventory) do
            if item and item.name and tostring(item.name):lower() == tostring(name):lower() then
                return tonumber(item.count) or tonumber(item.amount) or tonumber(item.quantity) or 0
            end
        end
        return 0
    end
    -- fallback to server
    local res = sendServerRequest('rage_dynamic_menu:requestGetEsxItemCount', name)
    return tonumber(res) or 0
end

-- Use item (asks server to remove then applies effects on success)
local function useItem(name, config, statusKey)
    local removed = sendServerRequest('rage_dynamic_menu:requestRemoveEsxItem', name, 1)
    if removed then
        if config then
            TriggerEvent('esx_basicneeds:onUse', config.type, config.prop, config.anim, config.pos, config.rot)
        end
        -- If configured, add raw value to esx_status (server-side effect)
        if statusKey and config and config.status_raw then
            TriggerEvent('esx_status:add', statusKey, config.status_raw)
        end

        -- Apply percent-based HUD progression locally and notify HUD
        if statusKey and config and config.status_percent then
            local cur = nil
            -- try to read cachedStatus if available
            if cachedStatus and cachedStatus[statusKey] ~= nil then cur = tonumber(cachedStatus[statusKey]) or 0 end
            if not cur then cur = 0 end
            local added = tonumber(config.status_percent) or 0
            local newp = math.min(100, cur + added)
            -- notify hud to update percent immediately
            TriggerEvent('rage_dynamic_menu:updateStatusPercent', statusKey, newp)
        end
        TriggerEvent('chat:addMessage', { args = { '^3Status', 'You used '..tostring(name)..'.' } })
        -- Request updated count from server and notify HUD to refresh immediately
        local newCount = sendServerRequest('rage_dynamic_menu:requestGetEsxItemCount', name)
        if newCount ~= nil then
            TriggerEvent('rage_dynamic_menu:updateHud', name, tonumber(newCount) or 0)
        end
    else
        TriggerEvent('chat:addMessage', { args = { '^3Status', '~r~You do not have '..tostring(name)..'~s~' } })
    end
end

Citizen.CreateThread(function()
    while not RageUI do Citizen.Wait(100) end

    local statusMenu = RageUI.CreateMenu("Status", "Hunger & Thirst")
    local open = false
    local cachedBurgerCount = 0
    local cachedWaterCount = 0

    -- Ensure ESX shared object exists if available
    if not ESX then
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end

    -- Background updater
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(700)
            local b = getItemCountCached('burger')
            local w = getItemCountCached('water')
            cachedBurgerCount = tonumber(b) or 0
            cachedWaterCount = tonumber(w) or 0
        end
    end)

    -- Keybind for F5
    RegisterKeyMapping('opens', 'Open Status Menu (F6)', 'keyboard', 'F6')
    RegisterCommand('opens', function()
        open = not open
        RageUI.Visible(statusMenu, open)
    end, false)

    -- Main render loop
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if open then
                RageUI.IsVisible(statusMenu, function()
                    RageUI.Separator("~b~Item Status~s~")
                    RageUI.Separator("Burger: ~g~" .. tostring(cachedBurgerCount) .. "~s~")
                    RageUI.Separator("Water: ~g~" .. tostring(cachedWaterCount) .. "~s~")
                    RageUI.Separator("~b~Actions~s~")

                    if cachedBurgerCount > 0 then
                        RageUI.Button("Use Burger", "Consume burger to restore hunger", {}, true, {
                            onSelected = function()
                                local config = {
                                    type = "food",
                                    prop = "prop_cs_burger_01",
                                    -- percent to add to the hunger bar (0-100). Adjust per item.
                                    status_percent = 20,
                                    -- optional raw value to pass to esx_status:add if you want server-side effect
                                    status_raw = nil,
                                    anim = {dict = 'mp_player_inteat@burger', name = 'mp_player_int_eat_burger_fp', settings = {8.0, -8, -1, 49, 0, 0, 0, 0}},
                                    pos = { x = 0.15, y = 0.03, z = 0.0 },
                                    rot = { x = 15.0, y = 175.0, z = 5.0 }
                                }
                                useItem('burger', config, 'hunger')
                            end
                        })
                    else
                        RageUI.Button("Use Burger", "~r~No burger in inventory~s~", {}, false)
                    end

                    if cachedWaterCount > 0 then
                        RageUI.Button("Use Water", "Drink water to restore thirst", {}, true, {
                            onSelected = function()
                                local config = {
                                    type = "drink",
                                    prop = "prop_ld_flow_bottle",
                                    -- percent to add to the thirst bar
                                    status_percent = 15,
                                    status_raw = nil,
                                    anim = {dict = 'mp_player_intdrink', name = 'loop_bottle', settings = {1.0, -1.0, 2000, 0, 1, true, true, true}},
                                    pos = { x = 0.12, y = 0.028, z = 0.001 },
                                    rot = { x = 10.0, y = 175.0, z = 0.0 }
                                }
                                useItem('water', config, 'thirst')
                            end
                        })
                    else
                        RageUI.Button("Use Water", "~r~No water in inventory~s~", {}, false)
                    end

                    RageUI.Separator("---")
                    RageUI.Button("Close Menu", nil, {}, true, {
                        onSelected = function()
                            open = false
                            RageUI.Visible(statusMenu, false)
                        end
                    })
                end)
            end
        end
    end)
end)
