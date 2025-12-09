-- Couleurs GTA V/FiveM
-- Basé sur les couleurs natives de GTA V pour les véhicules et autres éléments
-- Utilisation : RageMenu.GTAColors pour accéder aux tables de couleurs

RageMenu.GTAColors = {}

-- Couleurs principales des véhicules (Vehicle Colors)
RageMenu.GTAColors.Vehicle = {
    -- Noirs et Gris
    {color = "#0d1116", name = "Noir"},
    {color = "#1c1d21", name = "Noir Carbone"},
    {color = "#32383d", name = "Noir Graphite"},
    {color = "#454b4f", name = "Gris Anthracite"},
    {color = "#999da0", name = "Gris"},
    {color = "#c2c4c6", name = "Gris Clair"},
    {color = "#979a97", name = "Gris Pierre"},
    {color = "#637380", name = "Gris Ardoise"},
    
    -- Blancs
    {color = "#f1f1f1", name = "Blanc Glace"},
    {color = "#fffff6", name = "Blanc"},
    
    -- Rouges
    {color = "#a51e23", name = "Rouge"},
    {color = "#7a1e2c", name = "Rouge Bordeaux"},
    {color = "#b6111b", name = "Rouge Candy"},
    {color = "#da1918", name = "Rouge Lever de Soleil"},
    {color = "#c00e1a", name = "Rouge Cardinal"},
    
    -- Roses
    {color = "#f78199", name = "Rose"},
    {color = "#d30f47", name = "Rose Foncé"},
    
    -- Oranges
    {color = "#f27d20", name = "Orange"},
    {color = "#f8b658", name = "Orange Clair"},
    {color = "#e89e4e", name = "Orange Pêche"},
    {color = "#ffc848", name = "Jaune Orange"},
    
    -- Jaunes
    {color = "#fef06f", name = "Jaune"},
    {color = "#ffcf20", name = "Jaune Course"},
    {color = "#fddd0f", name = "Jaune Citron"},
    
    -- Verts
    {color = "#2d5016", name = "Vert Foncé"},
    {color = "#5f9918", name = "Vert Course"},
    {color = "#9caf4f", name = "Vert Olive"},
    {color = "#9bb471", name = "Vert Citron"},
    {color = "#74b5d8", name = "Vert Eau"},
    {color = "#00594f", name = "Vert Mer"},
    {color = "#9faa97", name = "Vert Sauge"},
    
    -- Bleus
    {color = "#132428", name = "Bleu Nuit"},
    {color = "#17375e", name = "Bleu Minuit"},
    {color = "#2354a1", name = "Bleu Galaxie"},
    {color = "#0082cd", name = "Bleu"},
    {color = "#5eb5e2", name = "Bleu Clair"},
    {color = "#3b7dc9", name = "Bleu Marine"},
    {color = "#5a9bc4", name = "Bleu Mer"},
    {color = "#4271e1", name = "Bleu Électrique"},
    
    -- Violets
    {color = "#702b87", name = "Violet"},
    {color = "#6f1b8a", name = "Violet Foncé"},
    {color = "#7f288c", name = "Violet Brillant"},
    {color = "#b0abaa", name = "Mauve"},
    
    -- Marrons
    {color = "#705949", name = "Marron"},
    {color = "#5c352e", name = "Marron Foncé"},
    {color = "#a57257", name = "Marron Sable"},
    {color = "#c7814b", name = "Marron Beige"},
    {color = "#dcb499", name = "Beige"},
    
    -- Métalliques Spéciaux
    {color = "#8c9095", name = "Acier Brossé"},
    {color = "#a0a199", name = "Acier Noir Brossé"},
    {color = "#b7bfcc", name = "Aluminium"},
    {color = "#ced1d3", name = "Chrome"},
    
    -- Mats
    {color = "#15171a", name = "Noir Mat"},
    {color = "#37383b", name = "Gris Mat"},
    {color = "#a0a199", name = "Gris Clair Mat"},
    {color = "#d3d3d3", name = "Blanc Glace Mat"},
    {color = "#b78144", name = "Sable Mat"},
    {color = "#853e28", name = "Marron Mat"},
    {color = "#000000", name = "Noir Profond Mat"},
    
    -- Métalliques
    {color = "#b7a264", name = "Or"},
    {color = "#dfd2ae", name = "Or Pur"},
    {color = "#8e8c81", name = "Champagne"},
}

