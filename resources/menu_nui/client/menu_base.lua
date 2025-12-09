local menuOuvert = false
local menuPrincipal = nil

-- Helpers to safely read RageMenu change payloads
local function getCheckboxState(item, fallback)
    if item and item.other and type(item.other.checked) == 'boolean' then
        return item.other.checked
    end
    return fallback or false
end

local function getSliderValue(item, fallback)
    if item and item.other and type(item.other.value) == 'number' then
        return item.other.value
    end
    return fallback or 0
end

local function getListSelection(item, fallback)
    if item and item.other and type(item.other.current) == 'number' then
        return item.other.current + 1
    end
    return fallback or 1
end

-- Fonction pour créer le menu
function CreerMenuBase()
    -- Créer le menu principal
    menuPrincipal = RageMenu:CreateMenu('Menu Principal', 'Bienvenue sur RageMenu', 'top-right')
    
    -- Créer des sous-menus
    local menuJoueur = RageMenu:CreateMenu('Joueur', 'Informations et actions', 'top-right')
    local menuVehicule = RageMenu:CreateMenu('Vehicule', 'Gestion des véhicules', 'top-right')
    local menuAdmin = RageMenu:CreateMenu('Admin', 'Outils administrateurs', 'top-right')
    
    print('^3[DEBUG] Menus créés:^0')
    print('  menuPrincipal UUID: ' .. (menuPrincipal.uuid or 'nil'))
    print('  menuJoueur UUID: ' .. (menuJoueur.uuid or 'nil'))
    print('  menuVehicule UUID: ' .. (menuVehicule.uuid or 'nil'))
    print('  menuAdmin UUID: ' .. (menuAdmin.uuid or 'nil'))
    
    -- ═══════════════════════════════════════════════════════════
    --  MENU JOUEUR
    -- ═══════════════════════════════════════════════════════════
    
    menuJoueur:AddButton('Mes Informations', 'Afficher mes informations'):On('click', function()
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        local health = GetEntityHealth(playerPed)
        
        print('═══════════════════════════════════════')
        print('ID Serveur: ' .. GetPlayerServerId(PlayerId()))
        print('Position: X=' .. math.floor(coords.x) .. ' Y=' .. math.floor(coords.y) .. ' Z=' .. math.floor(coords.z))
        print('Direction: ' .. math.floor(heading) .. '°')
        print('Santé: ' .. health)
        print('═══════════════════════════════════════')
    end)
    
    local godMode = false
    menuJoueur:AddCheckbox('Mode God', 'Activer/désactiver invincibilité', nil, godMode):On('change', function(updatedItem)
        godMode = getCheckboxState(updatedItem, godMode)
        SetEntityInvincible(PlayerPedId(), godMode)
        print('Mode God: ' .. (godMode and 'Activé' or 'Désactivé'))
    end)
    
    local invisible = false
    menuJoueur:AddCheckbox('Invisible', 'Devenir invisible', nil, invisible):On('change', function(updatedItem)
        invisible = getCheckboxState(updatedItem, invisible)
        SetEntityVisible(PlayerPedId(), not invisible, false)
        print('Invisible: ' .. (invisible and 'Activé' or 'Désactivé'))
    end)
    
    menuJoueur:AddPlaceholder('─────────────')
    
    menuJoueur:AddButton('Soigner', 'Restaurer toute la santé'):On('click', function()
        SetEntityHealth(PlayerPedId(), 200)
        print('Santé restaurée!')
    end)
    
    menuJoueur:AddButton('Redonner Stamina', 'Restaurer l\'endurance'):On('click', function()
        RestorePlayerStamina(PlayerId(), 100.0)
        print('Stamina restaurée!')
    end)
    
    menuJoueur:AddPlaceholder('─────────────')
    
    -- Liste des coiffures (Hair Styles)
    local hairstyles = {
        "Chauve",
        "Court 1",
        "Court 2", 
        "Court 3",
        "Mi-long 1",
        "Mi-long 2",
        "Long 1",
        "Long 2",
        "Afro",
        "Tresses",
        "Queue de cheval",
        "Chignon",
        "Dreadlocks",
        "Mohawk",
        "Rasé côtés",
    }
    local hairstyleIndex = 1
    menuJoueur:AddList('Coiffure', 'Changer de coiffure', nil, hairstyles, hairstyleIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, hairstyleIndex)
        hairstyleIndex = selection
        
        local ped = PlayerPedId()
        local isMale = IsPedMale(ped)
        
        -- SetPedComponentVariation(ped, componentId, drawableId, textureId, paletteId)
        -- componentId 2 = Hair
        -- drawableId = style (0 = chauve, 1+ = différentes coiffures)
        local hairStyle = selection - 1 -- Convertir en index 0
        SetPedComponentVariation(ped, 2, hairStyle, 0, 0)
        
        print('💇 Coiffure: ' .. hairstyles[selection] .. ' (ID: ' .. hairStyle .. ')')
    end)
    
    -- Initialiser les variables pour les couleurs de cheveux
    local hairColorIndex = 1      -- Couleur principale
    local hairHighlightIndex = 1  -- Couleur secondaire (reflets)
    
    -- Liste des couleurs de cheveux (principale)
    menuJoueur:AddListColor('Couleur Cheveux', 'Changer la couleur principale des cheveux', nil, RageMenu.GTAColors.Hair, hairColorIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, hairColorIndex)
        hairColorIndex = selection
        
        local ped = PlayerPedId()
        -- Native: SetPedHairColor(ped, colorID, highlightColorID)
        -- colorID = couleur principale, highlightColorID = couleur secondaire/reflets
        local mainColorID = selection - 1
        local highlightID = hairHighlightIndex - 1
        SetPedHairColor(ped, mainColorID, highlightID)
        
        local colorData = RageMenu.GTAColors.Hair[selection]
        if colorData then
            print('💇 Couleur principale: ' .. colorData.name .. ' | ID1=' .. mainColorID .. ' ID2=' .. highlightID)
        end
    end)
    
    -- Liste des couleurs de cheveux (secondaire/reflets)
    menuJoueur:AddListColor('Reflets Cheveux', 'Changer la couleur des reflets (secondaire)', nil, RageMenu.GTAColors.Hair, hairHighlightIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, hairHighlightIndex)
        hairHighlightIndex = selection
        
        local ped = PlayerPedId()
        -- Native: SetPedHairColor(ped, colorID, highlightColorID)
        -- colorID = couleur principale, highlightColorID = couleur secondaire/reflets
        local mainColorID = hairColorIndex - 1
        local highlightID = selection - 1
        SetPedHairColor(ped, mainColorID, highlightID)
        
        local colorData = RageMenu.GTAColors.Hair[selection]
        if colorData then
            print('✨ Reflets: ' .. colorData.name .. ' | ID1=' .. mainColorID .. ' ID2=' .. highlightID)
        end
    end)
    
    -- Liste des couleurs de maquillage
    local makeupColorIndex = 1
    menuJoueur:AddListColor('Couleur Maquillage', 'Changer la couleur du maquillage', nil, RageMenu.GTAColors.Makeup, makeupColorIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, makeupColorIndex)
        makeupColorIndex = selection
        
        local ped = PlayerPedId()
        -- Native: SetPedHeadOverlayColor(ped, overlayID, colorType, colorID, secondColorID)
        -- overlayID 4 = Makeup, colorType 1 = Makeup colors, colorID = 0-63
        SetPedHeadOverlayColor(ped, 4, 1, selection - 1, selection - 1)
        
        local colorData = RageMenu.GTAColors.Makeup[selection]
        if colorData then
            print('💄 Couleur maquillage: ' .. colorData.name)
        end
    end)
    
    -- ═══════════════════════════════════════════════════════════
    --  MENU VEHICULE
    -- ═══════════════════════════════════════════════════════════
    
    menuVehicule:AddButton('Spawn Véhicule', 'Faire apparaître un véhicule'):On('click', function()
        local vehicleModel = 'adder'
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        
        RequestModel(vehicleModel)
        while not HasModelLoaded(vehicleModel) do
            Wait(10)
        end
        
        local vehicle = CreateVehicle(vehicleModel, coords.x + 3, coords.y, coords.z, heading, true, false)
        SetPedIntoVehicle(playerPed, vehicle, -1)
        SetModelAsNoLongerNeeded(vehicleModel)
        
        print('Véhicule spawné: ' .. vehicleModel)
    end)
    
    menuVehicule:AddButton('Réparer Véhicule', 'Réparer le véhicule actuel'):On('click', function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            print('Véhicule réparé!')
        else
            print('Vous devez être dans un véhicule!')
        end
    end)
    
    menuVehicule:AddButton('Remplir Essence', 'Remettre le plein'):On('click', function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            SetVehicleFuelLevel(vehicle, 100.0)
            print('Réservoir rempli!')
        else
            print('Vous devez être dans un véhicule!')
        end
    end)
    
    menuVehicule:AddPlaceholder('─────────────')
    
    -- Liste des couleurs avec cercles colorés
    local couleurIndex = 1
    menuVehicule:AddListColor('Couleur Véhicule', 'Changer la couleur principale', nil, RageMenu.GTAColors.Vehicle, couleurIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, couleurIndex)
        couleurIndex = selection
        
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            -- Convertir la couleur hex en RGB
            local colorData = RageMenu.GTAColors.Vehicle[selection]
            if colorData then
                -- Extraire RGB du format #RRGGBB
                local hex = colorData.color:gsub("#", "")
                local r = tonumber(hex:sub(1,2), 16)
                local g = tonumber(hex:sub(3,4), 16)
                local b = tonumber(hex:sub(5,6), 16)
                
                -- Appliquer la couleur personnalisée au véhicule
                SetVehicleCustomPrimaryColour(vehicle, r, g, b)
                print('Couleur appliquée: ' .. colorData.name .. ' (RGB: ' .. r .. ', ' .. g .. ', ' .. b .. ')')
            end
        else
            print('Vous devez être dans un véhicule!')
        end
    end)
    
    menuVehicule:AddPlaceholder('─────────────')
    
    local maxSpeed = 50
    menuVehicule:AddSlider('Vitesse Max', 'Modifier la vitesse maximale', nil, 50, 300, maxSpeed, 10):On('change', function(updatedItem)
        maxSpeed = getSliderValue(updatedItem, maxSpeed)
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            SetVehicleMaxSpeed(vehicle, maxSpeed / 3.6)
            print('Vitesse max: ' .. maxSpeed .. ' km/h')
        end
    end)
    
    menuVehicule:AddPlaceholder('─────────────')
    
    menuVehicule:AddButton('Supprimer Véhicule', 'Supprimer le véhicule actuel'):On('click', function()
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            DeleteVehicle(vehicle)
            print('Véhicule supprimé!')
        else
            print('Vous devez être dans un véhicule!')
        end
    end)
    
    -- ═══════════════════════════════════════════════════════════
    --  MENU ADMIN
    -- ═══════════════════════════════════════════════════════════
    
    menuAdmin:AddButton('Changer Heure', 'Définir l\'heure'):On('click', function()
        local heure = 12
        NetworkOverrideClockTime(heure, 0, 0)
        print('Heure changée: ' .. heure .. ':00')
    end)
    
    local meteoOptions = {'CLEAR', 'EXTRASUNNY', 'CLOUDS', 'OVERCAST', 'RAIN', 'THUNDER', 'CLEARING', 'NEUTRAL', 'SNOW', 'BLIZZARD', 'SNOWLIGHT', 'XMAS'}
    local meteoIndex = 1
    menuAdmin:AddList('Météo', 'Changer la météo', nil, meteoOptions, meteoIndex):On('change', function(updatedItem)
        local selection = getListSelection(updatedItem, meteoIndex)
        local weather = meteoOptions[selection] or meteoOptions[1]

        meteoIndex = selection
        SetWeatherTypeNowPersist(weather)
        print('Météo: ' .. weather)
    end)
    
    menuAdmin:AddPlaceholder('─────────────')
    
    menuAdmin:AddButton('Téléportation Waypoint', 'Se téléporter au marqueur'):On('click', function()
        local waypoint = GetFirstBlipInfoId(8)
        if DoesBlipExist(waypoint) then
            local coords = GetBlipCoords(waypoint)
            local groundZ = 0
            local found = false
            
            for height = 0, 1000, 50 do
                RequestCollisionAtCoord(coords.x, coords.y, height)
                Wait(10)
                found, groundZ = GetGroundZFor_3dCoord(coords.x, coords.y, height, false)
                if found then
                    break
                end
            end
            
            SetEntityCoords(PlayerPedId(), coords.x, coords.y, groundZ + 1.0, false, false, false, true)
            print('Téléporté au waypoint!')
        else
            print('Aucun marqueur sur la carte!')
        end
    end)
    
    -- ═══════════════════════════════════════════════════════════
    --  MENU PRINCIPAL (construit à la fin)
    -- ═══════════════════════════════════════════════════════════
    
    menuPrincipal:AddSubmenu(menuJoueur, 'Joueur', 'Options du joueur')
    menuPrincipal:AddSubmenu(menuVehicule, 'Vehicule', 'Gestion des véhicules')
    menuPrincipal:AddSubmenu(menuAdmin, 'Admin', 'Outils administrateurs')
    
    menuPrincipal:AddPlaceholder('─────────────')
    
    menuPrincipal:AddButton('Fermer', 'Fermer le menu'):On('click', function()
        RageMenu:CloseAll()
    end)
    
    print('^2[DEBUG] Sous-menus ajoutés au menu principal^0')
