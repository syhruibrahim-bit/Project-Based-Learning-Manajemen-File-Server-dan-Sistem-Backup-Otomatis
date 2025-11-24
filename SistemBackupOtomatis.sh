#Membuat Variable agar lebih mudah saat pemanggilan
data="/home/ramdan/penting/data"                    # Folder sumber file yang akan dicari dan dibackup
backup="/home/ramdan/penting/backup"                # Folder tempat hasil backup disimpan
log="/home/ramdann/penting/backup/backup.log"        # Lokasi file log untuk mencatat aktivitas backup
ext="*.txt"                                 # Ekstensi file yang dicari, bisa diganti misal *.pdf atau *.docx
d=1                                         # Mencari file yang dimodifikasi dalam 1 hari terakhir 

#Membuat timestamp
time=$(date +"%Y-%m-%d_%H-%M-%S")     # Membuat penanda waktu
kompres="backup_$time.tar.gz"         # Nama file backup hasil kompresi
tmp="/tmp/backup_$time"               # Folder sementara untuk menampung file sebelum dikompresi


# 1. Mencari file berdasarkan kriteria
mkdir -p "$tmp"                              # Membuat folder sementara jika belum ada
find "$data" -mtime -$d -name "$ext" -exec cp {} "$tmp" \;    # Menyalin file yang sesuai kriteria ke folder sementara

# Mengecek apakah ada file yang ditemukan
if [ ! "$(ls -A $tmp)" ]; then              # Jika folder sementara kosong, berarti tidak ada file ditemukan
    echo "[$(date)] GAGAL: Tidak ada file yang sesuai kriteria." >> "$log"   # Catat ke log
    echo "Backup gagal: Tidak ada file yang ditemukan."                         # Tampilkan ke terminal
    rm -rf "$tmp"                                                                # Hapus folder sementara
    exit 1                                                                            # Menghentikan script
fi

# ----- 2. Kompresi file -----
tar -czf "$kompres" -C "$tmp" .       # Mengkompres semua file di folder sementara menjadi file .tar.gz

# ----- 3. Memindahkan hasil kompresi ke folder backup -----
mkdir -p "$backup"                           # Membuat folder backup jika belum ada
mv "$kompres" "$backup/"                # Memindahkan file backup ke folder tujuan

# ----- 4. Mencatat log aktivitas -----
echo "[$(date)] BERHASIL: Backup tersimpan sebagai $backup/$kompres" >> "$log"   # Menulis log bahwa backup sukses

# ----- 5. Menampilkan notifikasi ke terminal -----
echo "Backup berhasil!"
echo "File backup: $kompres"
echo "Lokasi penyimpanan: $backup"

# ----- Membersihkan folder sementara -----
rm -rf "$tmp"

exit 0                                           # Menandakan script telah selesai tanpa error
