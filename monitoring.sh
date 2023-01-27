#!/bin/bash
# Colores ----------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[1;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[1;0m' # Default Color
#-------------------------------------------------------
echo "\n"
echo "	Broadcast message from root@wil (tty1) (Sun Apr 25 15:45:00 2021):"
echo "\n"
echo "		${PURPLE}#Architecture: ${NC}"`uname -a`
echo "		${PURPLE}#CPU physical: ${NC}"`getconf _NPROCESSORS_ONLN`
echo "		${PURPLE}#vCPU: ${NC}"`lscpu | grep '^CPU(s):' | awk '{print $2}'`
echo "		${PURPLE}#Memory Usage: ${NC}"`free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)", $3, $2, $3*100/$2}'`
echo "		${PURPLE}#Disk Usage: ${NC}"`df --total -h | grep total | awk '{printf("%s/%sb (%s)", $3, $2, $5)}'`
echo "		${PURPLE}#CPU load: ${NC}"`mpstat | grep all | awk '{printf ("%.1f%%", 100-$13)}'`
echo "		${PURPLE}#Last boot: ${NC}"`who -b | awk '{printf("%s %s", $3, $4)}'`
echo "		${PURPLE}#LVM use: ${NC}"`lsblk | grep lvm | wc -l | awk '{if($1) printf("yes"); else printf("no")}'`
echo "		${PURPLE}#Connections TCP: ${NC}"`netstat | grep tcp | grep ESTABLISHED | wc -l`" ESTABLISHED"
echo "		${PURPLE}#User log: ${NC}"`who | awk '{print $1}' | sort -u | wc -l`
echo "		${PURPLE}#Network: IP: ${NC}"`hostname -I``ip link show | grep link/ether | awk '{printf("(%s)", $2)}'`
echo "		${PURPLE}#Sudo: ${NC}"`cat /var/log/sudo/sudo-log | grep COMMAND | wc -l`" cmd"
