#!/bin/bash
#clear
echo "";
echo -en "\033[32m создать линк на видео для minidlna \033[40m"
echo -en "\E[0m";
echo "";
sleep 2
INDIR='/2TB/anon/move/torrent'
ls -tr $INDIR
echo "";
echo -en "\033[32m имя файла. исходный \033[40m"
echo -en "\E[0m";
echo "";
read N
R=$(ls $INDIR/"$N" | grep -oE "...$")
echo "";
echo -en "\033[32m  директория назначения \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/comedy \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/fantasy \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/katastrofy \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/melodrama \033[40m"
echo "";
echo -en "\033[32m /2TB/move/en/film/thriller \033[40m"
echo "";
echo -en "\033[32m /2TB/move/ru/film/comedy \033[40m"
echo "";
echo -en "\033[32m /2TB/move/ru/film/melodrama \033[40m"
echo "";
echo -en "\033[32m /2TB/move/ru/film/the_USSR \033[40m"
echo "";
echo -en "\033[32m /2TB/move/ru/film/thriller \033[40m"
#echo "";
#echo -en "\033[32m /2TB/move/ru/film/thriller \033[40m"

echo -en "\E[0m";
echo "";
read OUTD
if [ ! -d "$OUTD" ];
 then mkdir -p $OUTD
fi
echo "";
echo -en "\033[32m имя конечного файла, исключая расширение \033[40m"
echo -en "\E[0m";
echo "";
read NOUT
ln -n $INDIR/"$N" $OUTD/$NOUT.$R
