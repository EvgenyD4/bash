#!/bin/bash
sudo sed -i 's/except-interface=lo/#except-interface=wlan0/g' /etc/dnsmasq.conf 1>/dev/null
sudo sed -i 's/no-dhcp-interface=ens2/no-dhcp-interface=wlan0/g' /etc/dnsmasq.conf 1>/dev/null
sudo sed -i 's/no-dhcp-interface=wlan0/#no-dhcp-interface=wlan0/g' /etc/dnsmasq.conf 1>/dev/null

#C1=$(cat /etc/dnsmasq.conf | sed -n '/#interface=wlan0/=' | tail -n1)
#cat /etc/dnsmasq.conf | sudo sed -i '$C1s/#interface=wlan0/interface=wlan0/' /etc/dnsmasq.conf 1>/dev/null

sudo sed -i '/interface=wlan0/a dhcp-range=192.168.10.3,192.168.10.20,255.255.255.0,24h' /etc/dnsmasq.conf 1>/dev/null
#C2=$(cat /etc/dnsmasq.conf | sed -n '/dhcp-range/=' | tail -n1)
sudo sed -i '`cat /etc/dnsmasq.conf | sed -n '/dhcp-range/='`d' /etc/dnsmasq.conf 1>/dev/null

sudo sed -i '/interface=wlan0/a dhcp-option=6,192.168.10.1' /etc/dnsmasq.conf 1>/dev/null
#C3=$(cat /etc/dnsmasq.conf | sed -n '/dhcp-option=6/=' | tail -n1)
sudo sed -i '`cat /etc/dnsmasq.conf | sed -n '/dhcp-option=6/=' | tail -n1`d' /etc/dnsmasq.conf 1>/dev/null

sudo sed -i '/dhcp-option=6/a dhcp-option=3,192.168.10.1' /etc/dnsmasq.conf 1>/dev/null
# delete line
#C4=$(cat /etc/dnsmasq.conf | sed -n '/server.*#53/=' | haed -n 1)
sudo sed -i '`cat /etc/dnsmasq.conf | sed -n '/dhcp-option=3/=' | tail -n1`d' /etc/dnsmasq.conf 1>/dev/null

sudo sed -i '`cat /etc/dnsmasq.conf | sed -n '/server.*#53/=' | tail -n 1`d' /etc/dnsmasq.conf 1>/dev/null
sudo sed -i 's/server.*#53/server=172.28.253.1#53/' /etc/dnsmasq.conf 1>/dev/null
sudo sed -i '`cat /etc/dnsmasq.conf | sed -n '/server.*#53/=' | tail -n 1`d' /etc/dnsmasq.conf 1>/dev/null
