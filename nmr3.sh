# 3. Atur permission
#Set permission yang tepat agar hanya departemen terkait yang bisa mengakses folder mereka

sudo groupadd marketing
sudo groupadd engineering
sudo groupadd hr


sudo chown -R :marketing /home/ramdan/departemen/Marketing
sudo chown -R :engineering /home/ramdan/departemen/Engineering
sudo chown -R :hr /home/ramdan/departemen/HR


sudo chmod -R 770 /home/ramdan/departemen/Marketing
sudo chmod -R 770 /home/ramdan/departemen/Engineering
sudo chmod -R 770 /home/ramdan/departemen/HR
