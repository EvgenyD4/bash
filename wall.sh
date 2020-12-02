#!/bin/bash
#
# Check if packages are installed
pwd
cat <<EOF >/tmp/inst_deb.txt;
exiv2
imagemagick

EOF
for P in $(cat /tmp/inst_deb.txt);
 do echo " check install [ $P ]";
  if ! dpkg --get-selections $P 2> /dev/null | grep -oE install &> /dev/null;
   then sudo apt install $P;
  fi;
 done
src_dir=${1-`pwd`}	# По умолчанию используется текущий каталог
dst_dir=/320/Photo	# Каталог в который будут скопированны обработанные
tmp_dir=/320/tmp/.wall
SZ1='768'
SZ2='1024'
SZ3='1080'
SZ4='1200'
#SZ5=''
#2160
#quality=100  # Качество JPG изображения
#resize=1920x1080 # Размер после конвертации

## Checking if a directory exists
if [ -d $tmp_dir ];
 then find "$src_dir" -type f \( -name "*.jpeg" -or -name "*.jpg" \) -exec cp '{}' $tmp_dir \;
 else mkdir /320/tmp/.wall
      find "$src_dir" -type f \( -name "*.jpeg" -or -name "*.jpg" \) -exec cp '{}' $tmp_dir \;
fi

# Checking if a directory exists
if [ -d $dst_dir ];
 then cd $tmp_dir
# удалить пробелы в текущей директории
#for f in *\ *; do mv "$f" "${f// /_}"; done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
#-gt больше
#-ge больше или равно
#-eq равно
#-le меньше или равно
#-lt меньше
   if [ $S1 -eq $SZ1 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ1 &> /dev/null;
      then mv $f $dst_dir/$SZ1/
      else mkdir $dst_dir/$SZ1/
           mv $f $dst_dir/$SZ1/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ2 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ2 &> /dev/null;
      then mv $f $dst_dir/$SZ2/
      else mkdir $dst_dir/$SZ2/
           mv $f $dst_dir/$SZ2/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ3 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ3 &> /dev/null;
      then mv $f $dst_dir/$SZ3/
      else mkdir $dst_dir/$SZ3/
           mv $f $dst_dir/$SZ3/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ4 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ4 &> /dev/null;
      then mv $f $dst_dir/$SZ4/
      else mkdir $dst_dir/$SZ4/
           mv $f $dst_dir/$SZ4/
    fi
   fi
  done
# jpeg
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ1 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ1 &> /dev/null;
      then mv $f $dst_dir/$SZ1/
      else mkdir $dst_dir/$SZ1/
           mv $f $dst_dir/$SZ1/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ2 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ2 &> /dev/null;
      then mv $f $dst_dir/$SZ2/
      else mkdir $dst_dir/$SZ2/
           mv $f $dst_dir/$SZ2/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ3 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ3 &> /dev/null;
      then mv $f $dst_dir/$SZ3/
      else mkdir $dst_dir/$SZ3/
           mv $f $dst_dir/$SZ3/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ4 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ4 &> /dev/null;
      then mv $f $dst_dir/$SZ4/
      else mkdir $dst_dir/$SZ4/
           mv $f $dst_dir/$SZ4/
    fi
   fi
  done

 else mkdir /320/Photo
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
#-gt больше
#-ge больше или равно
#-eq равно
#-le меньше или равно
#-lt меньше
   if [ $S1 -eq $SZ1 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ1 &> /dev/null;
      then mv $f $dst_dir/$SZ1/
      else mkdir $dst_dir/$SZ1/
           mv $f $dst_dir/$SZ1/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ2 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ2 &> /dev/null;
      then mv $f $dst_dir/$SZ2/
      else mkdir $dst_dir/$SZ2/
           mv $f $dst_dir/$SZ2/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ3 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ3 &> /dev/null;
      then mv $f $dst_dir/$SZ3/
      else mkdir $dst_dir/$SZ3/
           mv $f $dst_dir/$SZ3/
    fi
   fi
  done
  for f in *.jpg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ4 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ4 &> /dev/null;
      then mv $f $dst_dir/$SZ4/
      else mkdir $dst_dir/$SZ4/
           mv $f $dst_dir/$SZ4/
    fi
   fi
  done
# jpeg
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ1 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ1 &> /dev/null;
      then mv $f $dst_dir/$SZ1/
      else mkdir $dst_dir/$SZ1/
           mv $f $dst_dir/$SZ1/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ2 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ2 &> /dev/null;
      then mv $f $dst_dir/$SZ2/
      else mkdir $dst_dir/$SZ2/
           mv $f $dst_dir/$SZ2/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ3 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ3 &> /dev/null;
      then mv $f $dst_dir/$SZ3/
      else mkdir $dst_dir/$SZ3/
           mv $f $dst_dir/$SZ3/
    fi
   fi
  done
  for f in *.jpeg; do
   S1=$(exiv2 $f 2> /dev/null | grep "Image size" | grep -oE "x.*" | sed 's/^..//g')
   if [ $S1 -eq $SZ4 ] 2>1&> /dev/null;
    then if ls $dst_dir | grep -o $SZ4 &> /dev/null;
      then mv $f $dst_dir/$SZ4/
      else mkdir $dst_dir/$SZ4/
           mv $f $dst_dir/$SZ4/
    fi
   fi
  done
fi

#exiv2 /320/images/wall/Models/011.jpeg | grep "Image size" | grep -o '1600'
#if [ -z "$photo_date" ] ; then # Если в exif дата не найдена ищем в названии файла; fi
#convert -quality "$quality" -resize "$resize"\> -verbose "$file" "$dst_dir/$1/$2/$1-$2-$3_$4-$5-$6.jpg"

# Ищем JPG файлы в указанной папке и всех подпапках!
#find "$src_dir" -iname "*.jpg" | sort | while IFS= read -r file ; do
