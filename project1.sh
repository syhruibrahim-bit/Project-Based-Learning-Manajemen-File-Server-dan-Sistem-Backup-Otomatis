#================================
#Nama : Syahru Ramadhan Ibrahim
#NIM  : 05301425080
#Project Manajemen File Server
#================================

# 1. Buat struktur direktori
#Buat folder untuk 3 departemen (Marketing, Engineering, HR) dengan subfolder Documents dan Archives di masing-masing

mkdir -p /home/ramdan/Departemen/{Marketing,Engineering,HR}/{Documents,Archives}

#mkdir Membuat direktori baru
#-p = membuat folder beserta subfolder tanpa error jika sudah ada
#{A,B,C} adalah brace expansion, cara cepat membuat banyak folder sekaligus


# 2. Pindahkan dan Salin File
#Pindahkan file yang salah tempat ke direktori yang benar, buat file backup di folder Archives 

for dept in Marketing Engineering HR; do
    find /home/ramdan/Departemen/ -type f -name "${dept}_*" -not -path "*/Documents/*" -exec mv {} "/home/ramdan/Departemen/${dept}/Documents/" \;
    cp "/home/ramdan/Departemen/${dept}/Documents/"* "/home/ramdan/Departemen/${dept}/Archives/" 
done


# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

for dept in Marketing Engineering HR; do
    sudo groupadd "$dept"
    sudo chown -R :"$dept" "/home/ramdan/Departemen/$dept"
    sudo chmod -R 770 "/home/ramdan/Departemen/$dept"
done
# 4.Cari dan filter
#Temukan semua file PDF yang dibuat minggu lalu dan buat daftar lengkapnya

find /home/ramdan/Departemen -type f -name "*.pdf" -mtime -7





