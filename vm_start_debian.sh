#!/bin/bash
echo " START VM DEBIAN"
if ! sudo -u evg vboxmanage list runningvms | grep -o "4c7061d6d19e" &> /dev/null;
 then echo "";
echo -en "\033[37;1;41m setting NAT vm Debian \033[0m"
echo -en "\E[0m";
echo "";

sudo ip link set vboxnet0 down
sudo ip link set vboxnet0 up
sudo ip addr del 192.168.56.1/24 dev vboxnet0
sudo ip addr add 10.0.4.1/24 dev vboxnet0

sudo sysctl -w net.ipv4.ip_forward=1

sudo iptables -F
sudo iptables -t nat -F
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

sudo iptables -A INPUT -i lo -j ACCEPT
# wan
sudo iptables -A INPUT -i enp2s0 -j ACCEPT
# local network
sudo iptables -A INPUT -i enp1s0 -j ACCEPT
# vm
sudo iptables -A INPUT -i vboxnet0 -j ACCEPT
#sudo iptables -A INPUT -i wlan0 -j ACCEPT

sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo iptables -A FORWARD -i enp1s0 -o vboxnet0  -j ACCEPT
sudo iptables -A FORWARD -i vboxnet0 -o enp1s0  -j ACCEPT

sudo iptables -t nat -A PREROUTING  -i enp1s0 -p tcp --dport 222 -j DNAT --to-destination 10.0.4.2:22
sudo iptables -t nat -A PREROUTING  -i enp1s0 -p tcp --dport 83 -j DNAT --to-destination 10.0.4.2:80
sudo iptables -t nat -A PREROUTING  -i enp1s0 -p tcp --dport 82 -j DNAT --to-destination 10.0.4.2:81
sudo iptables -t nat -A PREROUTING  -i enp1s0 -p tcp --dport 443 -j DNAT --to-destination 10.0.4.2:443
sudo iptables -A POSTROUTING -t nat -o enp1s0 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o vboxnet0 -p tcp --dport 222 -j SNAT --to-source 10.0.4.2:22
sudo iptables -t nat -A POSTROUTING -o vboxnet0 -p tcp --dport 83 -j SNAT --to-source 10.0.4.2:80
sudo iptables -t nat -A POSTROUTING -o vboxnet0 -p tcp --dport 82 -j SNAT --to-source 10.0.4.2:81
sudo iptables -t nat -A POSTROUTING -o vboxnet0 -p tcp --dport 443 -j SNAT --to-source 10.0.4.2:443

echo -en "\033[32m Start vm Debian... \033[40m"
echo -en "\E[0m";
echo "";

sudo -u evg vboxmanage startvm --type headless Debian_apache

sudo ip addr del 192.168.56.1/24 dev vboxnet0
sudo ip addr add 10.0.4.1/24 dev vboxnet0

sleep 50
#sudo mount -t nfs -O uid=1000,iocharset=utf-8 10.0.4.2:/var/www/html /1TB/VMBox/share
ssh evg@192.168.0.11 '/sh/ssh_debian_apache.sh'
echo "vboxmanage export Debian_apache --output /1TB/VMBox/Debian_apache_16.12.2020.ova"

fi
