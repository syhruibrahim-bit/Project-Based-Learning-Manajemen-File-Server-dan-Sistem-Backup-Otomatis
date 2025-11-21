# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

for dept in Marketing Engineering HR; do
    sudo groupadd "$dept"
    sudo chown -R :"$dept" "/home/ramdan/departemen/$dept"
    sudo chmod -R 770 "/home/ramdan/departemen/$dept"
done


find /home/ramdan/Departemen -type f -name "*.pdf" -mtime -7 -exec stat -c "%n | Dibuat: %w | Diubah: %y" {} \; > daftar_pdf_minggu_lalu.txt



