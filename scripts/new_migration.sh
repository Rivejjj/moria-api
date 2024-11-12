#!/bin/bash

# Crea una nueva migracion con el timestamp actual y el nombre pasado por parametro
nombre_migration="$1"

timestamp=$(date +"%Y%m%d%H%M%S")

archivo="./db/migrations/${timestamp}_${nombre_migration}.rb"

touch "$archivo"

echo "Archivo creado: $archivo"