-- Couleurs Crew (Couleurs personnalisables)
RageMenu.GTAColors.Crew = {
    {color = "#ff0000", name = "Rouge"},
    {color = "#00ff00", name = "Vert"},
    {color = "#0000ff", name = "Bleu"},
    {color = "#ffff00", name = "Jaune"},
    {color = "#ff00ff", name = "Magenta"},
    {color = "#00ffff", name = "Cyan"},
    {color = "#ffa500", name = "Orange"},
    {color = "#800080", name = "Violet"},
    {color = "#ffc0cb", name = "Rose"},
    {color = "#ffffff", name = "Blanc"},
    {color = "#000000", name = "Noir"},
}

-- Couleurs de base simplifiées
RageMenu.GTAColors.Basic = {
    {color = "#000000", name = "Noir"},
    {color = "#ffffff", name = "Blanc"},
    {color = "#808080", name = "Gris"},
    {color = "#ff0000", name = "Rouge"},
    {color = "#00ff00", name = "Vert"},
    {color = "#0000ff", name = "Bleu"},
    {color = "#ffff00", name = "Jaune"},
    {color = "#ff00ff", name = "Magenta"},
    {color = "#00ffff", name = "Cyan"},
    {color = "#ffa500", name = "Orange"},
    {color = "#800080", name = "Violet"},
    {color = "#ffc0cb", name = "Rose"},
    {color = "#8b4513", name = "Marron"},
    {color = "#00fa9a", name = "Vert Menthe"},
    {color = "#ff69b4", name = "Rose Vif"},
    {color = "#4169e1", name = "Bleu Royal"},
}

-- Palette Rainbow (Arc-en-ciel)
RageMenu.GTAColors.Rainbow = {
    {color = "#ff0000", name = "Rouge"},
    {color = "#ff7f00", name = "Orange"},
    {color = "#ffff00", name = "Jaune"},
    {color = "#00ff00", name = "Vert"},
    {color = "#0000ff", name = "Bleu"},
    {color = "#4b0082", name = "Indigo"},
    {color = "#9400d3", name = "Violet"},
}

-- Couleurs Neon (pour effets lumineux)
RageMenu.GTAColors.Neon = {
    {color = "#ff1493", name = "Rose Neon"},
    {color = "#00ff00", name = "Vert Neon"},
    {color = "#00ffff", name = "Bleu Neon"},
    {color = "#ffff00", name = "Jaune Neon"},
    {color = "#ff00ff", name = "Violet Neon"},
    {color = "#ff4500", name = "Orange Neon"},
    {color = "#ffffff", name = "Blanc Neon"},
}

