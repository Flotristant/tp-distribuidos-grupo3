python setup.py riogallegos
python setup.py rioturbio
python setup.py elcalafate
sudo mv db.* /etc/bind/
sudo mv named.conf.local /etc/bind/
sudo /etc/init.d/bind9 restart
