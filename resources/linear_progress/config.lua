-- config.lua : configuration par défaut pour le Linear Progress NUI
-- Modifie ces valeurs pour changer la couleur, position, police, etc.

LinearProgressConfig = {
  -- Couleurs
  barColor     = '#1976d2',                -- couleur de la partie remplie
  bgColor      = 'rgba(200,200,200,0.4)',  -- couleur de l'arrière-plan de la barre
  textColor    = '#222',                   -- couleur du pourcentage

  -- Position & taille (peut être '40px' ou un nombre)
  right        = '50px',
  --top          = '40px',
  --left         = nil,
  bottom       = '40px',
  width        = '300px',
  height       = '18px',   -- hauteur de la barre

  -- Apparence
  borderRadius = '10px',   -- arrondi des coins
  showPercent  = true,     -- afficher le pourcentage à droite
  percentSpacing = '8px',  -- espace entre la barre et le texte
  zIndex       = 5000,

  -- Police / texte
  fontFile     = nil,      -- si tu veux une police custom, place le fichier dans html/fonts/, ex: 'fonts/MyFont.ttf'
  fontFamily   = 'sans-serif',
  fontWeight   = '500',
  fontSizeScale = 1.2,     -- multiplicateur sur la hauteur pour taille de texte

  -- Auto behavior
  autoStartOnResource = false -- si true démarre auto-increment au spawn
}