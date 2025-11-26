==================
Nama : Syahru Ramadhan Ibrahim
NIM : 05301425080
Prodi : Sistem Informasi 25 | Kelas D 
Tugas Project Base Learning Fliping Classroom
===========================================================
------------------------------------------------------------
1. ManajemenFileServer.sh
------------------------------------------------------------

FUNGSI:
Script ini digunakan untuk membuat struktur folder departemen, memindahkan file sesuai departemen, membuat backup file ke folder Archives, mengatur permission, dan menghasilkan daftar file PDF terbaru.

CARA MENGGUNAKAN:
1. Beri izin eksekusi:
   chmod +x ManajemenFileServer.sh

2. Jalankan script:
   ./ManajemenFileServer.sh

STRUKTUR FOLDER YANG DIBUAT:
  /home/ramdan/Departemen/
     - Marketing/{Documents,Archives}
     - Engineering/{Documents,Archives}
     - HR/{Documents,Archives}

CARA KERJA SCRIPT:
1. Membuat folder Marketing, Engineering, dan HR beserta subfolder Documents dan Archives.
2. Memindahkan file yang namanya diawali:
     Marketing_*
     Engineering_*
     HR_*
   ke folder Documents masing-masing departemen.
3. Menyalin seluruh file dari Documents ke Archives sebagai backup.
4. Mengatur permission folder:
   - Membuat group departemen (groupadd -f)
   - Mengatur kepemilikan folder dengan chown
   - Memberikan akses 770 untuk owner dan group
5. Mencari file PDF terbaru (7 hari terakhir) dan membuat:
   daftar_pdf_minggu_lalu.txt


------------------------------------------------------------
2. SistemBackupOtomatis.sh
------------------------------------------------------------

FUNGSI:
Script ini melakukan backup otomatis berdasarkan ekstensi file dan tanggal modifikasi. File yang ditemukan akan dikumpulkan ke folder temporary, lalu dikompres menjadi .tar.gz, dan prosesnya dicatat di log.

CARA MENGGUNAKAN:
1. Beri izin eksekusi:
   chmod +x SistemBackupOtomatis.sh

2. Jalankan script:
   ./SistemBackupOtomatis.sh

HASIL YANG DIBUAT:
- Folder sumber data:
  /home/ramdan/data

- Folder backup:
  /home/ramdan/backup

- File log:
  backup/backup.log

- File hasil arsip:
  backup_YYYYMMDD_HHMMSS.tar.gz

CARA KERJA SCRIPT:
1. Membuat folder temporary untuk menampung hasil backup.
2. Mencari file dengan ekstensi (*.txt) yang dimodifikasi 7 hari terakhir.
3. Jika tidak ada file, proses backup dibatalkan dan dicatat di log.
4. Jika ada file, semua file disalin ke folder temporary.
5. Folder temporary dikompresi menjadi arsip tar.gz.
6. Log proses backup ditulis ke backup.log.


------------------------------------------------------------
CATATAN PENTING
------------------------------------------------------------
- Script memerlukan akses sudo untuk perintah groupadd, chown, dan chmod.
- Pastikan path /home/ramdan/ sesuai dengan struktur sistem Linux Anda.
- Script berjalan pada Linux (Ubuntu/Debian).

------------------------------------------------------------
SELESAI
------------------------------------------------------------