-- Couleurs de cheveux GTA V (Hair Colors) - 64 couleurs
RageMenu.GTAColors.Hair = {
    {color = "#1c1f21", name = "0 - Noir"},
    {color = "#272a2c", name = "1 - Noir Foncé"},
    {color = "#312e2c", name = "2 - Gris Très Foncé"},
    {color = "#35261c", name = "3 - Brun Foncé"},
    {color = "#4b321f", name = "4 - Brun"},
    {color = "#5c3b24", name = "5 - Brun Moyen"},
    {color = "#6d4c35", name = "6 - Châtain Foncé"},
    {color = "#6b503b", name = "7 - Châtain"},
    {color = "#765c45", name = "8 - Châtain Clair"},
    {color = "#7f684e", name = "9 - Blond Foncé"},
    {color = "#99815d", name = "10 - Blond"},
    {color = "#a79369", name = "11 - Blond Clair"},
    {color = "#af9c70", name = "12 - Blond Doré"},
    {color = "#bba063", name = "13 - Blond Sable"},
    {color = "#d6b97b", name = "14 - Blond Miel"},
    {color = "#dac38e", name = "15 - Blond Platine"},
    {color = "#9f7f59", name = "16 - Brun Cendré"},
    {color = "#845039", name = "17 - Auburn"},
    {color = "#682b1f", name = "18 - Roux Foncé"},
    {color = "#61120c", name = "19 - Roux Vif"},
    {color = "#640f0a", name = "20 - Roux"},
    {color = "#7c140f", name = "21 - Rouge Foncé"},
    {color = "#a02e19", name = "22 - Rouge"},
    {color = "#b64b28", name = "23 - Cuivré"},
    {color = "#a2502f", name = "24 - Cuivre Clair"},
    {color = "#aa4e2b", name = "25 - Acajou"},
    {color = "#626262", name = "26 - Gris"},
    {color = "#808080", name = "27 - Gris Moyen"},
    {color = "#aaaaaa", name = "28 - Gris Clair"},
    {color = "#c5c5c5", name = "29 - Gris Argenté"},
    {color = "#463955", name = "30 - Violet Foncé"},
    {color = "#5a3f6b", name = "31 - Violet"},
    {color = "#763c76", name = "32 - Prune"},
    {color = "#ed74e3", name = "33 - Rose Vif"},
    {color = "#eb4b93", name = "34 - Rose"},
    {color = "#f299bc", name = "35 - Rose Clair"},
    {color = "#04959e", name = "36 - Cyan"},
    {color = "#025f86", name = "37 - Bleu Pétrole"},
    {color = "#023974", name = "38 - Bleu Marine"},
    {color = "#3fa16a", name = "39 - Vert Émeraude"},
    {color = "#217c61", name = "40 - Vert Marin"},
    {color = "#185c55", name = "41 - Vert Canard"},
    {color = "#b6c034", name = "42 - Vert Lime"},
    {color = "#70a90b", name = "43 - Vert Pomme"},
    {color = "#439d13", name = "44 - Vert Vif"},
    {color = "#dcb857", name = "45 - Jaune Doré"},
    {color = "#e5b103", name = "46 - Jaune"},
    {color = "#e69102", name = "47 - Jaune Orangé"},
    {color = "#f28831", name = "48 - Orange"},
    {color = "#fb8057", name = "49 - Orange Clair"},
    {color = "#e28b58", name = "50 - Pêche"},
    {color = "#d1593c", name = "51 - Orange Rouge"},
    {color = "#ce3120", name = "52 - Rouge Vif"},
    {color = "#ad0903", name = "53 - Rouge Cerise"},
    {color = "#880302", name = "54 - Rouge Bordeaux"},
    {color = "#1f1814", name = "55 - Brun Ébène"},
    {color = "#291f19", name = "56 - Brun Très Foncé 2"},
    {color = "#2e221b", name = "57 - Brun Foncé 2"},
    {color = "#37291e", name = "58 - Brun 2"},
    {color = "#2e2218", name = "59 - Brun Chocolat"},
    {color = "#231b15", name = "60 - Brun Terre"},
    {color = "#020202", name = "61 - Noir Pur"},
    {color = "#706c66", name = "62 - Gris Taupe"},
    {color = "#9d7a50", name = "63 - Sable"},
}

