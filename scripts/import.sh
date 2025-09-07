#!/usr/bin/env bash
DB="gestion_musique"

mongoimport --db "$DB" --collection utilisateurs --file data/json/utilisateurs.json --jsonArray
mongoimport --db "$DB" --collection artistes     --file data/json/artistes.json     --jsonArray
mongoimport --db "$DB" --collection chansons     --file data/json/chansons.json     --jsonArray
