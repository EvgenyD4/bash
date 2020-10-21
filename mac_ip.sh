#!/bin/bash
# A0:F3:C1:3B:6F:90
echo "";
echo " MAC: [ A0:F3:C1:3B:6F:90 ]"
read MAC1

##https://api.mylnikov.org/wifi/main.py/get?bssid=A0:F3:C1:3B:6F:90
curl --cookie /tmp/cookies.txt --cookie-jar /tmp/newcookies.txt -i -s -k -X 'POST' \
-H 'User-Agent: Dalvik/2.1.0 (Linux; U; Android 5.0.1; Nexus 5 Build/LRX22C)' -H 'Content-Type: application/x-www-form-urlencoded' \
"https://api.mylnikov.org/wifi/main.py/get?bssid=$MAC1" > /tmp/MAPS
echo "";
MAP1=`cat /tmp/MAPS | grep -oE "result*....." | sed 's/^........//'`
MAP2=`cat /tmp/MAPS | grep -oE "lat*................." | sed '2!d' | sed 's/^......//' | grep -oE "*.*[0-9]"`
MAP3=`cat /tmp/MAPS | grep -oE "lon*................." | sed 's/^......//' | grep -oE "*.*[0-9]"`

if [ "$MAP1" = 200 ]; then
echo "$MAP2"
echo "$MAP3"
echo "";
echo "https://www.google.ru/maps/@$MAP2,$MAP3,19z?hl=ru"
else
echo "Not found! At this time, safely."
fi
echo "";
