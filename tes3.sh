#!/bin/bash

# ===============================
#  Sistem Backup Otomatis
#  Project 2 - Pemrograman Shell
# ===============================

# --- Konfigurasi ---
src="/home/ramdan/data"        # Folder sumber yang akan dicari
dest="/home/ramdan/backup"     # Folder tempat backup disimpan
log="$dest/backup.log"         # File log aktivitas backup
ext="*.txt"                    # Ekstensi file yang ingin dibackup
days=-7                        # File yang dimodifikasi 7 hari terakhir
time=$(date +"%Y%m%d_%H%M%S")  # Timestamp unik
temp="$dest/backup_$time"      # Folder sementara untuk backup

# Buat folder backup sementara
mkdir -p "$temp"

# --- 1. Mencari file berdasarkan ekstensi & umur ---
# Jika tidak ada file ditemukan, hentikan proses
if ! find "$src" -name "$ext" -mtime "$days" -print -exec cp {} "$temp" \; | grep -q . ; then
    echo "[$(date)] Tidak ditemukan file yang memenuhi kriteria. Backup dibatalkan." | tee -a "$log"
    echo "Backup gagal."
    exit 1
fi

# --- 2. Kompresi ke tar.gz ---
cd "$dest"
tar -czf "backup_$time.tar.gz" "backup_$time"

# --- 3. Hapus folder sementara setelah kompresi ---
rm -rf "$temp"

# --- 4. Log untuk backup berhasil ---
echo "[$(date)] Backup berhasil. File tersimpan: $dest/backup_$time.tar.gz" >> "$log"

# --- 5. Notifikasi ke user ---
echo "Backup berhasil!"
echo "File backup  : backup_$time.tar.gz"
echo "Lokasi simpan: $dest"

exit 0
