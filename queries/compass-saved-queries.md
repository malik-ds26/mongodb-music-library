# 📋 Requêtes MongoDB – Projet Gestion Musique

**Base de données :** `gestion_musique`  
**Collections :** `utilisateurs`, `artistes`, `albums`, `chansons`, `playlists`

---

## 0) Création de la base et des collections
```js
use gestion_musique
db.createCollection("utilisateurs")
db.createCollection("artistes")
db.createCollection("albums")
db.createCollection("chansons")
db.createCollection("playlists")
1) Chercher une chanson (lecture fréquente, < 1s)
db.chansons.find({ titre: "Chanson A" })

2) Rechercher une chanson dans une playlist d’un utilisateur
db.utilisateurs.aggregate([
  { $unwind: "$playlists" },
  { $unwind: "$playlists.chansons" },
  { $match: { "playlists.chansons.titre": "Chanson A" } },
  { $project: { "playlists.nom_playlist": 1, "playlists.chansons": 1 } }
])

3) Rechercher une chanson en filtrant par nom d’artiste
db.chansons.find({
  titre: "Chanson A",
  "artiste.nom": "Artiste X"
})

4) Un utilisateur crée une playlist (écriture critique < 1s)
db.utilisateurs.updateOne(
  { _id: "user001" },
  {
    $push: {
      playlists: {
        id_playlist: "pl002",
        nom_playlist: "Nouvelle Playlist",
        date_creation: new Date(),
        type: "Privée",
        chansons: []
      }
    }
  }
)

5) Un artiste ajoute plusieurs albums (écriture non critique < 100 ms)
db.artistes.updateOne(
  { _id: "artiste001" },
  {
    $push: {
      albums: {
        $each: [
          {
            id_album: "album002",
            nom_album: "Nouvel Album",
            date_sortie: "2024-05-15",
            nombre_chansons: 10,
            duree_totale: "38:20"
          },
          {
            id_album: "album003",
            nom_album: "Encore un autre album",
            date_sortie: "2024-08-10",
            nombre_chansons: 12,
            duree_totale: "50:15"
          }
        ]
      }
    }
  }
)

6) Voir les albums/chansons d’un artiste
db.artistes.find(
  { _id: "artiste001" },
  { nom: 1, albums: 1, "albums.nom_album": 1, "albums.nombre_chansons": 1 }
)

7) Inscription d’un utilisateur (écriture critique < 1s)
db.utilisateurs.insertOne({
  _id: "user007",
  nom: "Dupont",
  prenom: "Jean",
  mot_de_passe: "securePass789",
  date_inscription: new Date(),
  abonnement: {
    type: "Premium",
    date_expiration: new Date("2024-12-31")
  },
  playlists: [
    { nom: "Favoris", chansons: ["song001", "song002", "song003"] },
    { nom: "Relaxation", chansons: ["song010", "song011"] }
  ]
})

8) Inscription d’un artiste
db.artistes.insertOne({
  _id: "artiste004",
  nom: "Artiste Y",
  genre_musical: "Rock",
  nationalite: "Anglaise",
  nombre_auditeurs: 30000,
  albums: []
})

9) Un artiste ajoute une chanson
db.chansons.insertOne({
  _id: "song004",
  titre: "Nouvelle Chanson",
  duree: "04:15",
  date_sortie: "2024-03-01",
  genre: "Rock",
  popularite: { nb_vues: 0, nb_lectures: 0 },
  album: {
    id_album: "album002",
    nom_album: "Nouvel Album",
    date_sortie: "2024-05-15"
  },
  artiste: {
    id_artiste: "artiste002",
    nom: "Artiste Y",
    genre_musical: "Rock",
    nationalite: "Anglaise"
  }
})