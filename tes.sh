#!/bin/bash
# ==========================================================
#  Sistem Backup Otomatis
#  Dibuat oleh: Ramdan
#  Deskripsi  : Script untuk mencari file tertentu, kemudian
#               membuat backup terkompresi dengan timestamp.
# ==========================================================

# -----------------------------
# 1. Konfigurasi Variabel
# -----------------------------
data="/home/ramdan/penting/data"                   # Folder sumber file
backup="/home/ramdan/penting/backup"               # Folder hasil backup
log="/home/ramdann/penting/backup/backup.log"      # File log
ext="*.txt"                                        # Ekstensi file yang dicari
d=1                                                # Modifikasi dalam 1 hari terakhir

# -----------------------------
# 2. Membuat Nama Backup
# -----------------------------
time=$(date +"%Y-%m-%d_%H-%M-%S")
kompres="backup_$time.tar.gz"

# -----------------------------
# 3. Cek Apakah Ada File Sesuai Kriteria
# -----------------------------
if ! find "$data" -mtime -$d -name "$ext" | grep -q . ; then
    echo "[$(date)] GAGAL: Tidak ada file yang sesuai kriteria." >> "$log"
    echo "Backup gagal: Tidak ada file ditemukan."
    exit 1
fi

# -----------------------------
# 4. Kompres File Langsung
# -----------------------------
find "$data" -mtime -$d -name "$ext" | tar -czf "$kompres" -T -

# -----------------------------
# 5. Pindahkan Backup ke Folder Tujuan
# -----------------------------
mkdir -p "$backup"
mv "$kompres" "$backup/"

# -----------------------------
# 6. Catat Log Aktivitas
# -----------------------------
echo "[$(date)] BERHASIL: Backup tersimpan sebagai $backup/$kompres" >> "$log"

# -----------------------------
# 7. Notifikasi Terminal
# -----------------------------
echo "Backup berhasil!"
echo "File backup  : $kompres"
echo "Lokasi simpan : $backup"

exit 0
