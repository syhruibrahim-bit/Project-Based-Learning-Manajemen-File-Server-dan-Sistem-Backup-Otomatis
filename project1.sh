#================================
#Nama : Syahru Ramadhan Ibrahim
#NIM  : 05301425080
#Project Manajemen File Server
#================================

# 1. Buat struktur direktori
#Buat folder untuk 3 departemen (Marketing, Engineering, HR) dengan subfolder Documents dan Archives di masing-masing

mkdir -p /home/ramdan/Departemen/{Marketing,Engineering,HR}/{Documents,Archives}
# mkdir = membuat direktori
# -p = membuat seluruh struktur folder sekaligus, dan tidak error jika folder sudah ada
# {a,b,c} = brace expansion untuk membuat folder banyak sekaligus

# 2. Pindahkan dan Salin File
#Pindahkan file yang salah tempat ke direktori yang benar, buat file backup di folder Archives 

#Kita misalkan bahwa dalam departemen ada sebuah file sampel yang nantinya kita akan pindah kan

for dept in Marketing Engineering HR; do
    # Loop untuk tiap departemen: Marketing, Engineering, HR
    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \;
    # find = mencari file
    # -type f = hanya mencari file
    # -name "${dept}_*" = mencari file yang namanya diawali nama departemen
    # -not -path "*/Documents/*" = abaikan file yang sudah berada dalam folder Documents
    # -exec mv {} <tujuan> \; = pindahkan file hasil pencarian ke folder Documents

    cp "/home/ramdan/Departemen/${dept}/Documents/"* "/home/ramdan/Departemen/${dept}/Archives/" 
    # cp = menyalin file
    # "/Documents/"* = semua file di dalam Documents
    # "/Archives/" = tujuan backup
done

# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

for dept in Marketing Engineering HR; do
    sudo groupadd -f "$dept"
    # groupadd = membuat group Linux
    # -f = tidak error jika group sudah ada

    sudo chown -R :"$dept" "/home/ramdan/Departemen/$dept"
    # chown = mengubah kepemilikan file/folder
    # -R = rekursif ke semua subfolder

    sudo chmod -R 770 "/home/ramdan/Departemen/$dept"
    # chmod = mengubah permission
    # 770 = owner dan group bisa read-write-execute, user lain tidak dapat akses
done

# 4.Cari dan filter
#Temukan semua file PDF yang dibuat minggu lalu dan buat daftar lengkapnya

find /home/ramdan/ -type f -name "*.pdf" -mtime -7 > daftar_pdf_minggu_lalu.txt
# find = mencari file
# -type f = hanya file
# -name "*.pdf" = format PDF
# -mtime -7 = file PDF yang dimodifikasi dalam 7 hari terakhir
