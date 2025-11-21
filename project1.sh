#================================
#Nama : Syahru Ramadhan Ibrahim
#NIM  : 05301425080
#Project Manajemen File Server
#================================

# 1. Buat struktur direktori
#Buat folder untuk 3 departemen (Marketing, Engineering, HR) dengan subfolder Documents dan Archives di masing-masing

mkdir -p /Departemen/{Marketing,Engineering,HR}/{Documents,Archives}

#mkdir Membuat direktori baru
#-p = membuat folder beserta subfolder tanpa error jika sudah ada
#{A,B,C} adalah brace expansion, cara cepat membuat banyak folder sekaligus


# 2. Pindahkan dan Salin File
#Pindahkan file yang salah tempat ke direktori yang benar, buat file backup di folder Archives 

for dept in Marketing Engineering HR; do
    # find untuk mencari file berdasarkan awalan nama departemen dan exec = mengeksekusi mv untuk memindahkan ke departemen yang sesuai
    find -type f -name /Departemen/"${dept}_*" -not -path "*/Documents/*" -exec mv {} /Departemen/${dept}/Documents/ \; 2>/dev/null

    # cp untuk menyalin untuk membackup ke folder Archives
    cp /Departemen/${dept}/Documents/${dept}_* /departemen/${dept}/Archives/
done


# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

sudo groupadd marketing
sudo groupadd engineering
sudo groupadd hr


sudo chown -R :marketing /home/departemen/Marketing
sudo chown -R :engineering /home/departemen/Engineering
sudo chown -R :hr /home/departemen/HR


sudo chmod -R 770 /home/departemen/Marketing
sudo chmod -R 770 /home/departemen/Engineering
sudo chmod -R 770 /home/departemen/HR

# 4.Cari dan filter
#Temukan semua file PDF yang dibuat minggu lalu dan buat daftar lengkapnya

find /home/departemen -type f -name "*.pdf" -mtime -7