-- Couleurs de maquillage GTA V (Makeup Colors) - 64 couleurs
RageMenu.GTAColors.Makeup = {
    {color = "#992532", name = "0 - Rouge Profond"},
    {color = "#c8395d", name = "1 - Rose Foncé"},
    {color = "#bd516c", name = "2 - Framboise"},
    {color = "#b8637a", name = "3 - Rose Poudré"},
    {color = "#a6526b", name = "4 - Mauve Rose"},
    {color = "#b1434c", name = "5 - Rouge Cerise"},
    {color = "#7f3133", name = "6 - Bordeaux"},
    {color = "#a4645d", name = "7 - Terre Cuite"},
    {color = "#c18779", name = "8 - Corail"},
    {color = "#cba096", name = "9 - Beige Rosé"},
    {color = "#c6918f", name = "10 - Vieux Rose"},
    {color = "#ab6f63", name = "11 - Saumon"},
    {color = "#b06050", name = "12 - Brique"},
    {color = "#a84c33", name = "13 - Rouge Brun"},
    {color = "#b47178", name = "14 - Rose Tendre"},
    {color = "#ca7f92", name = "15 - Rose Corail"},
    {color = "#ed9cbe", name = "16 - Rose Bonbon"},
    {color = "#e775a4", name = "17 - Fuchsia"},
    {color = "#de3e81", name = "18 - Rose Vif"},
    {color = "#b34c6e", name = "19 - Magenta"},
    {color = "#712739", name = "20 - Prune Foncé"},
    {color = "#4f1f2a", name = "21 - Aubergine"},
    {color = "#aa222f", name = "22 - Rouge Vif"},
    {color = "#de2034", name = "23 - Rouge Passion"},
    {color = "#cf0813", name = "24 - Rouge Écarlate"},
    {color = "#e55470", name = "25 - Rose Dragée"},
    {color = "#dc3fb5", name = "26 - Rose Électrique"},
    {color = "#c227b2", name = "27 - Magenta Vif"},
    {color = "#a01ca9", name = "28 - Violet Vif"},
    {color = "#6e1875", name = "29 - Violet Profond"},
    {color = "#731465", name = "30 - Pourpre"},
    {color = "#56165c", name = "31 - Violet Foncé"},
    {color = "#6d1a9d", name = "32 - Violet Électrique"},
    {color = "#1b3771", name = "33 - Bleu Marine"},
    {color = "#1d4ea7", name = "34 - Bleu"},
    {color = "#1e74bb", name = "35 - Bleu Ciel"},
    {color = "#21a3ce", name = "36 - Bleu Turquoise"},
    {color = "#25c2d2", name = "37 - Cyan"},
    {color = "#23cca5", name = "38 - Turquoise"},
    {color = "#27c07d", name = "39 - Vert d'Eau"},
    {color = "#1b9c32", name = "40 - Vert"},
    {color = "#148604", name = "41 - Vert Foncé"},
    {color = "#70d041", name = "42 - Vert Pomme"},
    {color = "#c5ea34", name = "43 - Vert Lime"},
    {color = "#e1e32f", name = "44 - Jaune Citron"},
    {color = "#ffdd26", name = "45 - Jaune"},
    {color = "#fac026", name = "46 - Jaune Doré"},
    {color = "#f78a27", name = "47 - Orange Doré"},
    {color = "#fe5910", name = "48 - Orange Vif"},
    {color = "#be6e19", name = "49 - Bronze"},
    {color = "#f7c97f", name = "50 - Pêche Clair"},
    {color = "#fbe5c0", name = "51 - Beige Clair"},
    {color = "#f5f5f5", name = "52 - Blanc"},
    {color = "#b3b4b3", name = "53 - Gris Clair"},
    {color = "#919191", name = "54 - Gris"},
    {color = "#564e4e", name = "55 - Gris Foncé"},
    {color = "#180e0e", name = "56 - Noir"},
    {color = "#58969e", name = "57 - Bleu Gris"},
    {color = "#4d6f8c", name = "58 - Bleu Ardoise"},
    {color = "#1a2b55", name = "59 - Bleu Nuit"},
    {color = "#a07e6b", name = "60 - Beige"},
    {color = "#826355", name = "61 - Marron Clair"},
    {color = "#6d5346", name = "62 - Marron"},
    {color = "#3e2d27", name = "63 - Marron Foncé"},
}

return RageMenu.GTAColors
