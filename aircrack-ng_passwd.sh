#!/bin/bash
clear

cat <<EOF >/tmp/inst_deb.txt;
aircrack-ng
crunch

EOF
for P in $(cat /tmp/inst_deb.txt); do echo " check install [ $P ]"; if ! dpkg --get-selections $P 2> /dev/null | grep -oE install &> /dev/null; then sudo apt install $P; fi; done

file="/home/$USER/NG"
if [ -d $file ]; 
 then cd /home/$USER/NG
 else mkdir /home/$USER/NG
      cd /home/$USER/NG
fi

pwd
sleep 2
echo "";
sleep 1
echo " BSSID [F8:32:E4:44:73:A4]"
read B

crunch 8 16 0123456789 | aircrack-ng -w - *.cap -b $B
crunch 8 16 0123456789qwertyuiopasdfghjklzxcvbnm | aircrack-ng -w - *.cap -b $B
crunch 8 16 0123456789QWERTYUIOPASDFGHJKLZXCVBNM\(\)\[\]\{\}\!\@\#\$ | aircrack-ng -w - *.cap -b $B
crunch 8 16 qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM | aircrack-ng -w - *.cap -b $B
crunch 8 16 0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM | aircrack-ng -w - *.cap -b $B
crunch 8 16 0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM\(\)\[\]\{\}\!\@\#\$ | aircrack-ng -w - *.cap -b $B
