src="/home/ramdan/data"
dest="/home/ramdan/backup"
log="$dest/backup.log"
ext="*.txt"
days=3

time=$(date +"%Y%m%d_%H%M%S")
temp="$dest/backup_$time"

mkdir -p "$temp"

# Eksekusi find langsung tanpa menyimpan ke variabel
if ! find "$src" -name "$ext" -mtime -"$days" -exec cp {} "$temp" \; | grep -q . ; then
    echo "[$(date)] Tidak ditemukan file. Backup dibatalkan." | tee -a "$log"
    echo "Backup gagal."
    exit 1
fi

cd "$dest"
tar -czf "backup_$time.tar.gz" "backup_$time"
rm -rf "$temp"


echo "Backup berhasil!"
echo "File backup  : $kompres"
echo "Lokasi simpan : $backup"

exit 0
