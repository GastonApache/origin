-- ============================================
-- EXEMPLE COMPLET RAGEUI V2 - TOUTES FONCTIONS
-- ============================================

local MenuPrincipal = RageUI.CreateMenu("Menu Principal", "Exemple complet RageUI")
local SousMenuJoueur = RageUI.CreateSubMenu(MenuPrincipal, "Joueur", "Gestion du joueur")
local SousMenuVehicule = RageUI.CreateSubMenu(MenuPrincipal, "Véhicule", "Gestion du véhicule")
local SousMenuArmes = RageUI.CreateSubMenu(MenuPrincipal, "Armurerie", "Gestion des armes")
local SousMenuAdmin = RageUI.CreateSubMenu(MenuPrincipal, "Admin", "Menu administrateur")

-- Variables d'exemple
local CheckboxGodmode = false
local CheckboxInvisible = false
local CheckboxNoclip = false
local SliderVitesse = 1
local IndexVehicule = 1
local IndexArme = 1
local IndexMeteo = 1
local SliderHeure = 12
local InputNomJoueur = ""

-- Listes d'exemples
local VehiculesListe = {
    {name = "Adder", model = "adder"},
    {name = "Zentorno", model = "zentorno"},
    {name = "T20", model = "t20"},
    {name = "Turismo R", model = "turismor"},
    {name = "Nero", model = "nero"}
}

local ArmesListe = {
    {name = "Pistolet", hash = "WEAPON_PISTOL"},
    {name = "Fusil d'assaut", hash = "WEAPON_ASSAULTRIFLE"},
    {name = "Pompe", hash = "WEAPON_PUMPSHOTGUN"},
    {name = "Sniper", hash = "WEAPON_SNIPERRIFLE"},
    {name = "RPG", hash = "WEAPON_RPG"}
}

local MeteoListe = {"Clair", "Nuageux", "Pluie", "Brouillard", "Neige", "Orage"}

