# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

for dept in Marketing Engineering HR; do
    sudo groupadd "$dept"
    sudo chown -R :"$dept" "/home/ramdan/departemen/$dept"
    sudo chmod -R 770 "/home/ramdan/departemen/$dept"
done


