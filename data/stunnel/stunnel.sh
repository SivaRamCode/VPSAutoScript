#!/bin/bash
#auto install debiain
#created bye Sivaram COde

# details
country=MY
state=Selangor
locality=Klang
organization=sivaramcode
organizationalunit=sivaramcode
commonname=hsivaramcode
email=sivaramcode@gmail.com

# install stunnel
apt-get install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
#[dropbear]
#accept = 443
#connect = 127.0.0.1:143
[openvpn]
accept = 587
connect = 127.0.0.1:1986

END

echo "================= Cert Generate OpenSSL ======================"
echo "========================================================="
#cert generate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# configure stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart

#remove junks
rm -rf stunnel.sh
