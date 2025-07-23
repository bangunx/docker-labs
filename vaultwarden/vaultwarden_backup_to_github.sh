#!/bin/bash

# Konfigurasi path
BASE_DIR="$HOME/homelabs/docker-labs/vaultwarden"
DATA_DIR="$BASE_DIR/vw-data"
BACKUP_DIR="$BASE_DIR/vw-backups"
REPO_DIR="$BASE_DIR/vaultwarden-backup"
GPG_RECIPIENT="bangundwir@gmail.com"   # Ganti sesuai email GPG kamu
TIMESTAMP=$(date "+%Y%m%d-%H%M")
ZIP_FILE="$BACKUP_DIR/vw-${TIMESTAMP}.zip"
ENC_FILE="${ZIP_FILE}.gpg"

# Siapkan folder backup jika belum ada
mkdir -p "$BACKUP_DIR"
mkdir -p "$REPO_DIR"

echo "[⏳] Menghentikan Vaultwarden..."
docker compose -f "$BASE_DIR/docker-compose.yml" stop vaultwarden

echo "[] Membuat backup zip..."
zip -r9 "$ZIP_FILE" "$DATA_DIR"

echo "[▶️] Menyalakan Vaultwarden kembali..."
docker compose -f "$BASE_DIR/docker-compose.yml" start vaultwarden

echo "[] Mengenkripsi dengan GPG..."
gpg --yes --output "$ENC_FILE" --encrypt --recipient "$GPG_RECIPIENT" "$ZIP_FILE"

rm -f "$ZIP_FILE"

echo "[⬆️] Push ke GitHub..."
cp "$ENC_FILE" "$REPO_DIR/"
cd "$REPO_DIR"

git pull origin main
git add "$(basename "$ENC_FILE")"
git commit -m "Backup Vaultwarden - $TIMESTAMP"
git push origin main

echo "[✅] Backup selesai: $(basename "$ENC_FILE")"

