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
