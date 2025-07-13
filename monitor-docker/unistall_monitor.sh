#!/bin/bash

# === Konfigurasi ===
APP_DIR="/home/hades/homelabs/monitor-docker"

echo " Menghentikan & menghapus container Docker Compose dari: $APP_DIR"

# === Masuk ke direktori project ===
cd "$APP_DIR" || {
  echo "❌ Gagal: Direktori $APP_DIR tidak ditemukan!"
  exit 1
}

# === Hentikan dan hapus container, network, dan volume ===
docker compose down -v --remove-orphans

# === Hapus image terkait monitoring (opsional) ===
echo " Menghapus image terkait (optional)"
docker image rm \
  prom/prometheus \
  grafana/grafana \
  gcr.io/cadvisor/cadvisor \
  prom/node-exporter \
  --force || true

# === Bersihkan sisa volume/network yang tidak terpakai ===
echo " Membersihkan sisa Docker yang tidak digunakan..."
docker system prune -a --volumes -f

echo "✅ Uninstall selesai. Folder $APP_DIR tetap disimpan."
