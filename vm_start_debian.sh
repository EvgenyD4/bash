#!/bin/bash
sudo ifconfig vboxnet0 down
sudo ifconfig vboxnet0 10.0.4.1
sudo ifconfig vboxnet0 up

sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -F
sudo iptables -t nat -F
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -i enp0s31f6
sudo iptables -A INPUT -i vboxnet0
sudo iptables -A INPUT -i wlxe84e064cee60
sudo iptables -A INPUT -i wlx502b73d54c25

sudo iptables -A INPUT -m conntrack --ctstate INVALID -j DROP
sudo iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT

sudo iptables -A FORWARD -i enp0s31f6 -o vboxnet0  -j ACCEPT
sudo iptables -A FORWARD -i vboxnet0 -o enp0s31f6  -j ACCEPT

sudo iptables -t nat -A PREROUTING  -i enp0s31f6 -p tcp --dport 81 -j DNAT --to-destination 10.0.4.2:80
sudo iptables -A POSTROUTING -t nat -o enp0s31f6 -j MASQUERADE
sudo iptables -t nat -A POSTROUTING -o vboxnet0 -p tcp --dport 81 -j SNAT --to-source 10.0.4.2:80

vboxmanage startvm --type headless Debian_apache

sleep 60
if ping -c 1 10.0.4.2 &>/dev/null
 then gnome-terminal -e 'ssh debian@10.0.4.2' &>/dev/null &
#gnome-terminal -e 'ssh debian@10.0.4.2' &>/dev/null &
sudo mount -t nfs -O uid=1000,iocharset=utf-8 10.0.4.2:/var/www/html ~/Mount/NFS_www_0.2
 else sleep 60
if ping -c 1 10.0.4.2 &>/dev/null
 then gnome-terminal -e 'ssh debian@10.0.4.2' &>/dev/null &
#gnome-terminal -e 'ssh debian@10.0.4.2' &>/dev/null &
sudo mount -t nfs -O uid=1000,iocharset=utf-8 10.0.4.2:/var/www/html ~/Mount/NFS_www_0.2
 else echo " ERROR VM Debian"
 fi
fi
