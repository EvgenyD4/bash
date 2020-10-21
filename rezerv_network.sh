#!/bin/sh
while true; do

# Доступность этого хоста будет означать корректную работу оснвного канала
# 8.8.8.8 это DNS от Google. За его доступность можно не беспокоиться
# А значит вероятность ложного срабатывания минимальна
HOST="8.8.8.8"

# Файл-флаг. Появляется при переключении на резервный канал
LOCKFILE="/tmp/check_internet.lock"

# Файл журнала
LOGFILE="/var/log/check_internet.log"

# Пингуем проверочный хост через основной канал
ping -I enp1s0 -c 5 -n -q ${HOST} > /dev/null

# Если возникла ошибка (хост не доступен)
if [ $? -ne "0" ]; then
	# Если нет файла-флага
        if [ ! -f ${LOCKFILE} ]; then
		# Доббавляем маршрут для пинга основного канала
#		sudo route add 8.8.8.8/32 gw 192.168.0.1
		# Меняем маршрут по умолчанию в основной таблице роутинга
#                sudo ip route del default
#                sudo ip route add default dev enp0s26u1u1 metric 100
#		sudo ip route add default via 192.168.2.1 metric 100
		# NAT 4G
#		sudo iptables-restore < /iptables.usb
		# restart squid
#		/sh/squid-restart.sh
#		sleep 10
                # Создаём файл флаг
                sudo touch ${LOCKFILE}
                # Делаем запись в файл журнала
#		IP=$(curl -s http://whatismijnip.nl |cut -d " " -f 5)
#                echo `date +'%Y/%m/%d %H:%M:%S'` $IP changed to 4G >> ${LOGFILE}
                echo `date +'%Y/%m/%d %H:%M:%S'` error rostelecom >> ${LOGFILE}
		sudo chmod 777 /var/log/check_internet.log
		/sh/send-changed-4G.sh
		sleep 50
        fi
# Если же всё хорошо
else
	# Если есть файл-флаг
        if [ -f ${LOCKFILE} ]; then
		# Меняем маршрут по умолчанию в основой таблице роутинга
#                sudo ip route del default
#                sudo ip route add default via 192.168.0.1 metric 100
		# NAT LAN
#		sudo iptables-restore < /iptables.lan
		# restart squid
#		/sh/squid-restart.sh
#		sleep 10
                # Удаляем файл-флаг
                sudo rm -rf ${LOCKFILE}
                # Записываем событие в файл журнала
                IP=$(curl -s http://whatismijnip.nl |cut -d " " -f 5)
                echo `date +'%Y/%m/%d %H:%M:%S'` $IP changed to LAN >> ${LOGFILE}
		sudo chmod 777 /var/log/check_internet.log
		/sh/send-changed-LAN.sh
		sleep 50
        fi
fi


done





#!/bin/bash
IP=$(tail -n 1 /var/log/check_internet.log)
echo -e "Subject: NAS 4G\n\n '$IP'" | /usr/sbin/ssmtp user@gmail.com &


#!/bin/bash
IP=$(tail -n 1 /var/log/check_internet.log)
echo -e "Subject: NAS LAN\n\n '$IP'" | /usr/sbin/ssmtp user@gmail.com &
