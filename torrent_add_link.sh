#!/bin/bash
clear
echo "";
echo -en "\033[32m создать линк на видео для minidlna \033[40m"
echo -en "\E[0m";
echo "";
sleep 2
INDIR='/2TB/anon/move/torrent'
#ls -al $INDIR/ | awk '{print $9}'
find $INDIR/ -type f -print | sed -e 's/^.......................//'

echo "";
echo -en "\033[32m имя файла с обратным слеш, если есть пробелы \033[40m"
echo -en "\E[0m";
echo "";
read N
R=$(ls /2TB/anon/move/torrent/Shrek.3.the.Third.2007.BDRip.x264.RG.tru.mkv | grep -oE "...$")
echo "";
echo -en "\033[32m  директория назначения \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/thriller \033[40m"
echo -en "\E[0m";
echo "";
read OUTD
if [ ! -d $OUTD ];
 then mkdir OUTD
fi
echo "";
echo -en "\033[32m имя конечного файла, исключая расширение \033[40m"
echo -en "\E[0m";
echo "";
read NOUT
ln -n $INDIR/$N $OUTD/$NOUT.$R
