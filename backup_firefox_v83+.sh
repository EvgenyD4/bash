#!/bin/bash
echo " Backup started ..."
DA=`date +%Y-%m-%d_%H-%M-%S`
DISPLAY=":0.0"
export LANG=ru_RU.UTF-8
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
CO=$(find /home/$USER/.mozilla -type d -name "*.default-release" -print)
cd $CO
pwd
D=$(echo "$CO" | grep -oE "firefox.*")
## file="/home/$USER/.mozilla/firefox/1v0t5pkf.default/prefs.js"
if [ -d $CO ];
#--stats
 then rsync -hrz \
 /home/$USER/.mozilla/$D/ \
 /320/Backup/FireFox \
 2>1&>/dev/null
 tar zcfp /320/Backup/ctb/Firefox_v83_profile_backup.tar.gz \
 /home/$USER/.mozilla/$D 2>1&>/dev/null
echo "$DA backup Firefox v83" >> /320/Backup/ctb/Firefox_v83.txt
fi
cd $HOME
version="`firefox -v | awk '{print substr($3,$1,$3)}'`"
echo " Firefox $version version."
echo "";
echo "restore Firefox:"
echo "#tar -C /dir2 -xvf /dir1/Back.tar.gz --strip-components 4"
