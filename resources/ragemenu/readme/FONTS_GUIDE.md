# 🎨 GUIDE DES POLICES ET COULEURS - RAGEMENU

## 📝 POLICES DISPONIBLES

### 🎯 Polices Locales (Incluses dans le script)

Ces polices sont **déjà intégrées** dans le script et ne nécessitent **aucune connexion internet**!

- **RageUI** - Police par défaut du menu (format: .otf)
  - Style: Moderne, lisible
  - Utilisation recommandée: Menu principal, items
  - Fichier: `web/public/fonts/RageUIText.otf`

- **SignPainter** - Police script élégante (format: .woff)
  - Style: Manuscrite, décorative
  - Utilisation recommandée: Headers, titres
  - Fichier: `web/public/fonts/SignPainterHouseScript.woff`

### 🌐 Polices Google Fonts

Les polices sont chargées automatiquement depuis Google Fonts!

#### Polices Modernes:
- **Bebas Neue** - Style moderne, épuré
- **Roboto** - Polyvalente, lisible
- **Poppins** - Moderne, arrondie
- **Montserrat** - Élégante, professionnelle

#### Polices Gaming:
- **Orbitron** - Style futuriste/sci-fi
- **Rajdhani** - Technologique, gaming

#### Polices Élégantes:
- **Cinzel** - Luxueuse, classique
- **Quicksand** - Douce, arrondie
- **Oswald** - Condensée, impactante

## 🎯 CONFIGURATION DANS config.lua

```lua
-- Utiliser les polices locales (RECOMMANDÉ - Pas besoin d'internet!)
Config.HeaderFont = "RageUI"      -- Police du header
Config.MenuFont = "RageUI"        -- Police des items

-- OU utiliser les polices Google Fonts
Config.HeaderFont = "Bebas Neue"
Config.MenuFont = "Roboto"

-- Paramètres de police
Config.FontWeight = "400"         -- 300=Light, 400=Regular, 500=Medium, 700=Bold
Config.HeaderFontSize = "5vh"     -- Taille du header
Config.ItemFontSize = "1.9vh"     -- Taille des items

-- Background gradient personnalisé
Config.BackgroundGradient = "linear-gradient(135deg, rgba(0, 0, 0, 0.95) 0%, rgba(20, 20, 20, 0.95) 100%)"
Config.UseGradientImage = false   -- true pour utiliser l'image, false pour CSS

-- Icônes Material Design
Config.EnableMaterialIcons = true
Config.IconStyle = "outlined"     -- outlined, filled, rounded, sharp, two-tone
```

## 💻 COMMANDES IN-GAME

### Changer la police:
```
/menufont RageUI
/menufont SignPainter
/menufont Poppins
/menufont "Bebas Neue" 6
/menufont Orbitron
```

### Changer les couleurs:
```
/menucolor navigation #00ff00
/menucolor header linear-gradient(135deg, #ff0000 0%, #aa0000 100%)
/menucolor background rgba(0, 0, 0, 0.9)
/menucolor check #ffff00
```

### Changer de thème:
```
/menutheme Blue
/menutheme Purple
/menutheme Green
```

## 🎨 EXEMPLES DE COMBINAISONS

### Style Gaming Moderne:
```lua
Config.HeaderFont = "Orbitron"
Config.MenuFont = "Rajdhani"
Config.NavigationBackgroundColor = "#00ff41"
Config.BackgroundGradient = "linear-gradient(135deg, rgba(0, 255, 65, 0.1) 0%, rgba(0, 179, 46, 0.1) 100%)"
```

### Style Élégant:
```lua
Config.HeaderFont = "Cinzel"
Config.MenuFont = "Montserrat"
Config.NavigationBackgroundColor = "#ffd700"
Config.BackgroundGradient = "linear-gradient(135deg, rgba(255, 215, 0, 0.1) 0%, rgba(255, 170, 0, 0.1) 100%)"
```

### Style Futuriste:
```lua
Config.HeaderFont = "Orbitron"
Config.MenuFont = "Roboto"
Config.FontWeight = "700"
Config.NavigationBackgroundColor = "#00d4ff"
Config.CheckIconColor = "#00ffff"
```

## 🔧 UTILISATION DEPUIS LE CODE LUA

### Changer la police:
```lua
exports['ragemenu']:SetMenuFont('Poppins', 5)
```

### Changer le background:
```lua
exports['ragemenu']:SetMenuColor('background', 'linear-gradient(135deg, rgba(255, 0, 0, 0.2) 0%, rgba(139, 0, 0, 0.2) 100%)')
```

### Appliquer un thème complet:
```lua
exports['ragemenu']:ApplyTheme('Blue')  -- Change couleurs + police
```

## 📋 THÈMES AVEC POLICES INTÉGRÉES

