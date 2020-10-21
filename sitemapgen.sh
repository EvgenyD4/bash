#!/bin/bash
echo " * sitemap gen *"
echo " URL: [http://192.168.0.5/]"
read UR
sitedomain="$UR"
#sitedomain=http://192.168.0.5/
DAT=$(date +%Y-%m-%d)
wget --no-check-certificate --spider --recursive --level=inf --no-verbose --output-file=/tmp/linklist.txt $sitedomain
grep -i URL /tmp/linklist.txt | awk -F 'URL:' '{print $2}' | awk '{$1=$1};1' | awk '{print $1}' | sort -u | sed '/^$/d' > /tmp/sortedurls.txt
header='<?xml version="1.0" encoding="UTF-8"?>'
echo $header > /tmp/sitemap.xml
head='<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
echo $head >> /tmp/sitemap.xml
while read p; do
  case "$p" in
  */ | *.html | *.htm)
    echo ' <url>' >> /tmp/sitemap.xml
    echo '  <loc>'$p'</loc>' >> /tmp/sitemap.xml
    echo '  <lastmod>'$DAT'</lastmod>' >> /tmp/sitemap.xml
    echo ' </url>' >> /tmp/sitemap.xml
    ;;
  *)
    ;;
 esac
done < /tmp/sortedurls.txt
echo "</urlset>" >> /tmp/sitemap.xml
mv /tmp/sitemap.xml /var/www/html/
cat /var/www/html/sitemap.xml
