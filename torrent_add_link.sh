#!/bin/bash
clear
echo "";
echo " создать линк на видео"
echo " для minidlna"
sleep 2
INDIR='/2TB/anon/move/torrent'
find $INDIR/ -type f -print | sed -e 's/^.......................//'
echo " имя файла с обратным слеш, если есть пробелы"
read N
echo " директория назначения"
echo "/2TB/move/en/film/thriller"
read OUTD
if [ ! -d $OUTD ];
 then mkdir OUTD
fi
echo " имя конечного файла, включая исходное расширение"
read NOUT
ln -n $INDIR/$N $OUTD/$NOUT
