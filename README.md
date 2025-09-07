# 🎵 MongoDB Music Library (Compass)

Projet de gestion de musique avec import de données JSON et requêtes prêtes à l’emploi pour **MongoDB Compass**.

## 📚 Collections
- `utilisateurs`, `artistes`, `albums`, `chansons`, `playlists` (selon le modèle du projet)

## 🚀 Démarrage rapide
1) Importer les JSON :
- Windows (PowerShell) : `./scripts/import.ps1`
- macOS/Linux : `bash scripts/import.sh`

2) Ouvrir **MongoDB Compass** → se connecter à `mongodb://localhost:27017` → base `gestion_musique`.

3) (Optionnel) Créer des index utiles :
```js
db.chansons.createIndex({ titre: "text" });
db.artistes.createIndex({ nom: "text" });
db.utilisateurs.createIndex({ "playlists.nom_playlist": 1 });
## 🔎 Requêtes MongoDB

Toutes les requêtes d’exemple (création de collections, recherches, insertions, mises à jour) sont disponibles dans :  

➡️ [`queries/compass-saved-queries.md`](queries/compass-saved-queries.md)  

Elles peuvent être copiées-collées directement dans **MongoDB Compass** ou le shell MongoDB pour tester le projet.

