-- ══════════════════════════════════════════════════════════════
--  EXEMPLE LISTCOLOR - Test des palettes de couleurs
-- ══════════════════════════════════════════════════════════════

local menuListColorOuvert = false
local menuListColorUUID = nil

-- Helper pour lire la sélection d'une liste
local function getListSelection(item, fallback)
    if item and item.other and type(item.other.current) == 'number' then
        return item.other.current + 1
    end
    return fallback or 1
end

-- Fonction pour convertir hex en RGB
local function hexToRGB(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1,2), 16)
    local g = tonumber(hex:sub(3,4), 16)
    local b = tonumber(hex:sub(5,6), 16)
    return r, g, b
end

function CreerMenuListColor()
    local menu = RageMenu:CreateMenu('Test ListColor', 'Palettes de couleurs GTA', 'top-left')
    menuListColorUUID = menu.uuid
    
    -- ══════════════════════════════════════════════════════════════
    --  SECTION 1 : Couleurs de Véhicule
    -- ══════════════════════════════════════════════════════════════
    
    menu:AddPlaceholder('═══ VÉHICULE ═══')
    
    local vehicleColorIndex = 1
    menu:AddListColor('Couleur Primaire', 'Toutes les couleurs GTA V', nil, RageMenu.GTAColors.Vehicle, vehicleColorIndex):On('change', function(updatedItem)
        vehicleColorIndex = getListSelection(updatedItem, vehicleColorIndex)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if vehicle ~= 0 then
            local colorData = RageMenu.GTAColors.Vehicle[vehicleColorIndex]
            if colorData then
                local r, g, b = hexToRGB(colorData.color)
                SetVehicleCustomPrimaryColour(vehicle, r, g, b)
                print('🎨 Couleur primaire: ' .. colorData.name)
            end
        else
            print('⚠️ Vous devez être dans un véhicule!')
        end
    end)
    
    local vehicleColorSecIndex = 1
    menu:AddListColor('Couleur Secondaire', 'Couleur secondaire du véhicule', nil, RageMenu.GTAColors.Vehicle, vehicleColorSecIndex):On('change', function(updatedItem)
        vehicleColorSecIndex = getListSelection(updatedItem, vehicleColorSecIndex)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if vehicle ~= 0 then
            local colorData = RageMenu.GTAColors.Vehicle[vehicleColorSecIndex]
            if colorData then
                local r, g, b = hexToRGB(colorData.color)
                SetVehicleCustomSecondaryColour(vehicle, r, g, b)
                print('🎨 Couleur secondaire: ' .. colorData.name)
            end
        else
            print('⚠️ Vous devez être dans un véhicule!')
        end
    end)
    
    -- ══════════════════════════════════════════════════════════════
    --  SECTION 2 : Néons
    -- ══════════════════════════════════════════════════════════════
    
    menu:AddPlaceholder('═══ NÉON ═══')
    
    local neonColorIndex = 1
    menu:AddListColor('Couleur Néon', 'Couleurs lumineuses pour néon', nil, RageMenu.GTAColors.Neon, neonColorIndex):On('change', function(updatedItem)
        neonColorIndex = getListSelection(updatedItem, neonColorIndex)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        
        if vehicle ~= 0 then
            local colorData = RageMenu.GTAColors.Neon[neonColorIndex]
            if colorData then
                local r, g, b = hexToRGB(colorData.color)
                SetVehicleNeonLightsColour(vehicle, r, g, b)
                print('💡 Néon: ' .. colorData.name)
            end
        else
            print('⚠️ Vous devez être dans un véhicule!')
        end
    end)
    
    local neonEnabled = false
    menu:AddCheckbox('Activer Néon', 'Allumer/éteindre les néons', nil, neonEnabled):On('change', function(updatedItem)
        if updatedItem and updatedItem.other then
            neonEnabled = updatedItem.other.checked or false
        end
        
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            SetVehicleNeonLightEnabled(vehicle, 0, neonEnabled) -- Gauche
            SetVehicleNeonLightEnabled(vehicle, 1, neonEnabled) -- Droite
            SetVehicleNeonLightEnabled(vehicle, 2, neonEnabled) -- Avant
            SetVehicleNeonLightEnabled(vehicle, 3, neonEnabled) -- Arrière
            print('💡 Néon: ' .. (neonEnabled and 'Activé' or 'Désactivé'))
        end
    end)
    
    -- ══════════════════════════════════════════════════════════════
    --  SECTION 3 : Palettes de test
    -- ══════════════════════════════════════════════════════════════
    
    menu:AddPlaceholder('═══ PALETTES ═══')
    
    local rainbowIndex = 1
    menu:AddListColor('Arc-en-ciel', 'Palette rainbow', nil, RageMenu.GTAColors.Rainbow, rainbowIndex):On('change', function(updatedItem)
        rainbowIndex = getListSelection(updatedItem, rainbowIndex)
        local colorData = RageMenu.GTAColors.Rainbow[rainbowIndex]
        if colorData then
            print('🌈 ' .. colorData.name .. ' : ' .. colorData.color)
        end
    end)
    
    local basicIndex = 1
    menu:AddListColor('Couleurs Basiques', 'Palette simplifiée', nil, RageMenu.GTAColors.Basic, basicIndex):On('change', function(updatedItem)
        basicIndex = getListSelection(updatedItem, basicIndex)
        local colorData = RageMenu.GTAColors.Basic[basicIndex]
        if colorData then
            print('🎨 ' .. colorData.name .. ' : ' .. colorData.color)
        end
    end)
    
    local crewIndex = 1
    menu:AddListColor('Couleurs Crew', 'Couleurs personnalisables', nil, RageMenu.GTAColors.Crew, crewIndex):On('change', function(updatedItem)
        crewIndex = getListSelection(updatedItem, crewIndex)
        local colorData = RageMenu.GTAColors.Crew[crewIndex]
        if colorData then
            print('👥 ' .. colorData.name .. ' : ' .. colorData.color)
        end
    end)
    
    -- ══════════════════════════════════════════════════════════════
    --  SECTION 4 : Actions
    -- ══════════════════════════════════════════════════════════════
    
    menu:AddPlaceholder('═══ ACTIONS ═══')
    
    menu:AddButton('Réinitialiser Véhicule', 'Remettre les couleurs par défaut'):On('click', function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            ClearVehicleCustomPrimaryColour(vehicle)
            ClearVehicleCustomSecondaryColour(vehicle)
            SetVehicleNeonLightEnabled(vehicle, 0, false)
            SetVehicleNeonLightEnabled(vehicle, 1, false)
            SetVehicleNeonLightEnabled(vehicle, 2, false)
            SetVehicleNeonLightEnabled(vehicle, 3, false)
            print('✓ Couleurs réinitialisées!')
        end
    end)
    
    menu:AddButton('Info Véhicule', 'Afficher les couleurs actuelles'):On('click', function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            local r1, g1, b1 = GetVehicleCustomPrimaryColour(vehicle)
            local r2, g2, b2 = GetVehicleCustomSecondaryColour(vehicle)
            
            print('══════════════════════════════════════')
            print('📊 Couleurs du véhicule:')
            print('  Primaire: RGB(' .. (r1 or 'défaut') .. ', ' .. (g1 or 'défaut') .. ', ' .. (b1 or 'défaut') .. ')')
            print('  Secondaire: RGB(' .. (r2 or 'défaut') .. ', ' .. (g2 or 'défaut') .. ', ' .. (b2 or 'défaut') .. ')')
            print('══════════════════════════════════════')
        else
            print('⚠️ Vous devez être dans un véhicule!')
        end
    end)
    
    return menu
end

function ToggleMenuListColor()
    if menuListColorOuvert then
        local currentMenu = RageMenu.CurrentMenu
        if currentMenu and currentMenu.uuid == menuListColorUUID then
            RageMenu:Close(currentMenu)
        end
    else
        local menu = RageMenu:GetMenuByUUID(menuListColorUUID)
        if not menu then
            menu = CreerMenuListColor()
        end
        RageMenu:OpenMenu(menu)
    end
    
    menuListColorOuvert = not menuListColorOuvert
end

RageMenu:RegisterKey("F9", "F9", "Open Menu", function()
    ToggleMenuListColor()
end)


-- Thread pour maintenir le menu ouvert (optionnel)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if menuListColorOuvert then
            -- Le menu gère déjà les inputs via NUI
        else
            Citizen.Wait(500)
        end
    end
end)

print('^2[ListColor] Exemple chargé! Appuyez sur F8 ou tapez /listcolor^0')
