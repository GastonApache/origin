-- ESX-only server item handlers for `rage_dynamic_menu`
-- Provides event-based request/response for item counts and removal

-- Helper to safely get xPlayer and inventory item count
local function getPlayerItemCount(src, itemName)
    if not ESX then return 0 end
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return 0 end

    -- preferred API: xPlayer.getInventoryItem
    if xPlayer.getInventoryItem then
        local ok, item = pcall(function() return xPlayer.getInventoryItem(itemName) end)
        if ok and item and (item.count or item.quantity or item.amount) then
            return tonumber(item.count or item.quantity or item.amount) or 0
        end
    end

    -- fallback: common inventory tables
    local inv = xPlayer.getInventory and xPlayer.getInventory() or xPlayer.inventory
    if inv and type(inv) == 'table' then
        for _, it in pairs(inv) do
            if it and it.name and tostring(it.name):lower() == tostring(itemName):lower() then
                return tonumber(it.count or it.amount or it.quantity) or 0
            end
        end
    end

    return 0
end

-- Helper to safely remove item from player inventory
local function removePlayerItem(src, itemName, amount)
    if not ESX then return false end
    local xPlayer = ESX.GetPlayerFromId(src)
    if not xPlayer then return false end

    amount = tonumber(amount) or 1

    -- preferred API
    if xPlayer.removeInventoryItem then
        local ok, err = pcall(function() xPlayer.removeInventoryItem(itemName, amount) end)
        if ok then return true end
    end

    -- fallback modification of in-memory table (best-effort)
    local inv = xPlayer.getInventory and xPlayer.getInventory() or xPlayer.inventory
    if inv and type(inv) == 'table' then
        for _, it in pairs(inv) do
            if it and it.name and tostring(it.name):lower() == tostring(itemName):lower() then
                local cur = tonumber(it.count or it.amount or it.quantity) or 0
                if cur >= amount then
                    it.count = cur - amount
                    return true
                end
                break
            end
        end
    end

    return false
end

-- Request: client sends a requestId and itemName; server responds with the same requestId and the count
RegisterNetEvent('rage_dynamic_menu:requestGetEsxItemCount', function(requestId, itemName)
    local src = source
    local count = 0
    count = getPlayerItemCount(src, itemName)
    TriggerClientEvent('rage_dynamic_menu:responseGetEsxItemCount', src, requestId, count)
end)

-- Backwards-compatible simple event-based request (no requestId) used by older clients
-- Client: TriggerServerEvent('rage_dynamic_menu:getItemCountRequest', itemName)
-- Server: responds with TriggerClientEvent('rage_dynamic_menu:itemCountResponse', src, itemName, count)
RegisterNetEvent('rage_dynamic_menu:getItemCountRequest', function(itemName)
    local src = source
    local count = getPlayerItemCount(src, itemName)
    TriggerClientEvent('rage_dynamic_menu:itemCountResponse', src, itemName, count)
end)

-- Request removal: client sends requestId, itemName, amount; server attempts removal and responds with success boolean
RegisterNetEvent('rage_dynamic_menu:requestRemoveEsxItem', function(requestId, itemName, amount)
    local src = source
    local success = false
    success = removePlayerItem(src, itemName, amount)
    TriggerClientEvent('rage_dynamic_menu:responseRemoveEsxItem', src, requestId, success)
end)

-- Optional: provide a server RPC to get esx_status percent if some servers don't expose it client-side
RegisterNetEvent('rage_dynamic_menu:requestGetEsxStatus', function(requestId, statusName)
    local src = source
    local percent = 0
    if ESX and statusName then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            -- esx_status typical server API: use exports if available
            if exports and exports['esx_status'] and exports['esx_status'].GetStatus then
                pcall(function()
                    local s = exports['esx_status'].GetStatus(src, statusName)
                    if s and s.percent then
                        percent = tonumber(s.percent) or 0
                    elseif s and s.val then
                        percent = tonumber(s.val) or 0
                    end
                end)
            end
        end
    end
    TriggerClientEvent('rage_dynamic_menu:responseGetEsxStatus', src, requestId, percent)
end)

-- Log resource start
print('^2[rage_dynamic_menu] item_handler loaded (ESX-only handlers)^0')
-- Server-side handler for retrieving item counts from ox_inventory

if GetResourceState('ox_inventory') == 'started' then
    if lib and lib.callback and lib.callback.register then
        lib.callback.register('rage_dynamic_menu:getItemCount', function(source, itemName)
            local result = exports.ox_inventory:GetItemCount(source, itemName)
            return result or 0
        end)
    else
        print('^3[rage_dynamic_menu] Notice: ox_inventory present but lib (ox_lib) is missing; callback not registered.^0')
    end
else
    print('^1[rage_dynamic_menu] Warning: ox_inventory not started, item count callback will not work^0')
end

-- Alternative: register a simple event-based system
RegisterNetEvent('rage_dynamic_menu:getItemCountRequest', function(itemName)
    local count = 0
    if GetResourceState('ox_inventory') == 'started' then
        pcall(function()
            count = exports.ox_inventory:GetItemCount(source, itemName) or 0
        end)
    end
    TriggerClientEvent('rage_dynamic_menu:itemCountResponse', source, itemName, count)
end)

-- Server-side ESX-only item handlers (event-based request/response)

-- Request: client sends a requestId and itemName; server responds with the same requestId and the count
RegisterNetEvent('rage_dynamic_menu:requestGetEsxItemCount', function(requestId, itemName)
    local src = source
    local count = 0
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            local inv = xPlayer.getInventory and xPlayer.getInventory() or xPlayer.inventory
            if inv then
                for _, item in pairs(inv) do
                    if item and item.name and tostring(item.name):lower() == tostring(itemName):lower() then
                        count = tonumber(item.count) or tonumber(item.amount) or tonumber(item.quantity) or 0
                        break
                    end
                end
            end
        end
    end
    TriggerClientEvent('rage_dynamic_menu:responseGetEsxItemCount', src, requestId, count)
end)

-- Request removal: client sends requestId, itemName, amount; server attempts removal and responds with success boolean
RegisterNetEvent('rage_dynamic_menu:requestRemoveEsxItem', function(requestId, itemName, amount)
    local src = source
    local success = false
    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            amount = tonumber(amount) or 1
            if xPlayer.removeInventoryItem then
                pcall(function() xPlayer.removeInventoryItem(itemName, amount) end)
                success = true
            else
                local inv = xPlayer.getInventory and xPlayer.getInventory() or xPlayer.inventory
                if inv then
                    for _, item in pairs(inv) do
                        if item and item.name and tostring(item.name):lower() == tostring(itemName):lower() then
                            local cur = tonumber(item.count) or tonumber(item.amount) or tonumber(item.quantity) or 0
                            if cur >= amount then
                                item.count = cur - amount
                                success = true
                            end
                            break
                        end
                    end
                end
            end
        end
    end
    TriggerClientEvent('rage_dynamic_menu:responseRemoveEsxItem', src, requestId, success)
end)

-- If ESX not present at start, log a notice; server still runs but handlers will return default 0/false
if not ESX then
    print('^3[rage_dynamic_menu] Notice: ESX (es_extended) not detected at resource start; item requests will return 0/false until ESX is available.^0')
end
    
