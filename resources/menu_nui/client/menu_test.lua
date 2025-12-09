-- ═══════════════════════════════════════════════════════════
--  MENU DE BASE - RAGEMENU
--  Exemple simple d'utilisation du RageMenu
-- ═══════════════════════════════════════════════════════════

local menuOuvert = false
local menuPrincipal = nil

-- Fonction pour créer le menu
function CreerMenuBase()
    -- Créer le menu principal
    menuPrincipal = RageMenu:CreateMenu('Menu Principal', 'Bienvenue sur RageMenu', 'top-left')
    
    -- Créer des sous-menus
    local menuJoueur = RageMenu:CreateMenu('Joueur', 'Informations et actions', 'top-left')
    local menuVehicule = RageMenu:CreateMenu('Vehicule', 'Gestion des véhicules', 'top-left')
    local menuAdmin = RageMenu:CreateMenu('Admin', 'Outils administrateurs', 'top-left')
    local menuThemes = RageMenu:CreateMenu('Themes', 'Changer l apparence', 'top-left')
    
    print('^3[DEBUG] Menus créés:^0')
    print('  menuPrincipal UUID: ' .. (menuPrincipal.uuid or 'nil'))
    print('  menuJoueur UUID: ' .. (menuJoueur.uuid or 'nil'))
    print('  menuVehicule UUID: ' .. (menuVehicule.uuid or 'nil'))
    print('  menuAdmin UUID: ' .. (menuAdmin.uuid or 'nil'))
    print('  menuThemes UUID: ' .. (menuThemes.uuid or 'nil'))
    
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
    menuJoueur:AddCheckbox('Mode God', 'Activer/désactiver invincibilité', godMode):On('change', function(_, checked)
        godMode = checked
        SetEntityInvincible(PlayerPedId(), godMode)
        print('Mode God: ' .. (godMode and 'Activé' or 'Désactivé'))
    end)
    
    local invisible = false
    menuJoueur:AddCheckbox('Invisible', 'Devenir invisible', invisible):On('change', function(_, checked)
        invisible = checked
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
    
    local maxSpeed = 50
    menuVehicule:AddSlider('Vitesse Max', 'Modifier la vitesse maximale', maxSpeed, 50, 300, 10, nil):On('change', function(_, value)
        maxSpeed = value
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 then
            SetVehicleMaxSpeed(vehicle, value / 3.6)
            print('Vitesse max: ' .. value .. ' km/h')
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
    menuAdmin:AddList('Météo', 'Changer la météo', nil, meteoOptions, meteoIndex):On('change', function(_, index)
        meteoIndex = index
        SetWeatherTypeNowPersist(meteoOptions[index])
        print('Météo: ' .. meteoOptions[index])
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
    --  MENU THÈMES
    -- ═══════════════════════════════════════════════════════════
    
    local themes = {
        {name = 'Default', icon = '💎', desc = 'Thème bleu/violet par défaut'},
        {name = 'Orange', icon = '🟠', desc = 'Thème orange vif'},
        {name = 'Blue', icon = '🔵', desc = 'Thème bleu électrique'},
        {name = 'Purple', icon = '🟣', desc = 'Thème violet/rose'},
        {name = 'Green', icon = '🟢', desc = 'Thème vert matrix'},
        {name = 'Red', icon = '🔴', desc = 'Thème rouge sombre'},
        {name = 'Gold', icon = '🟡', desc = 'Thème doré'},
        {name = 'Cyan', icon = '🔷', desc = 'Thème cyan/turquoise'},
        {name = 'Pink', icon = '💗', desc = 'Thème rose'},
    }
    
    for _, theme in ipairs(themes) do
        menuThemes:AddButton(theme.icon .. ' ' .. theme.name, theme.desc):On('click', function()
            exports['ragemenu']:ApplyTheme(theme.name)
            print('✓ Thème ' .. theme.name .. ' appliqué!')
        end)
    end
    
    menuThemes:AddPlaceholder('─────────────')
    
    menuThemes:AddButton('🔄 Réinitialiser', 'Revenir au thème par défaut'):On('click', function()
        exports['ragemenu']:ResetMenuColors()
        print('✓ Thème réinitialisé!')
    end)
    
    -- ═══════════════════════════════════════════════════════════
    --  MENU PRINCIPAL (construit à la fin)
    -- ═══════════════════════════════════════════════════════════
    
    menuPrincipal:AddSubmenu(menuJoueur, 'Joueur', 'Options du joueur')
    menuPrincipal:AddSubmenu(menuVehicule, 'Vehicule', 'Gestion des véhicules')
    menuPrincipal:AddSubmenu(menuAdmin, 'Admin', 'Outils administrateurs')
    menuPrincipal:AddSubmenu(menuThemes, 'Themes', 'Personnaliser le menu')
    
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
CreateThread(function()
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
end)

-- ═══════════════════════════════════════════════════════════
--  COMMANDES
-- ═══════════════════════════════════════════════════════════

-- Commande pour ouvrir le menu
RegisterCommand('menu', function()
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
