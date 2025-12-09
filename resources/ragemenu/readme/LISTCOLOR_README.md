# 🎨 ListColor - Composant de Liste Colorée

## 📋 Résumé

Le composant `ListColor` a été ajouté au RageMenu NUI ! Il permet d'afficher des listes de couleurs sous forme de **cercles colorés défilants** 🟠, similaire au `UIListColor.lua` de RageUI.

## ✨ Fonctionnalités

- ✅ **Cercles colorés défilants** : Navigation gauche/droite avec jusqu'à 5 cercles visibles
- ✅ **Effet visuel moderne** : Le cercle sélectionné est plus grand avec bordure blanche et glow
- ✅ **Palettes GTA V incluses** : 
  - `Vehicle` (68 couleurs)
  - `Neon` (7 couleurs)
  - `Rainbow` (7 couleurs)
  - `Basic` (16 couleurs)
  - `Crew` (11 couleurs)
- ✅ **Transition fluide** : Animation CSS smooth
- ✅ **Centrage automatique** : L'élément sélectionné reste toujours visible

## 📦 Fichiers Créés/Modifiés

### Nouveaux Fichiers
1. **`ragemenu/gta_colors.lua`** - Palettes de couleurs GTA V/FiveM
2. **`ragemenu/web/src/components/items/ListColor.tsx`** - Composant React
3. **`ragemenu/LISTCOLOR_DOCUMENTATION.md`** - Documentation complète
4. **`menu_nui/example_listcolor.lua`** - Exemple d'utilisation complet (F8)

### Fichiers Modifiés
1. **`ragemenu/ragemenu.lua`** - Ajout de la fonction `menu:AddListColor()`
2. **`ragemenu/fxmanifest.lua`** - Ajout de `gta_colors.lua`
3. **`ragemenu/web/src/types.d.ts`** - Ajout du type `'listcolor'`
4. **`ragemenu/web/src/components/items/MenuItem.tsx`** - Enregistrement du composant
5. **`menu_nui/menu_base.lua`** - Ajout d'exemples dans menu Véhicule et Admin
6. **`menu_nui/fxmanifest.lua`** - Référence à `example_listcolor.lua`

## 🚀 Utilisation Rapide

### Syntaxe de Base

```lua
menu:AddListColor(name, description, background, items, current)
```

### Exemple Simple

```lua
local couleurIndex = 1
menu:AddListColor('Couleur Véhicule', 'Changer la couleur', nil, RageMenu.GTAColors.Vehicle, couleurIndex):On('change', function(updatedItem)
    local selection = getListSelection(updatedItem, couleurIndex)
    couleurIndex = selection
    
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        local colorData = RageMenu.GTAColors.Vehicle[selection]
        local hex = colorData.color:gsub("#", "")
        local r = tonumber(hex:sub(1,2), 16)
        local g = tonumber(hex:sub(3,4), 16)
        local b = tonumber(hex:sub(5,6), 16)
        
        SetVehicleCustomPrimaryColour(vehicle, r, g, b)
        print('Couleur: ' .. colorData.name)
    end
end)
```

## 🎯 Exemples Intégrés

### Dans `menu_base.lua` (/menu)
- **Menu Véhicule** : `AddListColor` pour changer la couleur du véhicule avec palette Vehicle (68 couleurs)
- **Menu Admin** : `AddListColor` avec palette Rainbow pour tester

### Fichier dédié `example_listcolor.lua` (F8 ou /listcolor)
Exemple complet avec :
- Couleur primaire véhicule
- Couleur secondaire véhicule
- Couleur néon + activation
- Test des 5 palettes (Vehicle, Neon, Rainbow, Basic, Crew)
- Actions de réinitialisation et info

**Pour activer** : Décommentez `example_listcolor.lua` dans `menu_nui/fxmanifest.lua`

## 📚 Palettes Disponibles