Chaque thème a sa propre police:

| Thème  | Police      | Style         |
|--------|-------------|---------------|
| Orange | Bebas Neue  | Moderne       |
| Blue   | Roboto      | Standard      |
| Purple | Poppins     | Élégant       |
| Green  | Orbitron    | Futuriste     |
| Red    | Oswald      | Impact        |
| Gold   | Cinzel      | Luxueux       |
| Cyan   | Rajdhani    | Tech          |
| Pink   | Quicksand   | Doux          |

## 🎯 GRADIENT BACKGROUND

### Option 1: Gradient CSS (recommandé)
```lua
Config.BackgroundGradient = "linear-gradient(135deg, rgba(255, 89, 0, 0.15) 0%, rgba(255, 140, 0, 0.15) 100%)"
Config.UseGradientImage = false
```

### Option 2: Image gradient_bgd.png
```lua
Config.UseGradientImage = true
-- Place ton image dans: ragemenu/web/public/assets/icons/commonmenu/gradient_bgd.png
```

## 💡 CONSEILS

### Poids des polices:
- **300** - Light (léger, fin)
- **400** - Regular (normal)
- **500** - Medium (moyen)
- **700** - Bold (gras)

### Tailles recommandées:
- Header: 4-6vh
- Items: 1.7-2.2vh
- Icônes: 2-3vh

### Gradients:
Utilisez des valeurs RGBA faibles (0.1-0.2) pour les backgrounds pour ne pas surcharger

## 🔧 AJOUTER VOS PROPRES POLICES LOCALES

Vous pouvez ajouter vos propres polices .otf ou .woff au menu!

### Étape 1: Ajouter le fichier de police
Placez votre fichier de police dans:
```
ragemenu/web/public/fonts/MaPolice.otf
```

### Étape 2: Déclarer la police dans index.scss
Ouvrez `ragemenu/web/src/css/index.scss` et ajoutez:
```scss
@font-face {
  font-family: 'MaPolice';
  font-style: normal;
  font-weight: normal;
  src: url('fonts/MaPolice.otf') format('opentype');
}
```

Pour une police .woff:
```scss
@font-face {
  font-family: 'MaPolice';
  font-style: normal;
  font-weight: normal;
  src: url('fonts/MaPolice.woff') format('woff');
}
```

### Étape 3: Ajouter à la liste des polices locales
Ouvrez `ragemenu/web/src/utils/configManager.ts` et ajoutez votre police:
```typescript
const LOCAL_FONTS = ['RageUI', 'SignPainter', 'MaPolice'];
```

### Étape 4: Compiler le NUI
```bash
cd ragemenu/web
npm run build
```

### Étape 5: Utiliser votre police
Dans `config.lua`:
```lua
Config.HeaderFont = "MaPolice"
Config.MenuFont = "MaPolice"
```

Ou en jeu:
```
/menufont MaPolice
```

## 🚀 EXEMPLES RAPIDES

### Menu avec RageUI (Police locale):
```lua
Config.ActiveTheme = "Default"
Config.HeaderFont = "RageUI"
Config.MenuFont = "RageUI"
Config.FontWeight = "400"
```

### Menu avec SignPainter (Police locale):
```lua
Config.ActiveTheme = "Gold"
Config.HeaderFont = "SignPainter"
Config.MenuFont = "RageUI"  -- SignPainter pour items moins lisible
Config.FontWeight = "400"
```

### Menu Gaming:
```lua
Config.ActiveTheme = "Green"
Config.HeaderFont = "Orbitron"
Config.FontWeight = "700"
```

### Menu Élégant:
```lua
Config.ActiveTheme = "Gold"
Config.HeaderFont = "Cinzel"
Config.FontWeight = "400"
```

### Menu Minimaliste:
```lua
Config.ActiveTheme = "Blue"
Config.HeaderFont = "Roboto"
Config.FontWeight = "300"
Config.BackgroundGradient = "rgba(0, 0, 0, 0.85)"
```

## 📊 COMPARAISON POLICES LOCALES VS GOOGLE FONTS

| Critère | Polices Locales | Google Fonts |
|---------|----------------|--------------|
| **Connexion Internet** | ❌ Pas nécessaire | ✅ Requise |
| **Vitesse de chargement** | ⚡ Instantané | 🐌 Dépend connexion |
| **Exemples** | RageUI, SignPainter | Bebas Neue, Roboto, etc. |
| **Personnalisation** | ✅ Totale | ❌ Limitée à Google |
| **Recommandation** | 🌟 Production | 💻 Développement/Test |

**Recommandation**: Utilisez les **polices locales** (RageUI, SignPainter) pour votre serveur en production!

---

**Note:** Les polices Google Fonts sont chargées automatiquement depuis Google Fonts. Les polices locales sont incluses dans le script! ✨