end

-- ═══════════════════════════════════════════════════════════
--  GESTION DE L'OUVERTURE/FERMETURE
-- ═══════════════════════════════════════════════════════════

-- Créer le menu au démarrage
CreateThread(function()
    Wait(1000)
    CreerMenuBase()
    print('^2[RageMenu]^0 Menu de base chargé! Appuyez sur ^3U^0 pour ouvrir')
end)

-- Touche pour ouvrir le menu (U par défaut)
--[[CreateThread(function()
    while true do
        Wait(0)
        
        if IsControlJustPressed(0, 303) then -- U
            if menuOuvert then
                RageMenu:CloseAll()
                menuOuvert = false
            else
                RageMenu:OpenMenu(menuPrincipal)
                menuOuvert = true
            end
        end
        
        -- Fermer avec Backspace
        if IsControlJustPressed(0, 177) and menuOuvert then -- Backspace
            RageMenu:CloseAll()
            menuOuvert = false
        end
    end
end)]]

-- ═══════════════════════════════════════════════════════════
--  COMMANDES
-- ═══════════════════════════════════════════════════════════

-- Commande pour ouvrir le menu
RegisterCommand('menu', function()
    if not menuPrincipal then
        print('^1[Erreur]^0 Le menu n\'est pas encore chargé. Attendez quelques secondes.')
        return
    end
    
    if menuOuvert then
        RageMenu:CloseAll()
        menuOuvert = false
    else
        RageMenu:OpenMenu(menuPrincipal)
        menuOuvert = true
    end
end, false)

-- Commande pour changer de thème rapidement
RegisterCommand('theme', function(source, args)
    if args[1] then
        exports['ragemenu']:ApplyTheme(args[1])
        print('^2✓ Thème ' .. args[1] .. ' appliqué!')
    else
        print('^3Thèmes disponibles:^0 Default, Orange, Blue, Purple, Green, Red, Gold, Cyan, Pink')
        print('^3Usage:^0 /theme [nom]')
    end
end, false)

print('^2═══════════════════════════════════════^0')
print('^2  RageMenu - Menu de Base Chargé^0')
print('^2═══════════════════════════════════════^0')
print('^3Touche:^0 U ou ^3/menu^0')
print('^3Commande:^0 /theme [nom]')
print('^2═══════════════════════════════════════^0')
