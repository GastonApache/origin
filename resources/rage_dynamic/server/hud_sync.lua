-- Simple server-side receiver for HUD item counts
-- Stores last reported counts per player and allows admin inspection

local playerCounts = {}

RegisterNetEvent('rage_dynamic_menu:reportItemCount', function(counts)
    if not counts then return end
    playerCounts[source] = counts
    print(('[rage_dynamic_menu] received item counts from %s: %s'):format(source, json.encode(counts)))
end)

RegisterCommand('ragemenu_counts', function(source, args, raw)
    if source == 0 then
        print('=== rage_dynamic_menu stored counts ===')
        for pid, counts in pairs(playerCounts) do
            print(('player %s -> %s'):format(pid, json.encode(counts)))
        end
    else
        -- allow players to request their own stored counts
        local counts = playerCounts[source] or { burger = 0, water = 0 }
        TriggerClientEvent('chat:addMessage', source, { args = { '^2rage_dynamic_menu', 'Stored counts: ' .. json.encode(counts) } })
    end
end, false)
