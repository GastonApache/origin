# 🎮 RageMenu - Guide d'Utilisation

## 📋 Description
RageMenu est un système de menu NUI moderne pour FiveM avec un système de thèmes personnalisables et des polices locales intégrées.

## ✨ Fonctionnalités

### 🎨 **9 Thèmes Prédéfinis**
- **Default** (Bleu/Violet) - Thème par défaut
- **Orange** - Orange vif
- **Blue** - Bleu électrique
- **Purple** - Violet/Rose
- **Green** - Vert Matrix
- **Red** - Rouge sombre
- **Gold** - Doré
- **Cyan** - Cyan/Turquoise
- **Pink** - Rose

### 🔤 **Polices Disponibles**

#### Polices Locales (Incluses)
- **RageUI** - Police par défaut du menu
- **SignPainter** - Police script élégante

#### Polices Google Fonts
- Bebas Neue
- Roboto
- Poppins
- Oswald
- Orbitron
- Cinzel
- Rajdhani
- Quicksand
- Montserrat

### ⚙️ **Configuration**
Toutes les options sont dans `config.lua`:
- Couleurs du header, navigation, items
- Taille et couleur des icônes
- Dimensions du menu
- Animations et effets visuels
- Polices personnalisées
- Gradients de fond

## 🚀 Installation

1. **Copier** le dossier `ragemenu` dans votre dossier `resources`

2. **Ajouter** dans votre `server.cfg`:
```cfg
ensure ragemenu
```

3. **(Optionnel)** Activer le menu de base dans `fxmanifest.lua`:
```lua
client_scripts {
  'config.lua',
  'utils/keys.lua',
  'utils/nui.lua',
  'ragemenu.lua',
  'menu_base.lua', -- Décommentez cette ligne
}
```

4. **Redémarrer** votre serveur

## 🎮 Utilisation

### Ouvrir le Menu (si menu_base.lua est activé)
- **Touche**: `U`
- **Commande**: `/menu`

### Changer de Thème
- **En jeu**: `/menutheme [nom]` ou `/theme [nom]`
  ```
  Exemples:
  /theme Default
  /theme Orange
  /theme Blue
  ```

- **Dans votre code**:
  ```lua
  exports['ragemenu']:ApplyTheme('Default')
  ```

### Changer une Couleur Spécifique
```lua
-- Commande en jeu
/menucolor navigation #ff0000

-- Dans votre code
exports['ragemenu']:SetMenuColor('header', 'linear-gradient(135deg, #ff0000 0%, #00ff00 100%)')
exports['ragemenu']:SetMenuColor('navigation', '#0000ff')
exports['ragemenu']:SetMenuColor('check', '#ffff00')
exports['ragemenu']:SetMenuColor('slider', '#00ffff')
```

### Changer la Police
```lua
-- Commande en jeu (avec taille optionnelle)
/menufont RageUI 5
/menufont SignPainter
/menufont "Bebas Neue"

-- Dans votre code
exports['ragemenu']:SetMenuFont('RageUI', 5)
exports['ragemenu']:SetMenuFont('SignPainter')
```

### Réinitialiser
```lua
-- Commande en jeu
/menureset

-- Dans votre code
exports['ragemenu']:ResetMenuColors()
```

## 💻 Créer Votre Propre Menu

### Exemple Simple
```lua
-- Créer un menu
local monMenu = RageMenu:CreateMenu('Titre', 'Sous-titre', 'top-left')

-- Ajouter un bouton
monMenu:AddButton('Mon Bouton', 'Description'):On('click', function()
    print('Bouton cliqué!')
end)

-- Ajouter une checkbox
local checked = false
monMenu:AddCheckbox('Option', 'Activer/Désactiver', checked):On('change', function(_, isChecked)
    checked = isChecked
    print('Checkbox: ' .. tostring(isChecked))
end)

-- Ajouter un slider
local valeur = 50
monMenu:AddSlider('Volume', 'Ajuster le volume', valeur, 0, 100, 5, nil):On('change', function(_, newValue)
    valeur = newValue
    print('Valeur: ' .. newValue)
end)

-- Ajouter une liste
local options = {'Option 1', 'Option 2', 'Option 3'}
local index = 1
monMenu:AddList('Choix', 'Sélectionner une option', index, options):On('change', function(_, newIndex)
    index = newIndex
    print('Sélectionné: ' .. options[newIndex])
end)

-- Ouvrir le menu
RageMenu:OpenMenu(monMenu)
```

### Exemple avec Sous-Menu
```lua
local menuPrincipal = RageMenu:CreateMenu('Menu Principal', 'Mon Menu', 'top-left')
local sousMenu = RageMenu:CreateMenu('Sous-Menu', 'Options', 'top-left')

-- Lier le sous-menu
menuPrincipal:AddSubmenu(sousMenu, '📁 Ouvrir Sous-Menu', 'Description')

-- Ajouter des éléments au sous-menu
sousMenu:AddButton('Option 1', 'Description'):On('click', function()
    print('Option 1')
end)

-- Ouvrir le menu principal
RageMenu:OpenMenu(menuPrincipal)
```

## 🎨 Personnalisation dans config.lua

### Changer le Thème par Défaut
```lua
-- Ligne 172 dans config.lua
Config.ActiveTheme = "Default" -- Changez en: Orange, Blue, Purple, etc.
```

