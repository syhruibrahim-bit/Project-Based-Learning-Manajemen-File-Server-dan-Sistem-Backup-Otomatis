#Membuat Variable agar lebih mudah saat pemanggilan
SOURCE_DIR="/home/user/data"              # Folder sumber file yang akan dicari dan dibackup
BACKUP_DIR="/home/user/backup"            # Folder tempat hasil backup disimpan
LOG_FILE="/home/user/backup/backup.log"   # Lokasi file log untuk mencatat aktivitas backup
EXT="*.txt"                               # Ekstensi file yang dicari, bisa diganti misal *.pdf atau *.docx
DAYS=1                                    # Mencari file yang dimodifikasi dalam 1 hari terakhir 

#Membuat timestamp
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")     # Membuat penanda waktu
ARCHIVE_NAME="backup_$TIMESTAMP.tar.gz"    # Nama file backup hasil kompresi
TEMP_DIR="/tmp/backup_$TIMESTAMP"          # Folder sementara untuk menampung file sebelum dikompresi

# ===================== MEMULAI PROSES BACKUP =====================
echo "[$(date)] Memulai proses backup..." >> "$LOG_FILE"    # Mencatat ke log bahwa backup dimulai

# ----- 1. Mencari file berdasarkan kriteria -----
mkdir -p "$TEMP_DIR"                              # Membuat folder sementara jika belum ada
find "$SOURCE_DIR" -mtime -$DAYS -name "$EXT" -exec cp {} "$TEMP_DIR" \;    # Menyalin file yang sesuai kriteria ke folder sementara

# Mengecek apakah ada file yang ditemukan
if [ ! "$(ls -A $TEMP_DIR)" ]; then              # Jika folder sementara kosong, berarti tidak ada file ditemukan
    echo "[$(date)] GAGAL: Tidak ada file yang sesuai kriteria." >> "$LOG_FILE"   # Catat ke log
    echo "Backup gagal: Tidak ada file yang ditemukan."                         # Tampilkan ke terminal
    rm -rf "$TEMP_DIR"                                                                # Hapus folder sementara
    exit 1                                                                            # Menghentikan script
fi

# ----- 2. Kompresi file -----
tar -czf "$ARCHIVE_NAME" -C "$TEMP_DIR" .       # Mengkompres semua file di folder sementara menjadi file .tar.gz

# ----- 3. Memindahkan hasil kompresi ke folder backup -----
mkdir -p "$BACKUP_DIR"                           # Membuat folder backup jika belum ada
mv "$ARCHIVE_NAME" "$BACKUP_DIR/"                # Memindahkan file backup ke folder tujuan

# ----- 4. Mencatat log aktivitas -----
echo "[$(date)] BERHASIL: Backup tersimpan sebagai $BACKUP_DIR/$ARCHIVE_NAME" >> "$LOG_FILE"   # Menulis log bahwa backup sukses

# ----- 5. Menampilkan notifikasi ke terminal -----
echo "Backup berhasil!"
echo "File backup: $ARCHIVE_NAME"
echo "Lokasi penyimpanan: $BACKUP_DIR"

# ----- Membersihkan folder sementara -----
rm -rf "$TEMP_DIR"

exit 0                                           # Menandakan script telah selesai tanpa error
