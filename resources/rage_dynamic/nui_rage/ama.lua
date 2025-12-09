-- Lua envoie au JS
--[[SendNUIMessage({
    type = "openMenu",
    data = {
        title = "Mon Menu",
        items = {"Item 1", "Item 2"}
    }
})

-- JS envoie à Lua
RegisterNUICallback('buttonClicked', function(props)
    CircularProgressWithLabel(props)
    print("Bouton cliqué: " .. props)
    cb('ok')
end)

-- client.lua
CreateThread(function()
    while true do

            SendNUIMessage({
                type = CircularProgressWithLabel(props),

            })
        Wait(100)
    end
end)

-- Créer un DUI
local duiUrl = "https://www.youtube.com/embed/dQw4w9WgXcQ"
local dui = CreateDui(duiUrl, 1920, 1080)
local duiHandle = GetDuiHandle(dui)

-- Créer une texture runtime
local txd = CreateRuntimeTxd("duiTxd")
local tx = CreateRuntimeTextureFromDuiHandle(txd, "duiTex", duiHandle)

-- Dessiner à l'écran
DrawSprite("duiTxd", "duiTex", 0.5, 0.5, 0.5, 0.5, 0.0, 255, 255, 255, 255)]]
