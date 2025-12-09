-- ox_inventory UI examples menu
-- Usage: /oxuiexample to open the example menu

Citizen.CreateThread(function()
  while not RageUI do Citizen.Wait(100) end

  local oxMenu = RageUI.CreateMenu("ox_inventory UI", "Exemples: UIBarIcon, UIBasic, TimerBar")
  local open = false
  local timerActive = false
  local timerEnd = 0
  local timerLabel = ""

  local function toggle()
    open = not open
    RageUI.Visible(oxMenu, open)
  end
-- Variables d'exemple
local CheckboxGodmode = false
local CheckboxInvisible = false
local CheckboxNoclip = false
local SliderVitesse = 1
local IndexVehicule = 1
local IndexArme = 1
local IndexMeteo = 1
local Indexheure = 1
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

local MeteoListe = {"Neige"}

  RegisterCommand("oxuiexample", function()
    toggle()
  end)

  -- Safe call helpers for common ox_inventory export/event names
  -- Helpers: accept args as a table to avoid vararg usage issues in some analyzers
  --[[local function tryCallOxExport(name, args)
    args = args or {}
    if exports and exports.ox_inventory and exports.ox_inventory[name] then
      local ok, res = pcall(function() return exports.ox_inventory[name](table.unpack(args)) end)
      return ok, res
    end
    return false, nil
  end]]

  local function tryTriggerOxEvent(evt, args)
    args = args or {}
    if _G and _G[evt] then
      -- unlikely: event exists as function
      local ok, res = pcall(function() return _G[evt](table.unpack(args)) end)
      return ok, res
    end
    -- fallback: TriggerEvent (script will handle if registered)
    TriggerEvent(evt, table.unpack(args))
    return false, nil
  end

  local function startLocalTimer(seconds, label)
    timerActive = true
    timerEnd = GetGameTimer() + (seconds * 1000)
    timerLabel = label or "Timer"
    Citizen.CreateThread(function()
      while timerActive do
        Citizen.Wait(200)
        if GetGameTimer() >= timerEnd then
          timerActive = false
          TriggerEvent('chat:addMessage', { args = {'^2ox_ui', timerLabel .. ' terminé'} })
        end
      end
    end)
  end

  -- Main render loop
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      if open then
        RageUI.IsVisible(oxMenu, function()
          RageUI.Separator("Exemples d'intégration avec ox_inventory")

          RageUI.Button("UIBarIcon (ex)", "Affiche une barre avec icône via ox_inventory (si disponible)", {}, true, {
            onSelected = function()
              -- Try common export names
              local ok = false
              ok = tryCallOxExport('OpenUIBarIcon', { icon = 'star', value = 75 })
              if ok then return end

              ok = tryCallOxExport('showBarIcon', { icon = 'star', value = 75 })
              if ok then return end

              -- fallback: trigger an event that some ox_inventory versions may listen to
              tryTriggerOxEvent('ox_inventory:show:UIBarIcon', { icon = 'star', value = 75 })

              -- If nothing handled, notify user
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'UIBarIcon: export/event non trouvé, action de démo exécutée'} })
            end
          })

          RageUI.Button("UIBasic (ex)", "Affiche une UI basique via ox_inventory (si disponible)", {}, true, {
            onSelected = function()
              local ok = false
              ok = tryCallOxExport('OpenUIBasic', { title = 'Santé', value = 80 })
              if ok then return end

              ok = tryCallOxExport('showBasic', { title = 'Santé', value = 80 })
              if ok then return end

              tryTriggerOxEvent('ox_inventory:show:UIBasic', { title = 'Santé', value = 80 })

              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'UIBasic: export/event non trouvé, action de démo exécutée'} })
            end
          })

          RageUI.Button("TimerBar (ex)", "Démarre une TimerBar de démonstration (local si ox absent)", {}, true, {
            onSelected = function()
              -- Prefer calling export if exists (pass args as table)
              local ok, _ = tryCallOxExport('StartTimerBar', {10, 'Cooldown'})
              if ok then return end

              ok, _ = tryCallOxExport('startTimerBar', {10, 'Cooldown'})
              if ok then return end

              tryTriggerOxEvent('ox_inventory:start:timerbar', {10, 'Cooldown'})

              -- fallback local timer
              startLocalTimer(10, 'Cooldown')
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'TimerBar: démarré localement (10s)'} })
            end
          })
                    RageUI.Button("TimerBar (ex)", "Démarre une TimerBar de démonstration (local si ox absent)", {}, true, {
            onSelected = function()
              -- Prefer calling export if exists (pass args as table)
              local ok, _ = tryCallOxExport('StartTimerBar', {10, 'Cooldown'})
              if ok then return end

              ok, _ = tryCallOxExport('startTimerBar', {10, 'Cooldown'})
              if ok then return end

              tryTriggerOxEvent('ox_inventory:start:timerbar', {10, 'Cooldown'})

              -- fallback local timer
              startLocalTimer(10, 'Cooldown')
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'TimerBar: démarré localement (10s)'} })
            end
          })
                              RageUI.Button("TimerBar (ex)", "Démarre une TimerBar de démonstration (local si ox absent)", {}, true, {
            onSelected = function()
              -- Prefer calling export if exists (pass args as table)
              local ok, _ = tryCallOxExport('StartTimerBar', {10, 'Cooldown'})
              if ok then return end

              ok, _ = tryCallOxExport('startTimerBar', {10, 'Cooldown'})
              if ok then return end

              tryTriggerOxEvent('ox_inventory:start:timerbar', {10, 'Cooldown'})

              -- fallback local timer
              startLocalTimer(10, 'Cooldown')
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'TimerBar: démarré localement (10s)'} })
            end
          })
                                        RageUI.Button("TimerBar (ex)", "Démarre une TimerBar de démonstration (local si ox absent)", {}, true, {
            onSelected = function()
              -- Prefer calling export if exists (pass args as table)
              local ok, _ = tryCallOxExport('StartTimerBar', {10, 'Cooldown'})
              if ok then return end

              ok, _ = tryCallOxExport('startTimerBar', {10, 'Cooldown'})
              if ok then return end

              tryTriggerOxEvent('ox_inventory:start:timerbar', {10, 'Cooldown'})

              -- fallback local timer
              startLocalTimer(10, 'Cooldown')
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'TimerBar: démarré localement (10s)'} })
            end
          })
                                                  RageUI.Button("TimerBar (ex)", "Démarre une TimerBar de démonstration (local si ox absent)", {}, true, {
            onSelected = function()
              -- Prefer calling export if exists (pass args as table)
              local ok, _ = tryCallOxExport('StartTimerBar', {10, 'Cooldown'})
              if ok then return end

              ok, _ = tryCallOxExport('startTimerBar', {10, 'Cooldown'})
              if ok then return end

              tryTriggerOxEvent('ox_inventory:start:timerbar', {10, 'Cooldown'})

              -- fallback local timer
              startLocalTimer(10, 'Cooldown')
              TriggerEvent('chat:addMessage', { args = {'^3ox_ui', 'TimerBar: démarré localement (10s)'} })
            end
          })
                                                                      RageUI.Separator("~b~Monde")
                    
                    -- Liste météo
                    RageUI.List("Changer Météo",MeteoListe,IndexMeteo,"Modifier la météo du serveur",{}, true, {
                            onListChange = function(Index)
                                IndexMeteo = Index
                            end,
                            onSelected = function(Index)
                                -- TriggerServerEvent pour changer météo
                                SetWeatherTypeNow(XMAS,13)
                                SetWeatherTypeNowPersist(XMAS,13)
                                SetWeatherTypePersist(XMAS,13)
                                --tryTriggerXMax()
                                print("Météo changée: " .. MeteoListe[Index].." [XMAS] meteo now")
                                RageUI.Popup({message = "Météo: " .. MeteoListe[Index]})
                            end
                        }
                    )
                    
                    -- Slider heure
                    RageUI.List("Définir l'Heure", {"00h", "06h", "12h", "18h", "Personnalisé"},Indexheure,"Changer l'heure du serveur",{},true,{
                                                  onListChange = function(Index)
                                Indexheure = Index
                            end,
                            onSelected = function(Index)
                                local heures = {0, 6, 12, 18, 12}
                                NetworkOverrideClockTime(heures[Index], 0, 0)
                                RageUI.Popup({message = "Heure changée: " .. heures[Index] .. "h"})
                            end
                        }
                    )


          if timerActive then
            local remaining = math.max(0, math.ceil((timerEnd - GetGameTimer()) / 1000))
            RageUI.Separator("Timer: ~g~" .. tostring(remaining) .. "s ~s~- " .. timerLabel)
          end

          RageUI.Separator("---")
          RageUI.Button("Fermer", nil, {}, true, { onSelected = function() toggle() end })
        end)
      end
    end
  end)
end)

Citizen.CreateThread(function()
    ClearWeatherTypePersist()
    SetWeatherTypePersist("XMAS")
    SetWeatherTypeNow("XMAS")
    SetWeatherTypeNowPersist("XMAS")
    SetForceVehicleTrails(true)
    SetForcePedFootstepsTracks(true)
      while true do
    SetVehicleDensityMultiplierThisFrame(0.0)
    SetPedDensityMultiplierThisFrame(0.0)
    SetRandomVehicleDensityMultiplierThisFrame(0.0)
    SetParkedVehicleDensityMultiplierThisFrame(0.0)
    SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)

    Citizen.Wait(0)
end

end)
