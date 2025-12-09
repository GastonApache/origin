# Linear Progress NUI (FiveM)

Resource qui affiche une barre de progression linéaire NUI (avec label %) et options configurables via `config.lua` ou dynamiquement via `SendNUIMessage`.

Structure attendue :
- linear_progress/
  - fxmanifest.lua
  - config.lua
  - client.lua
  - html/
    - index.html
    - style.css
    - script.js
    - fonts/ (optionnel: place tes .ttf/.woff ici)

Installation :
1. Place le dossier `linear_progress` dans `resources/[local]/`.
2. Dans server.cfg : start linear_progress

Options principales (config.lua ou SendNUIMessage type='config'):
- barColor: couleur de la partie remplie (ex: '#ff0000')
- bgColor: couleur du fond de la barre (ex: 'rgba(0,0,0,0.2)')
- textColor: couleur du pourcentage
- right/top/left/bottom: position (ex: '40px' ou 40)
- width/height: taille de la barre (ex: '300px', '18px')
- borderRadius: arrondi coins (ex: '8px')
- percentSpacing: espace entre barre et texte
- showPercent: boolean
- zIndex: z-index CSS
- fontFile: (optionnel) chemin relatif vers police dans html/fonts/
- fontFamily: nom de la famille (utilisé si fontFile)
- fontWeight: ex: '500'
- fontSizeScale: multiplicateur appliqué à la hauteur pour la taille du texte

Commandes en jeu :
- /lprogress start       -> affiche et démarre l’auto (+10 toutes les 800ms)
- /lprogress stop        -> arrête l’auto et masque
- /lprogress set <0-100> -> fixe la valeur et affiche
- /lprogress show        -> affiche (garde la valeur actuelle)
- /lprogress hide        -> masque
- /lprogress duration <seconds> [hide] -> anime la progression 0→100 sur <seconds>. Ajoute 'hide' pour masquer à la fin.

Exports :
- exports['linear_progress']:SetProgress(value)
- exports['linear_progress']:Show()
- exports['linear_progress']:Hide()
- exports['linear_progress']:StartAuto()
- exports['linear_progress']:StopAuto()
- exports['linear_progress']:StartProgressDuration(seconds, hideOnComplete)
- exports['linear_progress']:StopProgressDuration()

Exemples dynamiques :
SendNUIMessage({
  type = 'config',
  config = {
    barColor = '#00ff00',
    bgColor = 'rgba(0,0,0,0.3)',
    textColor = '#fff',
    right = '10px',
    top = '50px',
    width = '240px',
    height = '20px',
    fontFile = 'fonts/BankGothic.ttf',
    fontFamily = 'BankGothic',
    fontWeight = '600',
    fontSizeScale = 1.0,
    borderRadius = '12px',
    percentSpacing = '10px',
    showPercent = true,
    zIndex = 6000
  }
});

-- Démarrer une progression de 7s et masquer à la fin
exports['linear_progress']:StartProgressDuration(7, true)

Notes :
- Si tu utilises `fontFile`, mets le fichier dans `html/fonts/` et assure-toi que fxmanifest inclut 'html/fonts/*' (déjà fait).
- Après modification de config.lua, relance la ressource.
- Si la police custom ne s'affiche pas, vérifie le nom du fichier et le champ fontFamily dans la config.