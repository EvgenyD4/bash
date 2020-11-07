#!/bin/bash
echo " ffmpeg process..."
PW=$(pwd)
cd $PW
for i in *.h264
do
  ffmpeg -i "$i" -y -c:v libx264 -b:v 1000k "$i.mp4" \
 -hide_banner -threads 0 -strict -2 2>1&> /dev/null
done
##-hide_banner -threads 0 2>1&> /dev/null
##-c:v libx264
## -ac 2 -c:a aac -b:a 128k
##-c copy
sleep 1
j=0; for i in *.mp4; do let j+=1; mv $i file$j.mp4 ; done
sleep 1
find *.mp4 | sed 's:\ :\\\ :g'| sed 's/^/file /' > fl-ffmpeg.txt
 ffmpeg -f concat -i fl-ffmpeg.txt -c:a copy output.mp4 2>1&> /dev/null

sleep 1
rm fl-ffmpeg.txt
#rm *.dav 2> /dev/null
#rm *.idx 2> /dev/null
rm *.h264 2> /dev/null
rm file*
rm 1

cd $HOME
