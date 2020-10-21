#!/bin/bash
# sudo mkdir /sh
# nano /sh/iptables.sh
# copy code file
# save file
# chmod +x /sh/iptables.sh
# /sh/iptables.sh
#
# UNCOMMENT edit start
#nano /sh/iptables.sh

## port 22,80,443,639,55557
## port 53,5060
PORT_TCP='22,53,80,443,631,632,2000,5061,5222,5443,55555,55556,55557'
PORT_UDP='53,5060'
clear
# info
echo "iptables speed setup"

sudo iptables -F
sudo iptables -t nat -F
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -i ppp+ -j ACCEPT
sudo iptables -A INPUT -i ppp0 -j ACCEPT
sudo iptables -A INPUT -i ppp1 -j ACCEPT
sudo iptables -A INPUT -i ppp2 -j ACCEPT
sudo iptables -A INPUT -i tun+ -j ACCEPT
sudo iptables -A INPUT -i tun5 -j ACCEPT
sudo iptables -A INPUT -i tun6 -j ACCEPT
sudo iptables -A INPUT -i tun7 -j ACCEPT
sudo iptables -A INPUT -i tun8 -j ACCEPT

# asterisk DROP scan
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "sipvicious" --algo bm --to 65535 -j DROP
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "sipsak" --algo bm --to 65535 -j DROP
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "iWar" --algo bm --to 65535 -j DROP
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "sundayddr" --algo bm --to 65535 -j DROP
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "sip-scan" --algo bm --to 65535 -j DROP
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 5060 -m string --string "friendly-scanner" --algo bm --to 65535 -j DROP

sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

cat <<EOF >/tmp/ip-allow32;
11.11.11.11
11.11.11.12
172.28.253.2
EOF
for IP in $(cat /tmp/ip-allow32); do echo "ACCEPT $IP"; sudo iptables -A INPUT -i ens2 -s $IP/32 -j ACCEPT; done

## ip rus allow
cat <<EOF >/tmp/ip-allow16;
5.18.0.0
5.19.0.0
31.173.0.0
78.37.0.0
80.88.0.0
89.20.0.0
91.122.0.0
92.100.0.0
92.101.0.0
93.185.0.0
94.25.0.0
94.142.0.0
95.55.0.0
109.167.0.0
176.53.0.0
176.59.0.0
178.66.0.0
178.67.0.0
178.69.0.0
178.70.0.0
178.71.0.0
178.162.0.0
188.162.0.0
188.170.0.0
195.239.0.0
212.48.0.0
217.66.0.0
217.118.0.0
EOF
for IP in $(cat /tmp/ip-allow16); do echo "ACCEPT tcp       $IP"; sudo iptables -A INPUT -i ens2 -s $IP/16 -p tcp -m multiport --dport $PORT_TCP -j ACCEPT; done
for IP in $(cat /tmp/ip-allow16); do echo "ACCEPT udp       $IP"; sudo iptables -A INPUT -i ens2 -s $IP/16 -p udp -m multiport --dport $PORT_UDP -j ACCEPT; done
for IP in $(cat /tmp/ip-allow16); do echo "ACCEPT udp-range $IP"; sudo iptables -A INPUT -i ens2 -s $IP/16 -p udp -m multiport --dport 10000:20000 -j ACCEPT; done

sudo iptables -A INPUT -p udp -m policy --dir in --pol ipsec -m udp --dport 1701 -j ACCEPT
sudo iptables -A INPUT -p esp -j ACCEPT
sudo iptables -A INPUT -p ah -j ACCEPT
sudo iptables -A INPUT -i tun1194 -j ACCEPT
# l2yp ipsec
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 500 -j ACCEPT
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 1080 -j ACCEPT
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 4500 -j ACCEPT
# openvpn
sudo iptables -A INPUT -i ens2 -p udp -m udp --dport 1194 -j ACCEPT
# tor
#sudo iptables -A INPUT -i ens2 -p tcp -m tcp --dport 13720 -j ACCEPT
#sudo iptables -A INPUT -i ens2 -p tcp -m tcp --dport 13721 -j ACCEPT
sudo iptables -A INPUT -i ens2 -j DROP

# NAT
# ipsec
sudo iptables -A FORWARD -s 172.28.253.0/24 -i ppp+ -o ens2 -j ACCEPT
sudo iptables -A FORWARD -d 172.28.253.0/24 -i ens2 -o ppp+ -m state --state RELATED,ESTABLISHED -j ACCEPT
# open vpn
sudo iptables -A FORWARD -s 172.29.253.0/24 -i tun1194 -o ens2 -j ACCEPT
sudo iptables -A FORWARD -d 172.29.253.0/24 -i ens2 -o tun1194 -m state --state RELATED,ESTABLISHED -j ACCEPT
# openVPN+IPsec
sudo iptables -A FORWARD -s 172.29.253.0/24 -i tun1194 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -d 172.29.253.0/24 -i ppp+ -o tun1194 -j ACCEPT

#ppp
sudo iptables -A FORWARD -i ppp0 -o ppp1 -j ACCEPT
sudo iptables -A FORWARD -i ppp1 -o ppp0 -j ACCEPT
# tun
sudo iptables -A FORWARD -i tun+ -o ens2 -j ACCEPT
sudo iptables -A FORWARD -i ens2 -o tun+ -j ACCEPT
sudo iptables -A FORWARD -i tun+ -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun+ -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o tun1194 -j ACCEPT
sudo iptables -A FORWARD -i tun1194 -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i tun5 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun5 -j ACCEPT
sudo iptables -A FORWARD -i tun6 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun6 -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i tun6 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun6 -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -i ppp+ -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i tun5 -o tun6 -j ACCEPT
sudo iptables -A FORWARD -i tun6 -o tun5 -j ACCEPT
sudo iptables -A FORWARD -i tun6 -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o tun6 -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o tun5 -j ACCEPT
sudo iptables -A FORWARD -i tun5 -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i tun7 -o tun8 -j ACCEPT
sudo iptables -A FORWARD -i tun8 -o tun7 -j ACCEPT
sudo iptables -A FORWARD -i ppp0 -o tun8 -j ACCEPT
sudo iptables -A FORWARD -i tun8 -o ppp0 -j ACCEPT
sudo iptables -A FORWARD -i tun1194 -o tun8 -j ACCEPT
sudo iptables -A FORWARD -i tun8 -o tun1194 -j ACCEPT

sudo iptables -t nat -A PREROUTING -i ens2 -p tcp --dport 631 -j DNAT --to-destination 172.28.253.2:24
sudo iptables -t nat -A PREROUTING -i ens2 -p tcp --dport 632 -j DNAT --to-destination 172.28.253.4:22
# NAT VPN
sudo iptables -t nat -A POSTROUTING -s 172.28.253.0/24 -o ens2 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -s 172.29.253.0/24 -o ens2 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o tun7 -p tcp --dport 631 -j SNAT --to-source 172.28.253.2:24
sudo iptables -t nat -A POSTROUTING -o tun7 -p tcp --dport 632 -j SNAT --to-source 172.28.253.4:22

echo "`date -R` update ban manual" >> /var/log/ban-ip.txt
cp /var/log/ban-ip.txt /var/www/html/ban-ip.txt
echo "";
sudo iptables-save
