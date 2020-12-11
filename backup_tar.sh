#!/bin/bash
# 36 и 37 строки править руками!
DISPLAY=":0.0"
export LANG=ru_RU.UTF-8
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"
DA=`date +%Y-%m-%d_%H-%M`
TMPD='/320/Backup/TMP'
IND='/sh/'
DI='/2TB/backup/archive/mint/sh/'
NAME='mint_sh_backup.tar.gz'

# Check if packages are installed
cat <<EOF >/tmp/inst_deb.txt;
zenity
rsync

EOF
for P in $(cat /tmp/inst_deb.txt);
do echo " check install [ $P ]";
 if ! dpkg --get-selections $P 2> /dev/null | grep -oE install &> /dev/null;
  then sudo apt install $P; echo " install $P [YES] ";
 fi;
done

# Checking if a directory exists
dir="$IND"
if [ -d $dir ];
 then echo " Backup started ..."
tar zcfp $TMPD/$NAME \
 $IND 2>1&>/dev/null
S=$(du -sh $TMPD/$NAME | awk '{print $1}')
mv $TMPD/$NAME \
 $TMPD/$DA-$NAME
rsync -h -e ssh $TMPD/$DA-$NAME \
 evg@192.168.0.5:$DI
F=$(ssh user@192.168.0.5 'ls /2TB/backup/archive/mint/sh/ | wc -l')
A=$(ssh user@192.168.0.5 'ls /2TB/backup/archive/mint/sh/ | tail -n 1 | grep -oE "^................"')
SZ=$(ssh user@192.168.0.5 '/sh/df-2TB.sh')
rm $TMPD/$DA-$NAME

zenity --window-icon="info" --width=400 \
        --info --title="Backup" \
        --text="   Резервное копирование /sh \n Размер архива            - $S \n Количество архивов - $F \n Последний архив       - $A \n Остаток     места          - $SZ" --display=:0 2> /dev/null &
fi
