


local exampleMenuUUID = nil

local function CloseExampleMenu()
    if exampleMenuUUID and RageMenu:IsOpen() then
        RageMenu:CloseAll()
    end
    exampleMenuUUID = nil
end

local function ToggleExampleMenu()
    if exampleMenuUUID and RageMenu:IsOpen() and RageMenu.CurrentMenu and RageMenu.CurrentMenu.uuid == exampleMenuUUID then
        CloseExampleMenu()
    else
        OpenMenu()
    end
end

function OpenMenu()
    local mainMenu = RageMenu:CreateMenu('RageUI', 'RageUI Example Menu')
    local subMenu = RageMenu:CreateMenu('Submenu', 'Submenu Subtitle')
    local themeMenu = RageMenu:CreateMenu('Themes', 'Changer le thème du menu')

    mainMenu:AddPlaceholder('<---------------Menu Principal-------------------->')
    
    -- Bouton spawn voiture
    mainMenu:AddButton('Spawn Voiture', 'Faire apparaître une voiture', ''):On('click', function(item)
        local vehicleModel = 'adder'
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        
        RequestModel(GetHashKey(vehicleModel))
        while not HasModelLoaded(GetHashKey(vehicleModel)) do
            Wait(0)
        end
        
        local vehicle = CreateVehicle(GetHashKey(vehicleModel), coords.x + 2, coords.y + 2, coords.z, heading, true, false)
        SetPedIntoVehicle(playerPed, vehicle, -1)
        SetVehicleEngineOn(vehicle, true, true, false)
        
        print('Voiture spawned: ' .. vehicleModel)
    end)
    
    -- Submenu pour les thèmes
    mainMenu:AddSubmenu(themeMenu, 'Changer Thème', 'Personnaliser les couleurs du menu')
   
    mainMenu:AddSubmenu(subMenu, 'Submenu', 'Ouvrir le sous-menu')

    -- Slider de test
    mainMenu:AddSlider('Test Slider~n~', 'This is a test slider', nil, 0, 100, 50, 1)

    -- Liste de test
    local fruits = { "Pomme 🍎", "Banane 🍌", "Cerise 🍒", "Raisin 🍇" }
    mainMenu:AddList("~p~Test List", "Sélectionne ton fruit préféré", nil, fruits, 1)

    -- Bouton avec side panel
    local sidePanelBtn = mainMenu:AddButton('📊 Stats', 'Voir les statistiques')
    sidePanelBtn:AddSidePanel('Statistiques', 'sidepanel', {
        {
            leftLabel = 'Niveau',
            rightLabel = '42',
        },
        {
            leftLabel = 'XP',
            rightLabel = '15,340',
        },
        {
            leftLabel = 'Argent',
            rightLabel = '$50,000',
        },
    })
    sidePanelBtn:On('click', function(item)
        print('Statistiques affichées')
    end)

    -- MENU DES THÈMES
    themeMenu:AddPlaceholder('<---------------Thèmes Disponibles-------------------->')
    
    themeMenu:AddButton('🟠 Orange Vif', 'Thème orange moderne'):On('click', function()
        exports['ragemenu']:ApplyTheme('Orange')
        print('~o~Thème Orange appliqué!')
    end)
    
    themeMenu:AddButton('🔵 Bleu Électrique', 'Thème bleu vibrant'):On('click', function()
        exports['ragemenu']:ApplyTheme('Blue')
        print('~b~Thème Bleu appliqué!')
    end)
    
    themeMenu:AddButton('🟣 Violet/Rose', 'Thème violet élégant'):On('click', function()
        exports['ragemenu']:ApplyTheme('Purple')
        print('~p~Thème Violet appliqué!')
    end)
    
    themeMenu:AddButton('🟢 Vert Matrix', 'Thème vert matrix'):On('click', function()
        exports['ragemenu']:ApplyTheme('Green')
        print('~g~Thème Vert appliqué!')
    end)
    
    themeMenu:AddButton('🔴 Rouge Sombre', 'Thème rouge intense'):On('click', function()
        exports['ragemenu']:ApplyTheme('Red')
        print('~r~Thème Rouge appliqué!')
    end)
    
    themeMenu:AddButton('🟡 Gold/Or', 'Thème doré luxueux'):On('click', function()
        exports['ragemenu']:ApplyTheme('Gold')
        print('~y~Thème Gold appliqué!')
    end)
    
    themeMenu:AddButton('🔷 Cyan/Turquoise', 'Thème cyan moderne'):On('click', function()
        exports['ragemenu']:ApplyTheme('Cyan')
        print('~c~Thème Cyan appliqué!')
    end)
    
    themeMenu:AddButton('💗 Rose/Pink', 'Thème rose doux'):On('click', function()
        exports['ragemenu']:ApplyTheme('Pink')
        print('~p~Thème Pink appliqué!')
    end)
    
    themeMenu:AddPlaceholder(' ')
    themeMenu:AddButton('🔄 Réinitialiser', 'Retour au thème par défaut'):On('click', function()
        exports['ragemenu']:ResetMenuColors()
        print('~s~Couleurs réinitialisées!')
    end)

    -- SUBMENU
    subMenu:AddPlaceholder('<---------------Sous-menu-------------------->')
    subMenu:AddButton('Submenu Button', 'Button Description'):On('click', function(item)
        print('Clicked Submenu Button')
    end)

    RageMenu:OpenMenu(mainMenu)
    exampleMenuUUID = mainMenu.uuid
