
src="/home/ramdan/data"
dest="/home/ramdan/backup"
log="$dest/backup.log"
ext="*.txt"
days=-7
time=$(date +"%Y%m%d_%H%M%S")
temp="$dest/backup_$time"

mkdir -p "$temp"

# Eksekusi find langsung tanpa grep
find "$src" -name "$ext" -mtime "$days" -exec cp {} "$temp" \;

# Cek apakah folder temp kosong
if [ -z "$(ls -A "$temp")" ]; then
    echo "[$(date)] Tidak ditemukan file. Backup dibatalkan." | tee -a "$log"
    echo "Backup gagal."
    rmdir "$temp"
    exit 1
fi

cd "$dest"
tar -czf "backup_$time.tar.gz" "backup_$time"
rm -rf "$temp"

echo "[$(date)] Backup berhasil. File: backup_$time.tar.gz" >> "$log"

echo "Backup berhasil!"
echo "File backup  : backup_$time.tar.gz"
echo "Lokasi simpan: $dest"

exit 0
