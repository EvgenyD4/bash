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

find *.mp4 | sed 's:\ :\\\ :g'| sed 's/^/file /' > /tmp/fl-ffmpeg.txt; ffmpeg -f concat \
 -i /tmp/fl-ffmpeg.txt -c copy ./output.mp4; rm /tmp/fl-ffmpeg.txt

#rm *.dav 2> /dev/null
#rm *.idx 2> /dev/null
rm *.h264 2> /dev/null
rm *.mp4 2> /dev/null

cd $HOME
