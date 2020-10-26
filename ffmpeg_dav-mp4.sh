#!/bin/bash
PW=$(pwd)
cd $PW
for i in *.h264
do
  ffmpeg -i "$i" -y -c:v libx264 -b:v 1000k "$i.mp4" -hide_banner -threads 0 -strict -2 2> /dev/null
done
#-hide_banner -threads 0 2> /dev/null
#-c:v libx264
#-c copy
rm *.dav 2> /dev/null
rm *.idx 2> /dev/null
rm *.h264 2> /dev/null
cd $HOME