### RageMenu.GTAColors.Vehicle (68 couleurs)
Toutes les couleurs de véhicules GTA V organisées par catégorie :
- Noirs/Gris, Blancs, Rouges, Roses, Oranges, Jaunes
- Verts, Bleus, Violets, Marrons
- Métalliques spéciaux (Chrome, Aluminium, Acier)
- Mats (Noir mat, Gris mat, etc.)

### RageMenu.GTAColors.Neon (7 couleurs)
Couleurs lumineuses pour effets néon :
- Rose Neon, Vert Neon, Bleu Neon, Jaune Neon, Violet Neon, Orange Neon, Blanc Neon

### RageMenu.GTAColors.Rainbow (7 couleurs)
Arc-en-ciel classique :
- Rouge, Orange, Jaune, Vert, Bleu, Indigo, Violet

### RageMenu.GTAColors.Basic (16 couleurs)
Couleurs de base simplifiées pour usages généraux

### RageMenu.GTAColors.Crew (11 couleurs)
Couleurs type "crew" personnalisables

## 🔧 Structure des Couleurs

Chaque couleur est un objet avec :
```lua
{
    color = "#RRGGBB",  -- Format hex
    name = "Nom"        -- Nom français
}
```

## 🛠️ Fonction Helper

Pour lire la sélection actuelle :

```lua
local function getListSelection(item, fallback)
    if item and item.other and type(item.other.current) == 'number' then
        return item.other.current + 1  -- Convertit base 0 → base 1
    end
    return fallback or 1
end
```

## 🎨 Apparence Visuelle

```
Label                    🟠🟠🔵🟠🟠
                           ↑
                      Sélectionné
                    (28px, bordure)
```

- **5 cercles max** affichés simultanément
- **Cercle sélectionné** : 28px, bordure blanche 3px, effet glow
- **Cercles normaux** : 24px, bordure semi-transparente 2px
- **Transition** : 0.2s ease pour animation fluide

## 📖 Documentation Complète

Consultez `ragemenu/LISTCOLOR_DOCUMENTATION.md` pour :
- Exemples détaillés (4 cas d'usage)
- Fonction de conversion hex → RGB
- Tous les événements disponibles
- Notes importantes sur les indices

## 🧪 Test

### Option 1 : Menu de base (/menu)
1. Ouvrez le menu avec `/menu`
2. Allez dans **Véhicule**
3. Utilisez "Couleur Véhicule" avec les flèches ← →
4. Ou allez dans **Admin** pour tester la palette Rainbow

### Option 2 : Exemple dédié (F8)
1. Décommentez `example_listcolor.lua` dans `menu_nui/fxmanifest.lua`
2. Restart les resources : `restart ragemenu ; ensure menu_nui`
3. Appuyez sur **F8** ou tapez `/listcolor`
4. Testez toutes les palettes et fonctionnalités

## 🔄 Compilation

Le NUI a déjà été compilé avec le composant :
```
dist/js/index-b6f16fbc.js  (158.18 KB)
```

Si vous modifiez le composant TypeScript :
```bash
cd ragemenu/web
npm run build
```

## 📋 Checklist

- ✅ Composant React `ListColor.tsx` créé
- ✅ Type `'listcolor'` ajouté
- ✅ Fonction Lua `menu:AddListColor()` créée
- ✅ Palettes GTA V (`gta_colors.lua`) créées
- ✅ Exemples intégrés dans `menu_base.lua`
- ✅ Exemple dédié `example_listcolor.lua` créé
- ✅ Documentation complète rédigée
- ✅ NUI compilé avec succès
- ✅ Check icon sur tous les boutons (modification précédente)

## 🎉 Résultat Final

Vous avez maintenant un système complet de liste colorée :
- 🟠 Navigation visuelle avec cercles colorés
- 🎨 5 palettes de couleurs GTA V prêtes à l'emploi
- 📝 Documentation complète
- 🧪 Exemples fonctionnels
- ✨ Interface moderne et fluide

**Profitez bien de votre nouveau composant ListColor !** 🎨✨

---

**Note** : Pour toute personnalisation, consultez `LISTCOLOR_DOCUMENTATION.md` pour des exemples avancés et la création de palettes personnalisées.
