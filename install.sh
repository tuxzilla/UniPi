#!/bin/bash

if [ $(id -u) -ne 0 ]; then
  printf "Script must be run as root. Try 'sudo ./install.sh'\n"
  exit 1
fi

cd Source/ 
wget http://dl.ubnt.com/unifi/5.4.19/unifi_sysvinit_all.deb

git clone https://github.com/friendlyarm/NanoHatOLED.git
cd NanoHatOLED
sudo -H ./install.sh
cd ..
sudo python -m pip install --upgrade pip

tar xvfz Pillow-4.3.0.tar.gz
cd Pillow-4.3.0
sudo python setup.py install
cd ..
tar xvfz Django-1.11.6.tar.gz
cd Django-1.11.6
sudo python setup.py install
cd ..
