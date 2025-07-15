Berikut adalah isi langsung dari file `README.md` yang bisa kamu salin dan simpan:

---

###  `README.md`

```markdown
#  Nginx Proxy Manager - Docker Compose

Proyek ini menggunakan Docker Compose untuk menjalankan Nginx Proxy Manager, sebuah tool berbasis web untuk mengelola reverse proxy dengan mudah.

---

##  Fitur

- UI Web untuk mengatur reverse proxy
- Dukungan SSL otomatis dari Let's Encrypt
- Redirect, forward proxy, dan stream
- Manajemen domain dan subdomain dengan mudah

---

##  Struktur Folder

```

nginx-proxy-manager/
├── docker-compose.yml
├── data/
└── letsencrypt/

````

---

##  Cara Instalasi

### 1. Buat folder proyek

```bash
mkdir nginx-proxy-manager
cd nginx-proxy-manager
````

### 2. Buat file `docker-compose.yml` dan isi dengan:

```yaml
version: '3.8'

services:
  nginx-proxy-manager:
    image: 'jc21/nginx-proxy-manager:latest'
    container_name: nginx-proxy-manager
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    environment:
      DB_SQLITE_FILE: "/data/database.sqlite"
      DISABLE_IPV6: 'true'
    volumes:
      - ./data:/data
      - ./letsencrypt:/etc/letsencrypt
```

### 3. Buat folder volume

```bash
mkdir data letsencrypt
```

### 4. Jalankan container

```bash
docker-compose up -d
```

---

##  Akses Web UI

* Buka browser ke: `http://<IP-Server>:81`
* Login awal:

  * Email: `admin@example.com`
  * Password: `changeme`

Setelah login, ubah kredensial default demi keamanan.

---

##  Perintah Tambahan

* Hentikan:

  ```bash
  docker-compose down
  ```

* Mulai ulang:

  ```bash
  docker-compose restart
  ```

* Lihat log:

  ```bash
  docker-compose logs -f
  ```

---

##  Catatan Tambahan

* Pastikan port 80 dan 443 tidak digunakan layanan lain.
* Arahkan DNS domain kamu ke IP publik server ini.
* SSL Let's Encrypt akan aktif otomatis jika domain valid.

---

##  Lisensi

Menggunakan image resmi dari [jc21/nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager).

```

---

Silakan simpan dengan nama `README.md` di dalam folder proyek kamu. Mau versi full Bahasa Indonesia juga bisa kalau dibutuhkan.
```

