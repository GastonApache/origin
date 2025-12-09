# 🎨 Liste de Couleurs (ListColor)

## Description
Le composant `ListColor` permet d'afficher une liste de couleurs sous forme de cercles colorés défilants, similaire au `UIListColor.lua` de RageUI. Les couleurs défilent avec les flèches gauche/droite et jusqu'à 5 cercles sont visibles simultanément.

## Syntaxe

```lua
menu:AddListColor(name, description, background, items, current)
```

### Paramètres

| Paramètre | Type | Obligatoire | Description |
|-----------|------|-------------|-------------|
| `name` | `string` | ✅ | Nom de l'élément affiché dans le menu |
| `description` | `string` | ❌ | Description affichée en bas du menu |
| `background` | `string` | ❌ | Couleur de fond personnalisée (format hex) |
| `items` | `table` | ✅ | Tableau de couleurs `{color = "#RGB", name = "Nom"}` |
| `current` | `number` | ❌ | Index de la couleur sélectionnée par défaut (défaut: 1) |

## Palettes de Couleurs Préconçues

Le fichier `gta_colors.lua` contient plusieurs palettes de couleurs GTA V/FiveM :

### `RageMenu.GTAColors.Vehicle` (68 couleurs)
Toutes les couleurs de véhicules de GTA V incluant :
- Noirs et Gris (8 couleurs)
- Blancs (2 couleurs)
- Rouges (5 couleurs)
- Roses (2 couleurs)
- Oranges (4 couleurs)
- Jaunes (3 couleurs)
- Verts (8 couleurs)
- Bleus (8 couleurs)
- Violets (4 couleurs)
- Marrons (5 couleurs)
- Métalliques spéciaux (4 couleurs)
- Mats (7 couleurs)
- Métalliques (3 couleurs)

### `RageMenu.GTAColors.Crew` (11 couleurs)
Couleurs personnalisables type "crew" :
- Rouge, Vert, Bleu, Jaune, Magenta, Cyan, Orange, Violet, Rose, Blanc, Noir

### `RageMenu.GTAColors.Basic` (16 couleurs)
Couleurs de base simplifiées :
- Noir, Blanc, Gris, Rouge, Vert, Bleu, Jaune, Magenta, Cyan, Orange, Violet, Rose, Marron, Vert Menthe, Rose Vif, Bleu Royal

### `RageMenu.GTAColors.Rainbow` (7 couleurs)
Palette arc-en-ciel :
- Rouge, Orange, Jaune, Vert, Bleu, Indigo, Violet

### `RageMenu.GTAColors.Neon` (7 couleurs)
Couleurs néon lumineuses :
- Rose Neon, Vert Neon, Bleu Neon, Jaune Neon, Violet Neon, Orange Neon, Blanc Neon

## Exemples d'Utilisation

### Exemple 1 : Changeur de couleur de véhicule

```lua
local couleurIndex = 1
menu:AddListColor('Couleur Véhicule', 'Changer la couleur principale', nil, RageMenu.GTAColors.Vehicle, couleurIndex):On('change', function(updatedItem)
    local selection = getListSelection(updatedItem, couleurIndex)
    couleurIndex = selection
    
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        local colorData = RageMenu.GTAColors.Vehicle[selection]
        if colorData then
            -- Convertir hex en RGB
            local hex = colorData.color:gsub("#", "")
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            
            SetVehicleCustomPrimaryColour(vehicle, r, g, b)
            print('Couleur: ' .. colorData.name)
        end
    end
end)
```

### Exemple 2 : Sélection de couleur arc-en-ciel

```lua
local rainbowIndex = 1
menu:AddListColor('Couleur Arc-en-ciel', 'Choisir une couleur', nil, RageMenu.GTAColors.Rainbow, rainbowIndex):On('change', function(updatedItem)
    local selection = getListSelection(updatedItem, rainbowIndex)
    rainbowIndex = selection
    
    local colorData = RageMenu.GTAColors.Rainbow[selection]
    print('Sélectionné: ' .. colorData.name .. ' (' .. colorData.color .. ')')
end)
```

### Exemple 3 : Palette personnalisée

