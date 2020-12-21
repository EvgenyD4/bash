#!/bin/bash
echo "           HDD Test S.M.A.R.T" > /tmp/hdd.txt
echo "         `date`" >> /tmp/hdd.txt
# Check if packages are installed
cat <<EOF >/tmp/inst_deb.txt;
trickle
rsync
smartmontools

EOF
for P in $(cat /tmp/inst_deb.txt);
do
 if ! dpkg --get-selections $P 2> /dev/null | grep -oE install &> /dev/null;
  then sudo apt install $P;
 fi;
done

#echo "  System 60 Gb"
SDA0=$(sudo smartctl -s on -a /dev/sdb | grep "Power_On_Hours" | awk '{print $10}')
SDA1=$(sudo smartctl -s on -a /dev/sdb | grep "Reallocated_Event_Count" | awk '{print $10}')
SDA2=$(sudo smartctl -s on -a /dev/sdb | grep "Reallocated_Sector_Ct" | awk '{print $10}')
#echo "  320 Gb"
SDB0=$(sudo smartctl -s on -a /dev/sda | grep "Power_On_Hours" | awk '{print $10}')
SDB1=$(sudo smartctl -s on -a /dev/sda | grep "Reallocated_Event_Count" | awk '{print $10}')
SDB2=$(sudo smartctl -s on -a /dev/sda | grep "Reallocated_Sector_Ct" | awk '{print $10}')
##echo "  120 Gb"
#SDC0=$(sudo smartctl -s on -a /dev/sda | grep "Power_On_Hours" | awk '{print $10}')
#SDC1=$(sudo smartctl -s on -a /dev/sda | grep "Reallocated_Event_Count" | awk '{print $10}')
#SDC2=$(sudo smartctl -s on -a /dev/sda | grep "Reallocated_Sector_Ct" | awk '{print $10}')
##echo "  750 Gb"
#SDD0=$(sudo smartctl -s on -a /dev/sdb | grep "Power_On_Hours" | awk '{print $10}')
#SDD1=$(sudo smartctl -s on -a /dev/sdb | grep "Reallocated_Event_Count" | awk '{print $10}')
#SDD2=$(sudo smartctl -s on -a /dev/sdb | grep "Reallocated_Sector_Ct" | awk '{print $10}')

printf "1 000 Gb Power_On\t%s\tEvent\t%s\tReallocated\t%s\n" $SDA0 $SDA1 $SDA2 >> /tmp/hdd.txt
printf "2 000 Gb Power_On\t%s\tEvent\t%s\tReallocated\t%s\n" $SDB0 $SDB1 $SDB2 >> /tmp/hdd.txt
#printf "120 Gb Power_On\t%s\tEvent\t%s\tReallocated\t%s\n" $SDC0 $SDC1 $SDC2 >> /tmp/hdd.txt
#printf "750 Gb Power_On\t%s\tEvent\t%s\tReallocated\t%s\n" $SDD0 $SDD1 $SDD2 >> /tmp/hdd.txt
sudo chmod 777 /tmp/hdd.txt
