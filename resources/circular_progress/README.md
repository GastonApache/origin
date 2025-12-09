# Circular Progress NUI (FiveM)

Resource qui affiche un cercle de progression NUI (similaire au Codesandbox CircularProgress) avec options configurables via `config.lua` ou dynamiquement via `SendNUIMessage`.

Structure attendue :
- circular_progress/
  - fxmanifest.lua
  - config.lua
  - client.lua
  - html/
    - index.html
    - style.css
    - script.js
    - fonts/ (optionnel: mettez vos .ttf/.woff ici)

Installation :
1. Placez le dossier `circular_progress` dans `resources/[local]/` ou autre dossier de ressources.
2. Démarrez la ressource dans server.cfg : start circular_progress

Options (config.lua) :
- color: couleur de l'arc (ex: '#ff0000')
- bgColor: couleur de l'anneau d'arrière-plan (ex: 'rgba(0,0,0,0.3)')
- textColor: couleur du pourcentage
- right/top/left/bottom: positionnement (ex: '40px' ou 40)
- width/height: taille du conteneur (ex: '200px' ou 200)
- showPercent: boolean, afficher le pourcentage
- zIndex: z-index CSS du container
- fontFile: (optionnel) chemin relatif vers le fichier de police placé dans html/fonts/ (ex: 'fonts/MyFont.ttf')
- fontFamily: nom de la famille (ou 'CustomNuiFont' si tu utilises fontFile)
- fontWeight: 'normal' | 'bold' | '700' etc.
- fontSizeScale: multiplicateur pour la taille du texte par rapport au radius (ex: 0.8)
- lineWidthScale: épaisseur de l'anneau (fraction du radius)
- autoStartOnResource: si true démarre l'auto-incrémentation à la join

Utilisation en jeu (chat/console) :
- /cprogress start       -> affiche et démarre l’auto (+10 toutes les 800ms)
- /cprogress stop        -> arrête l’auto et masque
- /cprogress set <0-100> -> fixe la valeur et affiche
- /cprogress show        -> affiche (garde la valeur actuelle)
- /cprogress hide        -> masque
- /cprogress duration <seconds> [hide] -> anime la progression 0→100 sur <seconds>. Ajoute 'hide' pour masquer à la fin.

Exports (pour appeler depuis d'autres ressources) :
- exports['circular_progress']:SetProgress(value)
- exports['circular_progress']:Show()
- exports['circular_progress']:Hide()
- exports['circular_progress']:StartAuto()
- exports['circular_progress']:StopAuto()
- exports['circular_progress']:StartProgressDuration(seconds, hideOnComplete)
- exports['circular_progress']:StopProgressDuration()

Exemples d'utilisation dynamique (client.lua d'une autre ressource) :
SendNUIMessage({
  type = 'config',
  config = {
    color = '#ff0000',
    bgColor = 'rgba(0,0,0,0.3)',
    textColor = '#fff',
    right = '10px',
    top = '40px',
    width = '150px',
    height = '150px',
    fontFile = 'fonts/MyFont.ttf', -- si tu as ajouté la police dans html/fonts/
    fontFamily = 'MyFont',         -- nom que tu veux utiliser (recommandé si tu passes fontFile)
    fontWeight = '700',
    fontSizeScale = 0.9,
    lineWidthScale = 0.22,
    showPercent = true,
    zIndex = 6000
  }
});

-- Start a duration progress of 7 seconds and hide when done:
exports['circular_progress']:StartProgressDuration(7, true)

Notes :
- Si tu utilises `fontFile`, mets le fichier dans `html/fonts/` et liste `html/fonts/*` est déjà inclus dans `fxmanifest.lua`.
- Pour changer les valeurs par défaut, modifie `config.lua` et redémarre la ressource.
- Le NUI (html) applique dynamiquement la police si `fontFile` est fourni : le script injecte une règle @font-face.

Si tu veux que je pack un exemple avec une police libre (ex: Inter.ttf) dans html/fonts/, dis-moi quelle police et je l'ajoute dans l'archive (ou je te fournis le fichier prêt à coller).