#!/bin/bash
#
# BY Sivaram Code
#  Easy Squid Import Conf
# ==================================================

MYIP=$(wget -qO- ipv4.icanhazip.com);

MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";

# install squid
cd
apt-get -y install squid
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/SivaRamCode/VPSAutoScript/main/data/dll/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf;
service squid restart
systemctl start squid
systemctl enable squid

# Compelte
clear
echo "Install Done"
