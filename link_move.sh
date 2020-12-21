#!/bin/bash
ls -tr /2TB/anon/move/torrent/
echo "   чтобы продолжить, [Enter]"
read U

DIALOG=${DIALOG=dialog}
dialog --title 'ln_n_minidlna.sh' --msgbox 'Для навигации использовать стрелки, для выбора файла \ директории [пробел]' 10 60
TM=$($DIALOG --stdout --title "Выберите файл" --fselect /2TB/anon/move/torrent/ 10 60)
case $? in
    0)
        echo "Выбран " "$TM"
        R=$(ls "$TM" | grep -oE "...$")
        tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
        trap "rm -f $tempfile" 0 1 2 5 15

        $DIALOG --title "Ввод данных" --clear \
         --inputbox "Заменить название фильма на привычные имена\nВведите новое файла имя:" 16 51 2> $tempfile

        retval=$?

        case $retval in
        0)
         file=`cat $tempfile`
         TS=$($DIALOG --stdout --title "(в конце не должно быть знака слеш [/])" --fselect /2TB/move/ 10 60)
         case $? in
         0)
           echo "Выбран " "$TS"
           ln -n "$TM" "$TS"/"$file".$R
           ls $TS;;
         1)
           echo "Отказ от ввода.";;
         255)
           echo "Нажата клавиша ESC.";;
         esac

        ;;
    1)
        echo "Отказ от ввода.";;
    255)
        echo "Нажата клавиша ESC.";;
esac

         ;;
       1)
         echo "Отказ от ввода.";;
       255)
         if test -s $tempfile ; then
         cat $tempfile
         else
         echo "Нажата клавиша ESC."
        fi
        ;;
esac
