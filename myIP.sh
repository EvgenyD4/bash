#!/bin/bash
echo " my ip"
wget https://ip8.com -O /tmp/ip.txt 2>/dev/null
cat /tmp/ip.txt | grep resolveIp | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}'
echo " local ip"
ip a | grep inet | grep ".255" | grep -oE '[0-9]{1,3}(\.[0-9]{1,3}){3}' | grep -v ".255"
