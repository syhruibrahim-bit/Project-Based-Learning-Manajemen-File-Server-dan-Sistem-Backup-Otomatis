#================================
#Nama : Syahru Ramadhan Ibrahim
#NIM  : 05301425080
#Project Manajemen File Server
#================================

# 1. Buat struktur direktori
#Buat folder untuk 3 departemen (Marketing, Engineering, HR) dengan subfolder Documents dan Archives di masing-masing

mkdir -p {Marketing,Engineering,HR}/{Documents,Archives}

#mkdir Membuat direktori baru
#-p = membuat folder beserta subfolder tanpa error jika sudah ada
#{A,B,C} adalah brace expansion, cara cepat membuat banyak folder sekaligus


# 2. Pindahkan dan Salin File
#Pindahkan file yang salah tempat ke direktori yang benar, buat file backup di folder Archives 

for dept in Marketing Engineering HR; do                        #looping untuk setiap departemen
    mv "$dept"/"$dept"_* "$dept"/Documents/                     #mv untuk memindahkan file 
    cp "$dept"/Documents/"$dept"_* "$dept"/Archives/            #cp untuk menyalin file
done

# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka


