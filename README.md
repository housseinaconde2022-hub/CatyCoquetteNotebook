# ✨ Caty Coquette Notebook 🐱

Une application de carnet numérique **ultra mignonne** style **coquette** pour Android 🎀

Inspirée des images My Melody, Campus pink, stickers pixel, kaomoji et organisateur de notes.

## Fonctionnalités

- 🎨 **Design Coquette** : palette rose blush, cream, ivory, lace vibes, bows & soft pastels
- 📕 **Cahiers personnalisables** : change les couvertures (couleurs, motifs, personnages)
- 📝 **Pages** : lignées, quadrillées, dotted, free, templates planner
- 🤖 **Bot Caty** : petite IA intégrée qui corrige automatiquement les fautes d'écriture (français & anglais)
- 🌸 Stickers pixel art & kaomoji
- 📱 Optimisé pour téléphone Android
- 💾 Stockage local (Hive)

## Palette Coquette

| Couleur       | Hex       |
|---------------|-----------|
| Baby Pink     | #FADADD   |
| Blush Pink    | #F7C6CE   |
| Cream         | #FFF8E8   |
| Ivory         | #FFFFF0   |
| Dusty Rose    | #D4A5A5   |
| Rose Gold     | #E8B4B8   |

## Comment lancer

1. Installe Flutter : https://flutter.dev
2. Clone le repo :
```bash
git clone https://github.com/housseinaconde2022-hub/CatyCoquetteNotebook.git
cd CatyCoquetteNotebook
```
3. Récupère les dépendances :
```bash
flutter pub get
```
4. Lance sur Android :
```bash
flutter run
```

## Structure du projet

```
lib/
├─ main.dart
├─ theme/
│   └─ coquette_theme.dart
├─ models/
│   ├─ notebook.dart
│   └─ page.dart
├─ screens/
│   ├─ home_screen.dart          # Grille des cahiers (comme l'image Documents)
│   ├─ notebook_screen.dart      # Ouverture d'un cahier
│   ├─ page_editor.dart          # Éditeur de page + Caty
│   └─ cover_picker.dart         # Changer la couverture
├─ widgets/
│   ├─ caty_bot.dart             # Le petit bot flottant
│   ├─ notebook_cover.dart
│   └─ sticker_picker.dart
└─ services/
    ├─ storage_service.dart
    └─ caty_ai_service.dart       # Correction orthographe (placeholder + API ready)
```

## Caty le bot 🐱

Caty apparaît en bas à droite comme un petit chat mignon.  
Quand tu écris, tu peux lui demander de corriger le texte.  
Actuellement en mode **local simple** + prêt pour brancher une vraie API (OpenAI / xAI Grok / Gemini).

## Prochaines améliorations possibles

- Vraie intégration API IA
- Stickers animés
- Export PDF joli
- Sync cloud optionnel
- Plus de templates (monthly planner, etc.)

Fait avec ♥️ et beaucoup de rose par Grok pour toi  
Amuse-toi bien ✨
