Sip, jadi kamu menyimpan semua file File Browser (database, config, dan lain-lain) di direktori:

```
~/homelabs/docker-labs/filebrowser
```

Berarti kita bisa pastikan hak akses dan struktur folder-nya beres supaya File Browser bisa berjalan tanpa error dan menampilkan password admin.

---

## ✅ LANGKAH PERBAIKAN LENGKAP

###  1. Perbaiki Struktur Folder dan Akses

Jalankan perintah berikut:

```bash
# Buat folder jika belum ada
mkdir -p ~/homelabs/docker-labs/filebrowser/{config,database,data}

# Ubah owner-nya ke UID 1000 (user default container filebrowser)
sudo chown -R 1000:1000 ~/homelabs/docker-labs/filebrowser

# Pastikan permission cukup
sudo chmod -R 755 ~/homelabs/docker-labs/filebrowser
```

---

### ️ 2. Perbarui `docker-compose.yml` (lebih aman & rapi)

Berikut versi yang **aman dan lebih bersih**, gunakan ini:

```yaml
version: '3.8'

services:
  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    ports:
      - "8282:80"  # Akses di http://localhost:8282
    volumes:
      - ~/homelabs/docker-labs/filebrowser/data:/srv
      - ~/homelabs/docker-labs/filebrowser/database:/database
      - ~/homelabs/docker-labs/filebrowser/config:/config
    restart: unless-stopped
```

> ❗ Jangan pakai `- ~/:/srv` karena itu memberi akses ke seluruh home directory. Lebih baik hanya direktori `data` saja.

---

###  3. Jalankan Ulang Container

```bash
cd ~/homelabs/docker-labs/filebrowser
docker compose down -v
docker compose up -d
```

---

###  4. Cek Password Admin

```bash
docker logs filebrowser
```

Cari baris seperti:

```
Generated default admin credentials:
Username: admin
Password: Abc123Xyz
```

---

### ✅ Akses File Browser

Buka di browser:

```
http://localhost:8282
```

Login:

* **Username:** `admin`
* **Password:** (yang muncul di log tadi)

---

Kalau kamu mau, saya juga bisa bantu sekalian integrasi HTTPS atau reverse proxy pakai Nginx Proxy Manager atau Caddy. Mau lanjut?


Berikut ini adalah **script lengkap setup File Browser** menggunakan Docker Compose dengan direktori kamu di `~/homelabs/docker-labs/filebrowser`. Script ini:

* Membuat struktur folder
* Mengatur permission
* Membuat file `docker-compose.yml`
* Menjalankan container

---

## ✅ 1. **Script Shell Setup (Linux/macOS)**

Simpan sebagai `setup-filebrowser.sh`, atau langsung copy dan jalankan di terminal:

```bash
#!/bin/bash

echo " Membuat struktur direktori..."
mkdir -p ~/homelabs/docker-labs/filebrowser/{config,database,data}

echo " Mengatur permission..."
sudo chown -R 1000:1000 ~/homelabs/docker-labs/filebrowser
sudo chmod -R 755 ~/homelabs/docker-labs/filebrowser

echo " Membuat file docker-compose.yml..."
cat <<EOF > ~/homelabs/docker-labs/filebrowser/docker-compose.yml
version: '3.8'

services:
  filebrowser:
    image: filebrowser/filebrowser:latest
    container_name: filebrowser
    ports:
      - "8282:80"
    volumes:
      - ./data:/srv
      - ./database:/database
      - ./config:/config
    restart: unless-stopped
EOF

echo " Menjalankan File Browser..."
cd ~/homelabs/docker-labs/filebrowser
docker compose down -v
docker compose up -d

echo "✅ Selesai! Tunggu beberapa detik lalu jalankan:"
echo "   docker logs filebrowser"
echo "Untuk melihat password admin awal."
echo "Akses di: http://localhost:8282"
```

### Cara pakai:

```bash
chmod +x setup-filebrowser.sh
./setup-filebrowser.sh
```

---

##  Setelah Berjalan

Lanjutkan dengan:

```bash
docker logs filebrowser
```

Lihat baris seperti:

```
Generated default admin credentials:
Username: admin
Password: aBcd123XyZ
```

Kemudian buka browser ke:

```
http://localhost:8282
```

---

Kalau ingin File Browser bisa diakses via HTTPS + domain (pakai Nginx Proxy Manager atau Cloudflare Tunnel), tinggal bilang aja, saya bantu lanjutkan.

