Config = {}

-- ═══════════════════════════════════════════════════════════
--  CONFIGURATION RAGEMENU - THÈME DEFAULT
-- ═══════════════════════════════════════════════════════════

-- Thème Default (Bleu/Violet d'origine)
Config.Themes = {
    Default = {
        Header = "url('assets/banners/default.png')",
        Navigation = "url('assets/icons/commonmenu/gradient_nav.png')",
        NavigationTextColor = "#000000", -- Texte noir pour contraste sur navigation blanche
        CheckIcon = "#DF5B0E",
        Slider = "#3974c8",
        Background = "url('assets/icons/commonmenu/gradient_bgd.png')",
        Font = "SignPainter", -- Police pour Header
        ItemFont = "SignPainter", -- Police pour Buttons, Lists, Sliders, etc. (Changez ici: RageUI, SignPainter, Roboto, Poppins, Montserrat, Bebas Neue, Oswald, Lato, Open Sans)
    },
}

-- Thème actif
Config.ActiveTheme = "Default"

-- Couleurs appliquées (basées sur le thème Default)
Config.HeaderBackgroundColor = "url('assets/banners/default.png')"
Config.HeaderTextColor = "#FFFFFF"
Config.HeaderGlowEffect = true

Config.NavigationBackgroundColor = "url('assets/icons/commonmenu/gradient_nav.png')"
Config.NavigationTextColor = "#000000"
Config.NavigationUseGradient = false

Config.ItemBackgroundColor = "rgba(0, 0, 0, 0.8)"
Config.ItemTextColor = "#FFFFFF"
Config.ItemHoverOpacity = 0.9

Config.DescriptionBackgroundColor = "rgba(0, 0, 0, 0.9)"
Config.DescriptionTextColor = "#CCCCCC"
Config.DescriptionBorderColor = "#000000"

Config.SliderBackgroundColor = "rgba(255, 255, 255, 0.2)"
Config.SliderProgressColor = "#3974c8"
Config.SliderHeight = "0.8vh"

Config.CheckboxCheckedColor = "#00ff00"
Config.CheckboxUncheckedColor = "rgba(255, 255, 255, 0.3)"

Config.CheckIconColor = "#DF5B0E"
Config.CheckIconSize = "2.5vh"
Config.CheckIconGlow = true
Config.CheckIconAnimation = true

Config.SidePanelBackgroundColor = "rgba(0, 0, 0, 0.9)"
Config.SidePanelTextColor = "#FFFFFF"
Config.SidePanelAlternateRowColor = "rgba(0, 0, 0, 0.8)"

Config.MenuWidth = "37vh"
Config.ItemHeight = "5vh"
Config.HeaderHeight = "12vh"
Config.FontSize = "1.9vh"

Config.EnableAnimations = true
Config.AnimationSpeed = "0.3s"

Config.EnableShadows = true
Config.EnableBlur = false
Config.BorderRadius = "0px"

Config.BackgroundGradient = "url('assets/icons/commonmenu/gradient_bgd.png')"
Config.UseGradientImage = false

Config.HeaderFont = "SignPainter" -- Police du Header
Config.MenuFont = "SignPainter" -- Police des Items (Buttons, Lists, Sliders) - CHANGEZ ICI POUR CHANGER LA POLICE DES MENUS
Config.FontWeight = "400"
Config.HeaderFontSize = "5vh"
Config.ItemFontSize = "1.9vh"

Config.EnableMaterialIcons = true
Config.IconStyle = "outlined"

-- ═══════════════════════════════════════════════════════════
--  FONCTIONS UTILITAIRES
-- ═══════════════════════════════════════════════════════════

-- Fonction pour appliquer le thème Default
function ApplyTheme(themeName)
    if themeName ~= "Default" then
        print("^3[RageMenu]^0 Seul le thème Default est disponible")
        themeName = "Default"
    end
    
    local theme = Config.Themes.Default
    Config.HeaderBackgroundColor = theme.Header
    Config.NavigationBackgroundColor = theme.Navigation
    Config.NavigationTextColor = theme.NavigationTextColor
    Config.CheckIconColor = theme.CheckIcon
    Config.SliderProgressColor = theme.Slider
    Config.BackgroundGradient = theme.Background
    Config.HeaderFont = theme.Font
    Config.MenuFont = theme.ItemFont or theme.Font -- Police des items (buttons, lists, sliders)
    
    -- Envoyer au NUI
    SendNUIMessage({
        action = 'setConfig',
        data = Config
    })
    
    print("^2[RageMenu]^0 Thème Default appliqué!")
    return true
end

-- Fonction pour réinitialiser les couleurs
function ResetMenuColors()
    ApplyTheme("Default")
    print("^2[RageMenu]^0 Menu restauré au thème Default!")
end

-- ═══════════════════════════════════════════════════════════
--  EXPORT DE LA CONFIGURATION VERS LE NUI
-- ═══════════════════════════════════════════════════════════

function GetRageMenuConfig()
    return Config
end

-- Envoyer la config au NUI au démarrage
CreateThread(function()
    Wait(1000)
    ApplyTheme("Default")
    print("^2[RageMenu]^0 Configuration chargée!")
end)

-- Export
exports('GetConfig', GetRageMenuConfig)
exports('ApplyTheme', ApplyTheme)
exports('ResetMenuColors', ResetMenuColors)