end

-- ═══════════════════════════════════════════════════════════
--  RACCOURCI CLAVIER CONFIGURABLE
-- ═══════════════════════════════════════════════════════════



RageMenu:RegisterKey("U", "U", "Open Menu", function()
    OpenMenu()
end)



CreateThread(function()
    while true do
        Wait(500)
        if exampleMenuUUID and not RageMenu:IsOpen() then
            exampleMenuUUID = nil
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
--  COMMANDES PRATIQUES POUR TESTER LES COULEURS
-- ═══════════════════════════════════════════════════════════

-- Liste tous les thèmes disponibles
RegisterCommand('themes', function()
    print('^2═══════════════════════════════════════')
    print('^2   THÈMES RAGEMENU DISPONIBLES')
    print('^2═══════════════════════════════════════')
    print('^6Orange^0 - Thème orange vif (défaut)')
    print('^4Blue^0 - Thème bleu électrique')
    print('^5Purple^0 - Thème violet/rose')
    print('^2Green^0 - Thème vert matrix')
    print('^1Red^0 - Thème rouge sombre')
    print('^3Gold^0 - Thème doré')
    print('^4Cyan^0 - Thème cyan/turquoise')
    print('^5Pink^0 - Thème rose')
    print('^2═══════════════════════════════════════')
    print('^3Usage:^0 /menutheme [nom]')
    print('^3Exemple:^0 /menutheme Blue')
end, false)

-- ═══════════════════════════════════════════════════════════
--  EXEMPLES D'UTILISATION DES FONCTIONS RAGEMENU
-- ═══════════════════════════════════════════════════════════

-- EXEMPLE 1: Changer de thème depuis votre code
function ChangerThemeVersBleu()
    exports['ragemenu']:ApplyTheme('Blue')
end

-- EXEMPLE 2: Changer une couleur spécifique
function PersonnaliserCouleurs()
    -- Changer la couleur de navigation
    exports['ragemenu']:SetMenuColor('navigation', '#ff0000')
    
    -- Changer la couleur du header
    exports['ragemenu']:SetMenuColor('header', 'linear-gradient(135deg, #00ff00 0%, #00aa00 100%)')
    
    -- Changer l'icône check
    exports['ragemenu']:SetMenuColor('check', '#ffff00')
    
    -- Changer le slider
    exports['ragemenu']:SetMenuColor('slider', '#00ffff')
end

-- EXEMPLE 3: Menu avec changement de thème intégré
function MenuAvecThemes()
    local menu = RageMenu:CreateMenu('Paramètres', 'Personnalisation')
    local themeMenu = RageMenu:CreateMenu('Thèmes', 'Choisir un thème')
    
    menu:AddSubmenu(themeMenu, '🎨 Changer Thème', 'Personnaliser les couleurs')
    
    -- Ajouter tous les thèmes disponibles
    local themes = {
        {name = 'Orange', icon = '🟠', desc = 'Thème orange vif'},
        {name = 'Blue', icon = '🔵', desc = 'Thème bleu électrique'},
        {name = 'Purple', icon = '🟣', desc = 'Thème violet'},
        {name = 'Green', icon = '🟢', desc = 'Thème vert matrix'},
        {name = 'Red', icon = '🔴', desc = 'Thème rouge sombre'},
        {name = 'Gold', icon = '🟡', desc = 'Thème doré'},
        {name = 'Cyan', icon = '🔷', desc = 'Thème cyan'},
        {name = 'Pink', icon = '💗', desc = 'Thème rose'},
    }
    
    for _, theme in ipairs(themes) do
        themeMenu:AddButton(theme.icon .. ' ' .. theme.name, theme.desc):On('click', function()
            exports['ragemenu']:ApplyTheme(theme.name)
            print('Thème ' .. theme.name .. ' appliqué!')
        end)
    end
    
    RageMenu:OpenMenu(menu)
end

-- EXEMPLE 4: Créer un menu admin avec changement de couleurs
function MenuAdmin()
    local adminMenu = RageMenu:CreateMenu('Admin', 'Panel Administrateur')
    local colorMenu = RageMenu:CreateMenu('Couleurs', 'Personnaliser les couleurs')
    
    adminMenu:AddSubmenu(colorMenu, 'Personnaliser', 'Changer les couleurs')
    
    -- Menu de personnalisation
    local couleurs = {
        {element = 'navigation', label = 'Navigation', colors = {'#ff0000', '#00ff00', '#0000ff', '#ffff00'}},
        {element = 'header', label = 'Header', colors = {'#ff5900', '#00d4ff', '#764ba2', '#ff0000'}},
        {element = 'check', label = 'Icône Check', colors = {'#ff5900', '#00ff00', '#ffff00', '#ff1493'}},
    }
    
    for _, item in ipairs(couleurs) do
        local subMenu = RageMenu:CreateMenu(item.label, 'Choisir une couleur')
        colorMenu:AddSubmenu(subMenu, ' ' .. item.label, 'Personnaliser ' .. item.label)
        
        for _, color in ipairs(item.colors) do
            subMenu:AddButton('Couleur: ' .. color, 'Appliquer cette couleur'):On('click', function()
                exports['ragemenu']:SetMenuColor(item.element, color)
                print(item.label .. ' changé: ' .. color)
            end)
        end
    end
    
    colorMenu:AddButton('🔄 Réinitialiser', 'Retour aux couleurs par défaut'):On('click', function()
        exports['ragemenu']:ResetMenuColors()
    end)
    
    RageMenu:OpenMenu(adminMenu)
end

-- EXEMPLE 5: Sauvegarder le thème préféré du joueur
local themePreference = 'Orange' -- Thème par défaut

function SauvegarderTheme(themeName)
    themePreference = themeName
    -- Vous pouvez sauvegarder dans un fichier ou une base de données
    print('Thème sauvegardé: ' .. themeName)
end

function ChargerThemeSauvegarde()
    exports['ragemenu']:ApplyTheme(themePreference)
    print('Thème chargé: ' .. themePreference)
end

-- EXEMPLE 6: Menu de garage avec thème personnalisé
function MenuGarage()
    local garageMenu = RageMenu:CreateMenu('Garage', 'Mes Véhicules')
    
    -- Appliquer un thème spécifique pour ce menu
    exports['ragemenu']:ApplyTheme('Blue')
    
    local vehicles = {
        {name = 'Adder', model = 'adder'},
        {name = 'T20', model = 't20'},
        {name = 'Zentorno', model = 'zentorno'},
        {name = 'Turismo R', model = 'turismor'},
    }
    
    for _, veh in ipairs(vehicles) do
        garageMenu:AddButton(veh.name, 'Sortir ce véhicule'):On('click', function()
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local heading = GetEntityHeading(playerPed)
            
            RequestModel(GetHashKey(veh.model))
            while not HasModelLoaded(GetHashKey(veh.model)) do
                Wait(0)
            end
            
            local vehicle = CreateVehicle(GetHashKey(veh.model), coords.x + 2, coords.y + 2, coords.z, heading, true, false)
            SetPedIntoVehicle(playerPed, vehicle, -1)
            SetVehicleEngineOn(vehicle, true, true, false)
            
            print('Véhicule sorti: ' .. veh.name)
        end)
    end
    
    RageMenu:OpenMenu(garageMenu)
end

-- EXEMPLE 7: Commandes pour tester
RegisterCommand('testtheme', function()
    MenuAvecThemes()
end, false)

RegisterCommand('testadmin', function()
    MenuAdmin()
end, false)

RegisterCommand('testgarage', function()
    MenuGarage()
end, false)

-- EXEMPLE 8: Changer automatiquement de thème selon l'heure
CreateThread(function()
    while true do
        Wait(60000) -- Vérifier chaque minute
        
        local hour = GetClockHours()
        
        if hour >= 6 and hour < 12 then
            -- Matin: Thème clair
            exports['ragemenu']:ApplyTheme('Gold')
        elseif hour >= 12 and hour < 18 then
            -- Après-midi: Thème normal
            exports['ragemenu']:ApplyTheme('Blue')
        elseif hour >= 18 and hour < 22 then
            -- Soirée: Thème chaud
            exports['ragemenu']:ApplyTheme('Orange')
        else
            -- Nuit: Thème sombre
            exports['ragemenu']:ApplyTheme('Purple')
        end
    end
end)

-- EXEMPLE 9: Obtenir la config actuelle
function AfficherConfig()
    local config = exports['ragemenu']:GetConfig()
    print('=== Configuration RageMenu ===')
    print('Thème actif: ' .. (config.ActiveTheme or 'Custom'))
    print('Couleur navigation: ' .. config.NavigationBackgroundColor)
    print('Couleur check: ' .. config.CheckIconColor)
    print('=============================')
end

RegisterCommand('showconfig', function()
    AfficherConfig()
end, false)

-- EXEMPLE 10: Menu boutique avec thème Gold
function MenuBoutique()
    -- Appliquer le thème Gold pour la boutique
    exports['ragemenu']:ApplyTheme('Gold')
    
    local shopMenu = RageMenu:CreateMenu('💰 Boutique', 'Achats VIP')
    
    shopMenu:AddButton('Vêtements - $500', 'Acheter des vêtements'):On('click', function()
        print('Vêtements achetés!')
    end)
    
    shopMenu:AddButton('Véhicules - $50,000', 'Acheter un véhicule'):On('click', function()
        print('Véhicule acheté!')
    end)
    
    shopMenu:AddButton('Propriétés - $500,000', 'Acheter une propriété'):On('click', function()
        print('Propriété achetée!')
    end)
    
    RageMenu:OpenMenu(shopMenu)
end

RegisterCommand('shop', function()
    MenuBoutique()
end, false)

print('^2[RageMenu Examples]^0 Exemples chargés! Tapez /testtheme, /testadmin, /testgarage, ou /shop pour tester')
