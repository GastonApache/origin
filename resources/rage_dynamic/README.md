# rage_dynamic_menu

Exemple minimal montrant un menu RageUI dynamique où l'on peut ajouter / supprimer des items à la volée.

Commandes
- /dynamicmenu : ouvre/ferme le menu
- /addbtn <label> : ajoute un bouton avec le label donné
- /clearitems : supprime tous les items dynamiques

Raccourci clavier
- F8 : ouvrir/fermer le menu

Description
- Le menu est défini dans `client.lua`. Les items sont stockés dans une table `items` et le rendu parcourt
  cette table à chaque frame pour afficher boutons/listes/séparateurs.
