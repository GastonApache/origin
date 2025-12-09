# 🎨 CONFIGURATION RAGEMENU

## 📁 Fichier de Configuration

Le fichier `config.lua` vous permet de personnaliser entièrement l'apparence de vos menus RageUI.

## 🎯 Sections de Configuration

### 1️⃣ **HEADER (En-tête du menu)**
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
Config.HeaderTextColor = "#FFFFFF"
Config.HeaderGlowEffect = true
```
- **HeaderBackgroundColor** : Couleur de fond ou gradient CSS
- **HeaderTextColor** : Couleur du texte
- **HeaderGlowEffect** : Animation de brillance (true/false)

### 2️⃣ **NAVIGATION (Items sélectionnés)**
```lua
Config.NavigationBackgroundColor = "#ff5900"
Config.NavigationTextColor = "#FFFFFF"
Config.NavigationUseGradient = false
```
- Personnalisez l'apparence quand vous naviguez sur un item

### 3️⃣ **ITEMS DE MENU**
```lua
Config.ItemBackgroundColor = "rgba(0, 0, 0, 0.8)"
Config.ItemTextColor = "#FFFFFF"
Config.ItemHoverOpacity = 0.9
```
- Style des items non-sélectionnés

### 4️⃣ **ICÔNE CHECK** ✓
```lua
Config.CheckIconColor = "#ff5900"
Config.CheckIconSize = "2.5vh"
Config.CheckIconGlow = true
Config.CheckIconAnimation = true
```
- L'icône qui apparaît à droite lors de la navigation

### 5️⃣ **SLIDERS**
```lua
Config.SliderBackgroundColor = "rgba(255, 255, 255, 0.2)"
Config.SliderProgressColor = "#ff5900"
Config.SliderHeight = "0.8vh"
```

### 6️⃣ **DESCRIPTION**
```lua
Config.DescriptionBackgroundColor = "rgba(0, 0, 0, 0.9)"
Config.DescriptionTextColor = "#CCCCCC"
Config.DescriptionBorderColor = "#000000"
```

### 7️⃣ **SIDE PANEL**
```lua
Config.SidePanelBackgroundColor = "rgba(0, 0, 0, 0.9)"
Config.SidePanelTextColor = "#FFFFFF"
Config.SidePanelAlternateRowColor = "rgba(0, 0, 0, 0.8)"
```

### 8️⃣ **DIMENSIONS**
```lua
Config.MenuWidth = "37vh"
Config.ItemHeight = "5vh"
Config.HeaderHeight = "12vh"
Config.FontSize = "1.9vh"
```

### 9️⃣ **ANIMATIONS & EFFETS**
```lua
Config.EnableAnimations = true
Config.AnimationSpeed = "0.3s"
Config.EnableShadows = true
Config.EnableBlur = false
Config.BorderRadius = "0px"
```

## 🎨 Exemples de Thèmes

### Thème Orange Vif (Actuel)
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #ff5900 0%, #ff8c00 100%)"
Config.NavigationBackgroundColor = "#ff5900"
Config.CheckIconColor = "#ff5900"
```

### Thème Bleu Électrique
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #00d4ff 0%, #0099ff 100%)"
Config.NavigationBackgroundColor = "#00d4ff"
Config.CheckIconColor = "#00d4ff"
Config.SliderProgressColor = "#00d4ff"
```

### Thème Violet/Rose
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
Config.NavigationBackgroundColor = "#764ba2"
Config.CheckIconColor = "#667eea"
Config.SliderProgressColor = "#667eea"
```

### Thème Vert Matrix
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #00ff41 0%, #00b32e 100%)"
Config.NavigationBackgroundColor = "#00ff41"
Config.CheckIconColor = "#00ff41"
Config.SliderProgressColor = "#00ff41"
```

### Thème Rouge Sombre
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #ff0000 0%, #8b0000 100%)"
Config.NavigationBackgroundColor = "#ff0000"
Config.CheckIconColor = "#ff0000"
Config.SliderProgressColor = "#ff0000"
```

## 🔧 Comment Appliquer les Changements

1. Ouvrez `ragemenu/config.lua`
2. Modifiez les valeurs selon vos préférences
3. Sauvegardez le fichier
4. Redémarrez la resource : `restart ragemenu`
5. Les changements sont appliqués automatiquement! ✨

## 💡 Conseils

- Utilisez des gradients CSS pour des headers plus stylés
- Les couleurs RGBA permettent la transparence : `rgba(255, 89, 0, 0.8)`
- Les valeurs en `vh` (viewport height) s'adaptent à toutes les résolutions
- Testez différentes combinaisons pour trouver votre style!

## 📝 Formats de Couleur Supportés

- **HEX** : `#ff5900`, `#F19E39`
- **RGB** : `rgb(255, 89, 0)`
- **RGBA** : `rgba(255, 89, 0, 0.8)` (avec transparence)
- **Gradient CSS** : `linear-gradient(135deg, #ff5900 0%, #ff8c00 100%)`
- **Noms CSS** : `red`, `blue`, `green`, etc.

## 🎮 Configuration Par Resource

Pour avoir des configs différentes par resource, utilisez :

```lua
local config = exports['ragemenu']:GetConfig()
-- Modifiez config selon vos besoins
```

---

**Créé pour RageMenu** | Compatible avec tous les menus RageUI
