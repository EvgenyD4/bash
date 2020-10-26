#!/bin/bash
PW=$(pwd)
cd $PW
for i in *.dav
do
  ffmpeg -i "$i" -y -c copy "$i.mp4"
done
#-c:v libx264
rm *.dav
rm *.idx
cd $HOME
