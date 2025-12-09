-- config.lua : configuration par défaut pour le Circular Progress NUI
-- Modifie ces valeurs pour changer la couleur, position, police, etc.

ProgressConfig = {
  -- Couleurs
  color       = '#1976d2',                -- couleur de l'arc de progression
  bgColor     = 'rgba(200,200,200,0.6)',  -- couleur de l'anneau d'arrière-plan
  textColor   = '#222',                   -- couleur du texte du pourcentage

  -- Position & taille (tu peux utiliser '40px' ou un nombre en pixels (ex: 40))
  right       = '40px',   -- si défini, place à droite
  --top         = '40px',   -- si défini, place en haut
  --left        = '40px',      -- si défini, place à gauche (remplace right)
  bottom      = '40px',      -- si défini, place en bas (remplace top)
  width       = '200px',  -- largeur du conteneur
  height      = '200px',  -- hauteur du conteneur

  -- Affichage
  showPercent     = true,    -- afficher le pourcentage au centre
  zIndex          = 5000,    -- z-index du container NUI

  -- Police / style du texte
  fontFamily      = 'Teko-Regular', -- police (n'importe quelle police système ou importée dans html)
  fontWeight      = 'bold',     -- 'normal', 'bold', etc.
  fontSizeScale   = 0.8,          -- taille du texte multipliée par le radius (valeur par défaut 0.8)

  -- Apparence de l'anneau
  lineWidthScale  = 0.10,   -- épaisseur de l'anneau (fraction du radius)

  -- Options avancées
  autoStartOnResource = false -- si true, démarre l'auto-incrément dès le spawn (équivalent /cprogress start)
}