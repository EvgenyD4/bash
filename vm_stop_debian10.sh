#!/bin/bash
echo " STOP VM DEBIAN"
if vboxmanage list runningvms | grep -o "4c7061d6d19e" &> /dev/null;
 then ssh root@10.0.4.2 'poweroff'
      sleep 15
      echo "";
      D=`date +%Y-%m-%d_%H-%M`
      vboxmanage export Debian_apache --output /1TB/VMBox/Debian_apache_$D.ova
      echo "";
      df -h | grep sdb1
      echo " DEBIAN export [OK]"
# vboxmanage controlvm Debian_apache poweroff
fi
#echo "vboxmanage export Debian_apache --output /1TB/VMBox/Debian_apache_16.12.2020.ova"
