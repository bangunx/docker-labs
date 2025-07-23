#!/bin/bash

# === Konfigurasi ===
BASE_DIR="$HOME/homelabs/docker-labs/vaultwarden"
DATA_DIR="$BASE_DIR/vw-data"
REPO_DIR="$BASE_DIR/vaultwarden-backup"
RESTORE_DIR="$BASE_DIR/restore-tmp"
DOCKER_COMPOSE="$BASE_DIR/docker-compose.yml"
BRANCH="main"  # Ubah ke 'master' jika remote pakai master

# === Masukkan passphrase GPG ===
echo -n " Masukkan GPG passphrase: "
read -rs GPG_PASSPHRASE
echo

# === Pilih File Backup ===
cd "$REPO_DIR" || exit 1
echo "[⬇️] Menarik backup terbaru dari GitHub..."
git pull origin $BRANCH

echo "[] Daftar file backup tersedia:"
select FILE in vw-*.zip.gpg; do
  if [[ -n "$FILE" ]]; then
    echo "[] Kamu memilih: $FILE"
    break
  fi
done

# === Dekripsi ===
mkdir -p "$RESTORE_DIR"
cd "$RESTORE_DIR" || exit 1

echo "[] Mendekripsi backup dengan GPG..."
gpg --batch --yes --passphrase "$GPG_PASSPHRASE" \
    --pinentry-mode loopback \
    --output restored.zip \
    --decrypt "$REPO_DIR/$FILE" || { echo "[❌] Gagal dekripsi!"; exit 1; }

echo "[] Mengekstrak backup..."
unzip -o restored.zip >/dev/null || { echo "[❌] Gagal unzip!"; exit 1; }

# === Stop Vaultwarden ===
echo "[] Menghentikan container Vaultwarden..."
docker compose -f "$DOCKER_COMPOSE" stop vaultwarden

echo "[♻️] Menghapus data lama..."
rm -rf "$DATA_DIR"
mkdir -p "$DATA_DIR"
cp -r "$RESTORE_DIR/vw-data/"* "$DATA_DIR/"

# === Start Vaultwarden ===
echo "[] Menyalakan kembali Vaultwarden..."
docker compose -f "$DOCKER_COMPOSE" start vaultwarden

# === Cleanup ===
rm -rf "$RESTORE_DIR"

echo "[✅] Restore berhasil dari $FILE"

