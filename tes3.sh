#!/bin/bash

# Konfigurasi
data="/home/ramdan/data"
backup="/home/ramdan/backup"
log="$backup/backup.log"
ext="*.txt"
days=7
time=$(date +"%Y%m%d_%H%M%S")
backup_file="$backup/backup_$time.tar.gz"
temp="$backup/backup_$time"

# Log mulai backup
echo "==========================================" >> "$log"
echo "[$(date)] MEMULAI PROSES BACKUP" >> "$log"
echo "Sumber: $data" >> "$log"
echo "Target: $backup_file" >> "$log"
echo "Kriteria: file $ext yang dimodifikasi dalam $days hari terakhir" >> "$log"

# Buat direktori temporary
mkdir -p "$temp"

# Cari dan backup file
echo "[$(date)] Mencari file sesuai kriteria..." >> "$log"
file_count=0

while IFS= read -r file; do
    if [[ -n "$file" ]]; then
        cp "$file" "$temp/"
        echo "[$(date)] BACKUP: $file" >> "$log"
        ((file_count++))
    fi
done < <(find "$data" -name "$ext" -mtime -$days 2>/dev/null)

# Cek apakah ada file yang dibackup
if [ $file_count -eq 0 ]; then
    echo "[$(date)] ERROR: Tidak ada file yang ditemukan. Backup dibatalkan." >> "$log"
    echo "==========================================" >> "$log"
    echo "BACKUP GAGAL: Tidak ada file yang sesuai kriteria"
    exit 1
fi

echo "[$(date)] Ditemukan $file_count file untuk dibackup" >> "$log"

# Kompresi file
echo "[$(date)] Membuat archive..." >> "$log"
if tar -czf "$backup_file" -C "$backup" "backup_$time" 2>/dev/null; then
    archive_size=$(du -h "$backup_file" | cut -f1)
    echo "[$(date)] Archive berhasil dibuat: $backup_file ($archive_size)" >> "$log"
else
    echo "[$(date)] ERROR: Gagal membuat archive" >> "$log"
    echo "==========================================" >> "$log"
    echo "BACKUP GAGAL: Error saat kompresi"
    exit 1
fi

# Bersihkan temporary directory
rm -rf "$temp"

# Log selesai
echo "[$(date)] BACKUP BERHASIL" >> "$log"
echo "File backup: $backup_file" >> "$log"
echo "Total file: $file_count" >> "$log"
echo "Ukuran archive: $archive_size" >> "$log"
echo "==========================================" >> "$log"

# Notifikasi ke user
echo "BACKUP BERHASIL!"
echo "File backup    : backup_$time.tar.gz"
echo "Lokasi         : $backup"
echo "Total file     : $file_count"
echo "Ukuran         : $archive_size"
echo "Log detail     : $log"

exit 0
