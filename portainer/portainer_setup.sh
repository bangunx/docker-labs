#!/bin/bash

set -e

echo "===================================="
echo "     PORTAINER DEPLOY SCRIPT"
echo "===================================="
echo ""
echo "Pilih mode Portainer:"
echo "1) HTTPS (Port 9443 + 8000)"
echo "2) HTTP (Port 9000)"
echo "3) Keluar"
read -p "Masukkan pilihan [1-3]: " choice

generate_https() {
  cat <<EOF >docker-compose.yml
version: '3.8'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: always
    ports:
      - "8000:8000"
      - "9443:9443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

volumes:
  portainer_data:
EOF
}

generate_http() {
  cat <<EOF >docker-compose.yml
version: '3.8'

services:
  portainer:
    image: portainer/portainer-ce:latest
    container_name: portainer
    restart: always
    ports:
      - "9000:9000"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

volumes:
  portainer_data:
EOF
}

case "$choice" in
1)
  echo " Membuat file docker-compose untuk HTTPS..."
  generate_https
  ;;
2)
  echo " Membuat file docker-compose untuk HTTP..."
  generate_http
  ;;
3)
  echo " Keluar."
  exit 0
  ;;
*)
  echo "❌ Pilihan tidak valid."
  exit 1
  ;;
esac

echo ""
echo " Menjalankan Portainer dengan Docker Compose..."
docker compose up -d

echo ""
echo "✅ Portainer berhasil dijalankan!"
if [ "$choice" = "1" ]; then
  echo " Akses via: https://localhost:9443"
  echo "⚠️ Abaikan warning SSL self-signed."
else
  echo " Akses via: http://localhost:9000"
fi
