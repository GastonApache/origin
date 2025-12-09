GeminiUI = {}
GeminiUI.Visible = false
GeminiUI.CurrentIndex = 1
GeminiUI.CurrentMenuData = {}
GeminiUI.ItemsList = {}

function GeminiUI.SetVisible(bool)
	GeminiUI.Visible = bool
	local msg = json.encode({action = "setVisible", show = bool})
	SendNuiMessage(msg)
	 if bool then 
	 	GeminiUI.CurrentIndex = 1
	 	PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	 else 
	 	PlaySoundFrontend(-1, "QUIT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	 end
end

function GeminiUI.Button(label, description, rightlabel, cb)
	if not GeminiUI.Visible then return end

	table.insert(GeminiUI.ItemsList, {
		label = label,
		description = description,
		rightlabel = rightlabel
	})

	local thisIndex = #GeminiUI.ItemsList
	local isSelected = (GeminiUI.CurrentIndex == thisIndex)

	if isSelected and IsControlJustPressed(0,201) then
		PlaySoundFrontend(-1, "SELECT", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
		if cb then cb() end
	end
end

function GeminiUI.Render(title, subtitle)
	if not GeminiUI.Visible then return end

	if IsControlJustPressed(0, 172) then 
		GeminiUI.CurrentIndex = GeminiUI.CurrentIndex - 1
		if GeminiUI.CurrentIndex < 1 then 
			GeminiUI.CurrentIndex = #GeminiUI.ItemsList 
		end 
		PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true) 
	end

	if IsControlJustPressed(0, 173) then 
		GeminiUI.CurrentIndex = GeminiUI.CurrentIndex + 1
		if GeminiUI.CurrentIndex > #GeminiUI.ItemsList then 
			GeminiUI.CurrentIndex = 1 
		end
		PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
	end

	if IsControlJustPressed(0, 177) then
		GeminiUI.SetVisible(false) 
	end

	SendNuiMessage(json.encode({
		action = "updateMenu",
		title = title,
		subtitle = subtitle,
		currentSelect = GeminiUI.CurrentIndex,
		items = GeminiUI.ItemsList
	}))

	GeminiUI.ItemsList = {}
end

local menuOpen = false 

RegisterCommand("menu_html", 
	function(source, args, rawCommand)
		menuOpen = not menuOpen 
		GeminiUI.SetVisible(menuOpen) 
	
end)

RegisterKeyMapping("menu_html", "Menu HTML Gemini", "keyboard", "F")

Citizen.CreateThread(function()
	while true do
		local wait = 1000
		if GeminiUI.Visible then wait = 0 end

		Citizen.Wait(wait)
		if GeminiUI.Visible then
			GeminiUI.Button("se soigner", "une trousse de secour arrive", "~g~$", function()
				SetEntityHealth(PlayerPedId(), 200)
				TriggerEvent('chat:addMessage', {
					args = {"Soin", "~b~vous etes maintenant en bonne santé"},
					color = {0, 255, 0}
				})
			end)

			GeminiUI.Button("Suicide", "je reviendrais plus fort", "", function()
				SetEntityHealth(PlayerPedId(), 0) 
				GeminiUI.SetVisible(false)
			end)

			local playerPed = PlayerPedId()
			if IsPedInAnyVehicle(playerPed, false) then
				GeminiUI.Button("reparer la voiture", "appel un mecano", "$", function()
					local veh = GetVehiclePedIsIn(playerPed, false)
					SetVehicleFixed(veh)  
				end)    		
			else 
				GeminiUI.Button("pas de voiture","monte dedans","*", nil)
			end
			
			GeminiUI.Render("GeminiUI Menu", "InterActionHTML 5")
		end
	end
end)