### Modifier les Couleurs du Thème Default
```lua
Config.HeaderBackgroundColor = "linear-gradient(135deg, #667eea 0%, #764ba2 100%)"
Config.NavigationBackgroundColor = "#667eea"
Config.CheckIconColor = "#667eea"
Config.SliderProgressColor = "#667eea"
```

### Changer les Polices par Défaut
```lua
Config.HeaderFont = "RageUI"  -- Police du header
Config.MenuFont = "RageUI"    -- Police du menu
```

### Modifier les Dimensions
```lua
Config.MenuWidth = "37vh"        -- Largeur du menu
Config.ItemHeight = "5vh"        -- Hauteur des items
Config.HeaderHeight = "12vh"     -- Hauteur du header
Config.CheckIconSize = "2.5vh"   -- Taille de l'icône check
```

## 📁 Structure des Fichiers

```
ragemenu/
├── config.lua              # Configuration principale (IMPORTANT!)
├── menu_base.lua           # Menu de base (exemple)
├── examples.lua            # Exemples de code
├── ragemenu.lua            # Core du menu
├── fxmanifest.lua          # Manifest FiveM
├── CONFIG_README.md        # Documentation config
├── FONTS_GUIDE.md          # Guide des polices
├── README_MENU.md          # Ce fichier
├── utils/
│   ├── keys.lua           # Gestion des touches
│   └── nui.lua            # Communication NUI
└── web/
    ├── dist/              # Build NUI (compilé)
    ├── src/               # Code source NUI
    └── public/
        └── fonts/         # Polices locales
            ├── RageUIText.otf
            └── SignPainterHouseScript.woff
```

## 🔧 Développement

### Modifier le NUI
Si vous voulez modifier le code source du NUI:

1. Installer les dépendances:
```bash
cd ragemenu/web
npm install
```

2. Modifier les fichiers dans `ragemenu/web/src/`

3. Compiler:
```bash
npm run build
```

### Ajouter une Nouvelle Police Locale
1. Ajouter le fichier `.otf` ou `.woff` dans `ragemenu/web/public/fonts/`
2. Ajouter la définition dans `ragemenu/web/src/css/index.scss`:
```scss
@font-face {
  font-family: 'MaPolice';
  font-style: normal;
  font-weight: normal;
  src: url('fonts/MaPolice.woff') format('woff');
}
```
3. Ajouter le nom dans `ragemenu/web/src/utils/configManager.ts`:
```typescript
const LOCAL_FONTS = ['RageUI', 'SignPainter', 'MaPolice'];
```
4. Recompiler avec `npm run build`

## 🐛 Dépannage

### Le menu ne s'ouvre pas
- Vérifiez que le NUI est compilé (`ragemenu/web/dist/` doit exister)
- Vérifiez la console F8 pour les erreurs
- Assurez-vous que la ressource est bien démarrée

### Les polices ne s'affichent pas
- Les polices locales (RageUI, SignPainter) sont chargées automatiquement
- Les Google Fonts nécessitent une connexion internet
- Vérifiez l'orthographe du nom de la police

### Les couleurs ne changent pas
- Utilisez `exports['ragemenu']:ResetMenuColors()` puis réappliquez votre thème
- Vérifiez que vous utilisez le bon format de couleur (#hex ou rgba())

## 📝 Exports Disponibles

```lua
-- Obtenir la configuration
local config = exports['ragemenu']:GetConfig()

-- Appliquer un thème
exports['ragemenu']:ApplyTheme('Default')

-- Changer une couleur
exports['ragemenu']:SetMenuColor('navigation', '#ff0000')

-- Changer la police
exports['ragemenu']:SetMenuFont('RageUI', 5)

-- Réinitialiser
exports['ragemenu']:ResetMenuColors()
```

## 🎯 Commandes Disponibles

| Commande | Description | Exemple |
|----------|-------------|---------|
| `/menu` | Ouvrir/fermer le menu | `/menu` |
| `/theme` | Changer le thème | `/theme Blue` |
| `/menutheme` | Changer le thème | `/menutheme Orange` |
| `/menucolor` | Changer une couleur | `/menucolor navigation #ff0000` |
| `/menufont` | Changer la police | `/menufont RageUI` |
| `/menureset` | Réinitialiser | `/menureset` |

## 📚 Exemples Complets

Consultez le fichier `examples.lua` pour 10 exemples d'utilisation:
1. Changer de thème
2. Personnaliser les couleurs
3. Menu avec thèmes intégrés
4. Menu admin avec couleurs
5. Menu de personnalisation de police
6. Garage avec voitures
7. Menu inventaire
8. Menu téléportation
9. Menu admin complet
10. Menu avec gradients personnalisés

## 💡 Conseils

- Utilisez les polices locales (RageUI, SignPainter) pour de meilleures performances
- Testez vos thèmes avec `/theme [nom]` avant de modifier le config
- Sauvegardez votre `config.lua` avant chaque modification
- Consultez `CONFIG_README.md` pour plus de détails sur les options

## 📞 Support

Pour plus d'informations, consultez:
- `CONFIG_README.md` - Documentation complète de la configuration
- `FONTS_GUIDE.md` - Guide détaillé des polices
- `examples.lua` - 10 exemples de code

## 🎉 Créé par
- **Auteur**: Ente Nico | Nopes
- **Version**: 1.0.0
- **Framework**: FiveM (GTA V)

---

**Bon développement ! 🚀**
