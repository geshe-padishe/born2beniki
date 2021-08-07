uname --all
nproc --all | awk '{print("#CPU physical : "$0)}'
lscpu | grep 'Core(s)\|Socket\|CPU(s):      ' | grep -Eo '[0-9]{1,}' | tr '\n' ' ' | awk '{print("#vCPU : "$1 * $2 * $3)}'
free --mega | grep 'Mem' | awk '{printf("#Memory Usage: %s/%sMB (%.2f%%)\n", $3, $2, $3 / $2 * 100)}'
df --total | grep 'total' | awk '{printf("#Disk Usage: %.f/%.fGb (%s)\n", $3 / 1000, $2 / 1000000, $5)}'
top -bn1 | grep "Cpu(s)" | awk '{printf("#CPU load: %.1s%%\n", 100 - $8)}'
who -bs | cut -b 23-38 | awk '{print("#Last boot: "$0)}'
lines=`sudo lsblk | grep lvm | wc -l`;
if [ $lines -gt 0 ]
then
	echo "LVM use: yes"
else
	echo "LVM use: no"
fi
ss -st | grep TCP: | grep -o '[0-9]' | sed '1d' | head -1 | awk '{print("#Connexions TCP : "$0" ESTABLISHED")}'
who | wc -l | awk '{print("#User log: "$0)}'
(hostname -I | awk '{print("#Netowrk: IP "$0)}' | tr '\n' ' ' | sed 's/.$//';cat /sys/class/net/enp0s3/address | awk '{print("("$0")")}')
cat /var/log/auth.log | grep -a sudo | grep -a COMMAND | wc -l | awk '{print("#Sudo : "$0" cmd")}'