```lua
local mesCouleursPerso = {
    {color = "#FF1493", name = "Rose Vif"},
    {color = "#00CED1", name = "Turquoise"},
    {color = "#FFD700", name = "Or"},
    {color = "#8A2BE2", name = "Bleu Violet"},
    {color = "#32CD32", name = "Vert Citron"},
}

local customIndex = 1
menu:AddListColor('Ma Palette', 'Couleurs personnalisées', nil, mesCouleursPerso, customIndex):On('change', function(updatedItem)
    local selection = getListSelection(updatedItem, customIndex)
    customIndex = selection
    local colorData = mesCouleursPerso[selection]
    print('Couleur: ' .. colorData.name)
end)
```

### Exemple 4 : Couleur Neon pour véhicule

```lua
local neonIndex = 1
menu:AddListColor('Neon Véhicule', 'Changer la couleur du néon', nil, RageMenu.GTAColors.Neon, neonIndex):On('change', function(updatedItem)
    local selection = getListSelection(updatedItem, neonIndex)
    neonIndex = selection
    
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= 0 then
        local colorData = RageMenu.GTAColors.Neon[selection]
        if colorData then
            local hex = colorData.color:gsub("#", "")
            local r = tonumber(hex:sub(1,2), 16)
            local g = tonumber(hex:sub(3,4), 16)
            local b = tonumber(hex:sub(5,6), 16)
            
            SetVehicleNeonLightsColour(vehicle, r, g, b)
            SetVehicleNeonLightEnabled(vehicle, 0, true)
            SetVehicleNeonLightEnabled(vehicle, 1, true)
            SetVehicleNeonLightEnabled(vehicle, 2, true)
            SetVehicleNeonLightEnabled(vehicle, 3, true)
        end
    end
end)
```

## Événement `On('change')`

Déclenché lorsque l'utilisateur change de couleur avec les flèches gauche/droite.

```lua
item:On('change', function(updatedItem)
    -- updatedItem.other.current contient l'index actuel (base 0)
    -- Utilisez getListSelection(updatedItem, fallback) pour obtenir l'index base 1
end)
```

## Événement `On('click')`

Déclenché lorsque l'utilisateur appuie sur Entrée sur l'élément.

```lua
item:On('click', function(updatedItem)
    -- Action lors de la validation
end)
```

## Apparence Visuelle

- **Cercles colorés** : Affichage de 5 cercles maximum simultanément
- **Cercle sélectionné** : Plus grand (28px) avec bordure blanche épaisse et effet glow
- **Cercles non-sélectionnés** : Plus petits (24px) avec bordure semi-transparente
- **Navigation fluide** : Transition CSS de 0.2s pour un effet smooth
- **Centrage automatique** : Le cercle sélectionné est toujours centré si possible

## Helper Function

Fonction utilitaire pour lire la sélection actuelle :

```lua
local function getListSelection(item, fallback)
    if item and item.other and type(item.other.current) == 'number' then
        return item.other.current + 1  -- Convertit de base 0 à base 1
    end
    return fallback or 1
end
```

## Conversion Hex → RGB

Fonction pour convertir les couleurs hex en RGB pour GTA V natives :

```lua
local function hexToRGB(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1,2), 16)
    local g = tonumber(hex:sub(3,4), 16)
    local b = tonumber(hex:sub(5,6), 16)
    return r, g, b
end

-- Utilisation
local colorData = RageMenu.GTAColors.Vehicle[index]
local r, g, b = hexToRGB(colorData.color)
SetVehicleCustomPrimaryColour(vehicle, r, g, b)
```

## Notes Importantes

1. **Format de couleur** : Toujours utiliser le format `#RRGGBB` (6 caractères hex)
2. **Index** : Les indices Lua commencent à 1, mais le composant NUI utilise base 0 en interne
3. **Performance** : Le composant est optimisé et n'affiche que 5 cercles visibles
4. **Responsive** : Le cercle sélectionné reste toujours visible et centré

## Fichiers Concernés

- `ragemenu/ragemenu.lua` - Fonction `menu:AddListColor()`
- `ragemenu/gta_colors.lua` - Palettes de couleurs préconçues
- `ragemenu/web/src/components/items/ListColor.tsx` - Composant React
- `ragemenu/web/src/types.d.ts` - Type TypeScript `'listcolor'`

---

**Créé pour RageMenu NUI** 🎨
Inspiré de `UIListColor.lua` de RageUI
