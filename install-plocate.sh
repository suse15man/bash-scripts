sudo apt install libzstd-dev meson build-essential
wget https://plocate.sesse.net/download/plocate-1.1.16.tar.gz
meson obj
cd obj
ninja
sudo groupadd --system plocate
sudo ninja install
sudo systemctl enable plocate-updatedb.timer
sudo updatedb
