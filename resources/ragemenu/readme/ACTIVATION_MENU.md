# 🚀 ACTIVATION DU MENU DE BASE

## 📋 Le menu de base est prêt mais pas activé par défaut

Pour activer le menu de base, suivez ces étapes:

## ✅ Étape 1: Ouvrir fxmanifest.lua

Fichier: `ragemenu/fxmanifest.lua`

## ✅ Étape 2: Décommenter la ligne

Trouvez cette section:
```lua
client_scripts {
  'config.lua',
  'utils/keys.lua',
  'utils/nui.lua',
  'ragemenu.lua',
  -- 'menu_base.lua', -- Décommentez pour activer le menu de base
}
```

**AVANT** (menu désactivé):
```lua
  -- 'menu_base.lua', -- Décommentez pour activer le menu de base
```

**APRÈS** (menu activé):
```lua
  'menu_base.lua', -- Menu de base activé
```

## ✅ Étape 3: Sauvegarder le fichier

Enregistrez `fxmanifest.lua` avec **Ctrl+S**

## ✅ Étape 4: Redémarrer la ressource

Dans la console F8 de votre serveur:
```
restart ragemenu
```

Ou redémarrez complètement votre serveur.

## 🎮 Utilisation

### Ouvrir le menu:
- **Touche U** - Ouvrir/fermer le menu
- **Backspace** - Fermer le menu
- `/menu` - Commande alternative

### Commandes disponibles:
```
/menu          - Ouvrir/fermer le menu
/theme [nom]   - Changer de thème rapidement

Exemples:
/theme Default
/theme Orange
/theme Blue
```

## 📚 Contenu du Menu de Base

### 1. 👤 Menu Joueur
- 📋 Afficher mes informations
- 🛡️ Mode God (invincibilité)
- 👻 Invisible
- ❤️ Soigner
- 🏃 Redonner Stamina

### 2. 🚗 Menu Véhicule
- 🚗 Spawn Véhicule (Adder par défaut)
- 🔧 Réparer Véhicule
- ⛽ Remplir Essence
- 🏎️ Modifier Vitesse Max (slider)
- ❌ Supprimer Véhicule

### 3. ⚙️ Menu Admin
- 🌙 Changer Heure
- ☁️ Météo (12 options)
- 📍 Téléportation Waypoint

### 4. 🎨 Menu Thèmes
- 9 thèmes disponibles
- 🔄 Réinitialiser les couleurs

## ⚠️ Important

**Le menu de base est un EXEMPLE**. Vous pouvez:
- Le modifier selon vos besoins
- Le désactiver en recommentant la ligne
- Créer votre propre menu en vous inspirant de celui-ci
- Voir `examples.lua` pour plus d'exemples de code

## 🔧 Si le menu ne fonctionne pas

1. **Vérifiez la console F8** pour les erreurs
2. **Assurez-vous** que la ligne est bien décommentée
3. **Redémarrez** la ressource avec `restart ragemenu`
4. **Vérifiez** que le NUI est compilé (`web/dist/` existe)

## 📖 Documentation

Pour créer votre propre menu, consultez:
- `README_MENU.md` - Guide complet
- `examples.lua` - 10 exemples de code
- `CONFIG_README.md` - Options de configuration

## 💡 Conseil

Si vous voulez **désactiver** le menu de base plus tard, recommentez simplement la ligne:
```lua
  -- 'menu_base.lua', -- Menu désactivé
```

Et redémarrez la ressource.

---

**C'est tout! Le menu devrait maintenant s'ouvrir avec la touche U. 🎉**
