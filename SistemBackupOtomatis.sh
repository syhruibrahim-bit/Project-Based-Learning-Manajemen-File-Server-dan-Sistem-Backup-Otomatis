#=====================================
# Nama    : Syahru Ramadhan Ibrhamim
# NIM     : 05301425080
# Sistem Backup Otomatis
#=====================================


# Membuat Variable Agar memudahkan kita pada saat pemograman
data="/home/ramdan/data"       # Folder sumber tempat file-file yang akan dicari
backup="/home/ramdan/backup"     # Folder tujuan tempat backup disimpan
log="$backup/backup.log"         # Lokasi file log untuk mencatat aktivitas backup
ext="*.txt"                    # Ekstensi file yang akan dibackup
d=-7                            # File yang dimodifikasi dalam 7 hari terakhir
time=$(date +"%Y%m%d_%H%M%S")  # Membuat timestamp unik (tanggal_jam)
temp="$backup/backup_$time"      # Nama folder temporary untuk menampung file hasil backup

mkdir -p "$temp"               # Membuat folder temporary (jika belum ada)

# Mencari file sesuai ekstensi dan umur file, lalu menyalinnya ke temp
find "$data" -name "$ext" -mtime "$d" -exec cp {} "$temp" \;  

# Cek apakah folder temp kosong
if [ -z "$(ls -A "$temp")" ]; then                               # Mengecek apakah folder temp kosong menggunakan ls -A
    echo "[$(date)] Tidak ditemukan file. Backup dibatalkan." | tee -a "$log"  # Tulis pesan ke layar & log
    echo "Backup gagal."
    rmdir "$temp"                                                # Menghapus folder temp karena tidak ada isi
    exit 1                                                       # Keluar dengan status error
fi

cd "$backup"                                                     # Pindah ke folder backup
tar -czf "backup_$time.tar.gz" "backup_$time"                    # Mengarsipkan folder temp menjadi file .tar.gz
rm -rf "$temp"                                                   # Menghapus folder temporary setelah dijadikan arsip

echo "[$(date)] Backup berhasil. File: backup_$time.tar.gz" >> "$log"   # Menuliskan log bahwa backup sukses

echo "Backup berhasil!"                                          # Menampilkan pesan ke user
echo "File backup  : backup_$time.tar.gz"
echo "Lokasi simpan: $backup"

exit 0                                                            # Keluar normal tanpa error
