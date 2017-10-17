#!/bin/bash

if [ $(id -u) -ne 0 ]; then
  printf "Script must be run as root. Try 'sudo ./install.sh'\n"
  exit 1
fi

echo " "
echo "Check for internet connectivity..."
echo "=================================="
wget -q --tries=2 --timeout=100 http://www.google.co.th -O /dev/null
if [ $? -eq 0 ];then
	echo "Connected"
else
	echo "Unable to Connect, try again !!!"
	exit 0
fi

#Set Time & Timezone
echo " "
echo "Update Timezone "Asia/Bangkok" and Current time..."
echo "=================================="
sudo timedatectl set-timezone "Asia/Bangkok"
sudo ntpdate pool.ntp.org

# Install UniFi Controller
echo " "
echo "Install UniFi Controller..."
echo "=================================="
cd Source
echo " "
echo "Download UniFi Controller V.5.5.24 ..."
echo "=================================="
wget http://dl.ubnt.com/unifi/5.5.24/unifi_sysvinit_all.deb

echo " "
echo "Download Dependency file..."
echo "=================================="
sudo apt-get -y install mongodb-server openjdk-8-jre-headless jsvc libcommons-daemon-java java-virtual-machine

echo " "
echo "Install UniFi..."
echo "=================================="
sudo dpkg -i unifi_sysvinit_all.deb
echo "Configuration UniFi..."
echo "=================================="
echo "unifi.db.extraargs=--smallfiles" >> /usr/lib/unifi/data/system.properties
echo "unifi.https.port=443" >> /usr/lib/unifi/data/system.properties
cd ..
echo "Clean UniPi Source..."
echo "=================================="
if [ -d UniPi ]; then
  rm -rf UniPi
fi

# Install NanoHat OLED
git clone https://github.com/friendlyarm/NanoHatOLED.git
if [ -d NanoHatOLED ]; then
  cd NanoHatOLED
  sudo -H ./install.sh
  cd ..
fi
echo "NanoHatOLED installed"
