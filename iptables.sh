#!/bin/bash
## port 22,80,443,639,55557
## port 53,5060
PORT_TCP='22,53,80,443,631,632,2000,5061,5222,5443,55555,55556,55557'
PORT_UDP='53,5060'
clear

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

sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

cat <<EOF >/tmp/ip-allow32;
111.111.111.111
222.222.222.222
172.172.172.172
EOF
for IP in $(cat /tmp/ip-allow32); do echo "ACCEPT $IP"; sudo iptables -A INPUT -i ens2 -s $IP/32 -j ACCEPT; done

sudo iptables -A INPUT -i ens2 -j DROP

# tun
sudo iptables -A FORWARD -i tun+ -o ens2 -j ACCEPT
sudo iptables -A FORWARD -i ens2 -o tun+ -j ACCEPT

# NAT VPN
sudo iptables -t nat -A POSTROUTING -s 172.172.172.0/24 -o ens2 -j MASQUERADE

echo "`date -R` update ban manual" >> /var/log/ban-ip.txt
sudo iptables-save
