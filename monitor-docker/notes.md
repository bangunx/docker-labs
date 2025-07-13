| Komponen   | Alamat Web                                                             | Status yang Diharapkan |
| ---------- | ---------------------------------------------------------------------- | ---------------------- |
| cAdvisor   | [http://192.168.31.28:7100](http://192.168.31.28:7100)                 | UI aktif               |
| Prometheus | [http://192.168.31.28:7101/targets](http://192.168.31.28:7101/targets) | Semua target UP        |
| Grafana    | [http://192.168.31.28:7102](http://192.168.31.28:7102)                 | Login berhasil         |


Untuk **uninstall / menghapus seluruh layanan yang berjalan lewat Docker Compose**, kamu cukup menjalankan beberapa perintah sederhana.

Berikut langkah-langkahnya:

---

##  1. **Stop & Hapus Container**

Masuk ke direktori tempat file `docker-compose.yml` kamu berada, lalu jalankan:

```bash
docker compose down
```

Ini akan:

*  **Menghentikan** semua container
* ❌ **Menghapus** container (tapi tidak menghapus image atau volume)

---

##  2. (Opsional) **Hapus Volumes & Jaringan Sekaligus**

Jika kamu ingin menghapus semua volume data (seperti data login Grafana, data Prometheus):

```bash
docker compose down -v --remove-orphans
```

> ⚠️ Perhatian: ini akan **menghapus semua data** seperti dashboard Grafana, konfigurasi, dan metrik Prometheus!

---

## ️ 3. (Opsional) **Hapus Folder & File Docker Compose**

Jika kamu tidak ingin menyimpan konfigurasinya:

```bash
rm -rf /home/hades/homelabs/monitor-docker
```

---

##  4. (Opsional) **Hapus Docker Images (untuk hemat space)**

Kalau kamu juga ingin menghapus image:

```bash
docker image rm prom/prometheus grafana/grafana gcr.io/cadvisor/cadvisor prom/node-exporter
```

---

Kalau kamu ingin membersihkan semuanya (container, image, volume, network), kamu bisa pakai ini:

```bash
docker system prune -a --volumes
```

> ⚠️ Gunakan hati-hati! Ini akan menghapus semua yang tidak digunakan di Docker (seluruh sistem).

---

Kalau kamu mau reinstall atau migrasi ke server lain, saya bisa bantu backup dan setup ulang juga.