-- Fonction d'ouverture du menu
function OuvrirMenu()
    if not RageUI.Visible(MenuPrincipal) and not RageUI.Visible(SousMenuJoueur) and 
       not RageUI.Visible(SousMenuVehicule) and not RageUI.Visible(SousMenuArmes) and
       not RageUI.Visible(SousMenuAdmin) then
        
        RageUI.Visible(MenuPrincipal, true)
        
        -- Boucle principale du menu
        CreateThread(function()
            while RageUI.Visible(MenuPrincipal) or RageUI.Visible(SousMenuJoueur) or 
                  RageUI.Visible(SousMenuVehicule) or RageUI.Visible(SousMenuArmes) or
                  RageUI.Visible(SousMenuAdmin) do
                Wait(0)
                
                -- ===== MENU PRINCIPAL =====
                RageUI.IsVisible(MenuPrincipal, function()
                    
                    -- Séparateur avec description
                    RageUI.Separator("~b~Menu d'exemple RageUI V2")
                    
                    -- Bouton simple avec description et flèche
                    RageUI.Button("Bouton Simple", "Ceci est un bouton basique", {RightLabel = "→"}, true, {
                        onSelected = function()
                            print("Bouton simple cliqué")
                            RageUI.Popup({message = "Vous avez cliqué sur le bouton !"})
                        end
                    })
                    
                    -- Bouton vers sous-menu Joueur
                    RageUI.Button("Gestion Joueur", "Accédez aux options du joueur", {RightLabel = "→"}, true, {}, SousMenuJoueur)
                    
                    -- Bouton vers sous-menu Véhicule
                    RageUI.Button("Gestion Véhicule", "Accédez aux options de véhicule", {RightLabel = "→"}, true, {}, SousMenuVehicule)
                    
                    -- Bouton vers sous-menu Armes
                    RageUI.Button("Armurerie", "Gérez vos armes", {RightLabel = "→"}, true, {}, SousMenuArmes)
                    
                    RageUI.Separator("~r~Administration")
                    
                    -- Bouton vers sous-menu Admin
                    RageUI.Button("Menu Admin", "Options administrateur", {RightLabel = "→", RightBadge = RageUI.BadgeStyle.Lock}, true, {}, SousMenuAdmin)
                    
                    RageUI.Separator("~o~Informations")
                    
                    -- Ligne d'information non cliquable
                    RageUI.Line()
                    RageUI.Button("Serveur: ~g~MonServeur RP", nil, {}, false, {})
                    RageUI.Button("Joueurs: ~b~64/64", nil, {}, false, {})
                    
                end)
                
                -- ===== SOUS-MENU JOUEUR =====
                RageUI.IsVisible(SousMenuJoueur, function()
                    
                    RageUI.Separator("~y~Statistiques")
                    
                    -- Affichage d'informations joueur
                    local playerPed = PlayerPedId()
                    local health = GetEntityHealth(playerPed)
                    local armor = GetPedArmour(playerPed)
                    
                    RageUI.Button("Santé", nil, {RightLabel = health .. "/200"}, false, {})
                    RageUI.Button("Armure", nil, {RightLabel = armor .. "/100"}, false, {})
                    
                    RageUI.Separator("~g~Actions Santé")
                    
                    -- Bouton soigner
                    RageUI.Button("Se Soigner", "Restaure votre santé complète", {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetEntityHealth(playerPed, 200)
                            RageUI.Popup({message = "Vous avez été soigné !"})
                        end
                    })
                    
                    -- Bouton armure
                    RageUI.Button("Armure Complète", "Donne une armure complète", {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetPedArmour(playerPed, 100)
                            RageUI.Popup({message = "Armure ajoutée !"})
                        end
                    })
                    
                    RageUI.Separator("~b~Actions Diverses")
                    
                    -- Slider exemple
                    RageUI.List("Changer de Skin", {"Michael", "Franklin", "Trevor", "Custom"}, IndexVehicule, nil, {}, true, {
                        onListChange = function(Index)
                            IndexVehicule = Index
                        end,
                        onSelected = function(Index)
                            print("Skin sélectionné: " .. Index)
                        end
                    })
                    
                    -- Bouton téléportation
                    RageUI.Button("Se Téléporter", "TP vers un point d'intérêt", {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetEntityCoords(playerPed, -269.4, -955.3, 31.2)
                            RageUI.Popup({message = "Téléportation effectuée !"})
                        end
                    })
                    
                    -- Checkbox godmode
                    RageUI.Checkbox("Mode Invincible", nil, CheckboxGodmode, {}, {
                        onChecked = function()
                            CheckboxGodmode = true
                            SetEntityInvincible(playerPed, true)
                            print("Godmode activé")
                        end,
                        onUnChecked = function()
                            CheckboxGodmode = false
                            SetEntityInvincible(playerPed, false)
                            print("Godmode désactivé")
                        end
                    })
                    
                    -- Checkbox invisibilité
                    RageUI.Checkbox("Invisibilité", nil, CheckboxInvisible, {}, {
                        onChecked = function()
                            CheckboxInvisible = true
                            SetEntityVisible(playerPed, false, false)
                        end,
                        onUnChecked = function()
                            CheckboxInvisible = false
                            SetEntityVisible(playerPed, true, false)
                        end
                    })
                    
                end)
                
                -- ===== SOUS-MENU VÉHICULE =====
                RageUI.IsVisible(SousMenuVehicule, function()
                    
                    RageUI.Separator("~p~Spawn Véhicule")
                    
                    -- Liste de véhicules
                    RageUI.List("Choisir Véhicule", 
                        {"Adder", "Zentorno", "T20", "Turismo R", "Nero"},
                        IndexVehicule, 
                        "Sélectionnez un véhicule",
                        {},
                        true,
                        {
                            onListChange = function(Index)
                                IndexVehicule = Index
                            end,
                            onSelected = function(Index)
                                local playerPed = PlayerPedId()
                                local coords = GetEntityCoords(playerPed)
                                local heading = GetEntityHeading(playerPed)
                                
                                -- Spawn du véhicule
                                RequestModel(VehiculesListe[Index].model)
                                while not HasModelLoaded(VehiculesListe[Index].model) do
                                    Wait(0)
                                end
                                
                                local vehicle = CreateVehicle(VehiculesListe[Index].model, coords.x + 2, coords.y, coords.z, heading, true, false)
                                SetPedIntoVehicle(playerPed, vehicle, -1)
                                
                                RageUI.Popup({message = "Véhicule spawné: " .. VehiculesListe[Index].name})
                            end
                        }
                    )
                    
                    RageUI.Separator("~o~Modifications")
                    
                    -- Bouton réparer
                    RageUI.Button("Réparer Véhicule", "Répare le véhicule actuel", {RightLabel = "→"}, IsPedInAnyVehicle(PlayerPedId(), false), {
                        onSelected = function()
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            SetVehicleFixed(vehicle)
                            SetVehicleDeformationFixed(vehicle)
                            RageUI.Popup({message = "Véhicule réparé !"})
                        end
                    })
                    
                    -- Slider vitesse max
                    RageUI.List("Vitesse Max", {"x1", "x2", "x3", "x5", "x10"}, SliderVitesse, "Modifier la vitesse maximale", {}, 
                        IsPedInAnyVehicle(PlayerPedId(), false), {
                        onListChange = function(Index)
                            SliderVitesse = Index
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            if vehicle ~= 0 then
                                SetVehicleEnginePowerMultiplier(vehicle, Index * 10.0)
                            end
                        end
                    })
                    
                    -- Checkbox tuning max
                    RageUI.Button("Tuning Maximum", "Applique tous les mods", {RightLabel = "→"}, IsPedInAnyVehicle(PlayerPedId(), false), {
                        onSelected = function()
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            SetVehicleModKit(vehicle, 0)
                            for i = 0, 49 do
                                local max = GetNumVehicleMods(vehicle, i)
                                SetVehicleMod(vehicle, i, max - 1, false)
                            end
                            ToggleVehicleMod(vehicle, 18, true) -- Turbo
                            ToggleVehicleMod(vehicle, 22, true) -- Xénon
                            RageUI.Popup({message = "Tuning appliqué !"})
                        end
                    })
                    
                    RageUI.Separator("~r~Danger")
                    
                    -- Bouton supprimer véhicule
                    RageUI.Button("~r~Supprimer Véhicule", "Supprime votre véhicule", {RightLabel = "→"}, IsPedInAnyVehicle(PlayerPedId(), false), {
                        onSelected = function()
                            local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
                            DeleteVehicle(vehicle)
                            RageUI.Popup({message = "Véhicule supprimé"})
                        end
                    })
                    
                end)
                
                -- ===== SOUS-MENU ARMES =====
                RageUI.IsVisible(SousMenuArmes, function()
                    
                    RageUI.Separator("~r~Arsenal")
                    
                    -- Liste d'armes
                    RageUI.List("Sélectionner Arme",
                        {"Pistolet", "Fusil d'assaut", "Pompe", "Sniper", "RPG"},
                        IndexArme,
                        "Choisissez votre arme",
                        {},
                        true,
                        {
                            onListChange = function(Index)
                                IndexArme = Index
                            end,
                            onSelected = function(Index)
                                local playerPed = PlayerPedId()
                                GiveWeaponToPed(playerPed, GetHashKey(ArmesListe[Index].hash), 250, false, true)
                                RageUI.Popup({message = "Arme reçue: " .. ArmesListe[Index].name})
                            end
                        }
                    )
                    
                    RageUI.Separator("~g~Actions Rapides")
                    
                    -- Bouton toutes les armes
                    RageUI.Button("Toutes les Armes", "Donne toutes les armes", {RightLabel = "→", RightBadge = RageUI.BadgeStyle.Gun}, true, {
                        onSelected = function()
                            local playerPed = PlayerPedId()
                            for k,v in pairs(ArmesListe) do
                                GiveWeaponToPed(playerPed, GetHashKey(v.hash), 250, false, false)
                            end
                            RageUI.Popup({message = "Toutes les armes reçues !"})
                        end
                    })
                    
                    -- Bouton munitions infinies
                    RageUI.Button("Munitions Infinies", "Active les munitions illimitées", {RightLabel = "→"}, true, {
                        onSelected = function()
                            SetPedInfiniteAmmoClip(PlayerPedId(), true)
                            RageUI.Popup({message = "Munitions infinies activées !"})
                        end
                    })
                    
                    -- Bouton retirer armes
                    RageUI.Button("~r~Retirer Toutes les Armes", "Supprime votre inventaire", {RightLabel = "→"}, true, {
                        onSelected = function()
                            RemoveAllPedWeapons(PlayerPedId(), true)
                            RageUI.Popup({message = "Armes retirées"})
                        end
                    })
                    
                end)
                
                -- ===== SOUS-MENU ADMIN =====
                RageUI.IsVisible(SousMenuAdmin, function()
                    
                    RageUI.Separator("~r~Panneau Administrateur")
                    
                    -- Checkbox noclip
                    RageUI.Checkbox("NoClip", "Mode de vol libre", CheckboxNoclip, {}, {
                        onChecked = function()
                            CheckboxNoclip = true
                            -- Code noclip ici
                            print("NoClip activé")
                        end,
                        onUnChecked = function()
                            CheckboxNoclip = false
                            print("NoClip désactivé")
                        end
                    })
                    
                    RageUI.Separator("~b~Monde")
                    
                    -- Liste météo
                    RageUI.List("Changer Météo",
                        MeteoListe,
                        IndexMeteo,
                        "Modifier la météo du serveur",
                        {},
                        true,
                        {
                            onListChange = function(Index)
                                IndexMeteo = Index
                            end,
                            onSelected = function(Index)
                                -- TriggerServerEvent pour changer météo
                                print("Météo changée: " .. MeteoListe[Index])
                                RageUI.Popup({message = "Météo: " .. MeteoListe[Index]})
                            end
                        }
                    )
                    
                    -- Slider heure
                    RageUI.List("Définir l'Heure", 
                        {"00h", "06h", "12h", "18h", "Personnalisé"},
                        1,
                        "Changer l'heure du serveur",
                        {},
                        true,
                        {
                            onSelected = function(Index)
                                local heures = {0, 6, 12, 18, 12}
                                NetworkOverrideClockTime(heures[Index], 0, 0)
                                RageUI.Popup({message = "Heure changée: " .. heures[Index] .. "h"})
                            end
                        }
                    )
                    
                    RageUI.Separator("~y~Serveur")
                    
                    -- Bouton annonce
                    RageUI.Button("Faire une Annonce", "Envoyer un message global", {RightLabel = "→", RightBadge = RageUI.BadgeStyle.Alert}, true, {
                        onSelected = function()
                            -- TriggerServerEvent pour annonce
                            RageUI.Popup({message = "Annonce envoyée !"})
                        end
                    })
                    
                    -- Ligne de séparation
                    RageUI.Line()
                    
                    -- Informations
                    RageUI.Button("Version: ~g~1.0.0", nil, {}, false, {})
                    RageUI.Button("Uptime: ~b~24h 32m", nil, {}, false, {})
                    
                end)
                
            end
        end)
    end
end

-- Commande pour ouvrir le menu
RegisterCommand("menudemo", function()
    OuvrirMenu()
end, false)

-- Keybind (F5 par exemple)
RegisterKeyMapping("menudemo", "Ouvrir le menu de démonstration", "keyboard", "F5")

-- Message de bienvenue
CreateThread(function()
    Wait(1000)
    print("^2Menu RageUI V2 chargé ! Appuyez sur F5 ou tapez /menudemo^0")
end)