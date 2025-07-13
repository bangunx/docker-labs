Berikut **cheatsheet Docker Compose** ringkas dan praktis untuk kamu yang ingin cepat mengingat perintah dan format penting:

---

#  **Docker Compose Cheatsheet**

##  Struktur Dasar `docker-compose.yml`

```yaml
version: "3.8"  # atau 3, 3.9, dsb

services:
  nama_service:
    image: nama_image:tag
    container_name: nama_container
    ports:
      - "HOST_PORT:CONTAINER_PORT"
    volumes:
      - /path/host:/path/container
    environment:
      - VAR1=value1
      - VAR2=value2
    depends_on:
      - service_lain
    restart: unless-stopped  # atau always / on-failure
    networks:
      - jaringan_kustom

networks:
  jaringan_kustom:
    driver: bridge
```

---

## ⚙️ **Perintah Umum Docker Compose**

| Perintah                                | Fungsi                                     |
| --------------------------------------- | ------------------------------------------ |
| `docker-compose up`                     | Jalankan semua service                     |
| `docker-compose up -d`                  | Jalankan di background (detached)          |
| `docker-compose down`                   | Hentikan dan hapus container + jaringan    |
| `docker-compose stop`                   | Hentikan service                           |
| `docker-compose start`                  | Menyalakan kembali service yang dihentikan |
| `docker-compose restart`                | Restart semua service                      |
| `docker-compose ps`                     | Lihat status container                     |
| `docker-compose logs`                   | Lihat log semua service                    |
| `docker-compose logs -f`                | Log live (ikuti output)                    |
| `docker-compose exec nama_service bash` | Masuk ke dalam container                   |
| `docker-compose build`                  | Build ulang image custom                   |
| `docker-compose pull`                   | Tarik image dari Docker Hub                |
| `docker-compose config`                 | Validasi dan tampilkan config              |

---

##  Contoh Volume dan Environment

```yaml
volumes:
  - ./data:/app/data
  - /etc/localtime:/etc/localtime:ro

environment:
  - MYSQL_ROOT_PASSWORD=root
  - MYSQL_DATABASE=app
```

---

##  Policy Restart

| Policy           | Penjelasan                             |
| ---------------- | -------------------------------------- |
| `no`             | Tidak pernah restart                   |
| `always`         | Selalu restart container jika berhenti |
| `unless-stopped` | Restart kecuali dihentikan manual      |
| `on-failure`     | Restart hanya jika exit code bukan 0   |

---

##  Jaringan Custom (Opsional)

```yaml
networks:
  my_network:
    driver: bridge
```

---

##  Tips

* Gunakan `.env` file untuk menyimpan environment variable.
* Jalankan `docker-compose -f file_lain.yml up` untuk file berbeda.
* Bisa gabungkan beberapa file dengan `-f file1.yml -f file2.yml`.

---

Jika kamu ingin saya buatkan template Compose untuk aplikasi tertentu (MySQL, Nginx, Laravel, WordPress, dst.), tinggal bilang saja!



Berikut adalah **Docker Compose Cheatsheet** yang **telah diurutkan berdasarkan prioritas dan frekuensi penggunaan di dunia nyata**, mulai dari yang paling sering dipakai hingga yang lebih spesifik:

---

#  **Top Cheatsheet Docker Compose (Paling Sering Digunakan)**

## 1.  `docker-compose up -d`

**Jalankan semua service di background**

```bash
docker-compose up -d
```

## 2.  `docker-compose down`

**Hentikan dan hapus container, jaringan, dan volume anonim**

```bash
docker-compose down
```

## 3.  `docker-compose ps`

**Lihat daftar container yang sedang berjalan**

```bash
docker-compose ps
```

## 4.  `docker-compose restart`

**Restart semua container dalam file Compose**

```bash
docker-compose restart
```

## 5.  `docker-compose exec <service> bash`

**Masuk ke dalam container**

```bash
docker-compose exec app bash
```

## 6.  `docker-compose logs -f`

**Lihat log secara live dari semua service**

```bash
docker-compose logs -f
```

---

#  **Cheatsheet Penting (Menengah - Sering Tapi Tidak Harian)**

## 7.  `docker-compose build`

**Build ulang image dari Dockerfile**

```bash
docker-compose build
```

## 8.  `docker-compose pull`

**Tarik image terbaru dari Docker Registry**

```bash
docker-compose pull
```

## 9.  `docker-compose stop`

**Stop sementara container (tanpa menghapus)**

```bash
docker-compose stop
```

## 10.  `docker-compose start`

**Start ulang container yang sudah distop**

```bash
docker-compose start
```

## 11.  `docker-compose config`

**Validasi dan tampilkan file YAML yang digabung final**

```bash
docker-compose config
```

---

#  **Struktur YAML Dasar (Wajib Tahu)**

```yaml
version: "3.8"
services:
  app:
    image: nginx:latest
    ports:
      - "8080:80"
    volumes:
      - ./html:/usr/share/nginx/html
    environment:
      - TZ=Asia/Jakarta
    restart: unless-stopped
```

---

#  **Opsional tapi Berguna**

| Fungsi             | YAML                                                    |
| ------------------ | ------------------------------------------------------- |
| **Network custom** | `networks:` dan `driver: bridge`                        |
| **Depends on**     | `depends_on:`                                           |
| **.env support**   | Buat `.env` → otomatis dipakai oleh Compose             |
| **Multiple file**  | `docker-compose -f base.yml -f override.yml up`         |
| **Mount waktu**    | `- /etc/localtime:/etc/localtime:ro` (agar jam sinkron) |

---

#  Tips Tambahan

* `.env` bisa menyimpan port, credentials, dsb.
* Gunakan `docker compose` (tanpa dash) untuk versi baru CLI (`v2+`).
* Buat alias:

  ```bash
  alias dcu="docker-compose up -d"
  alias dcd="docker-compose down"
  alias dcl="docker-compose logs -f"
  ```

---

Kalau kamu mau, saya juga bisa buatin versi **printable PDF atau markdown**. Atau versi bahasa Indonesia lebih teknis/logat santai. Mau?


