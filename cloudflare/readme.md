1. Simpan file di folder project sebagai `docker-compose.yml`
2. Jalankan:

```bash
docker compose up -d
```

###  Jika ingin stop:

```bash
docker compose down
```

### ️ Tambahan (opsional logging):

Jika ingin menyimpan log ke file atau membaca log:

```bash
docker logs -f cloudflared
```
---


```
```
#env
```bash
CLOUDFLARED_TOKEN=
```

Jika kamu butuh bind mount ke file konfig (`config.yml`) atau ingin mengatur tunnelnya lebih lanjut (misalnya routing hostname atau service lokal), tinggal bilang — saya bantu lengkapkan.

