uname --all
nproc --all | awk '{print("#CPU physical : "$0)}'
lscpu | grep 'Core(s)\|Socket\|CPU(s):      ' | grep -Eo '[0-9]{1,}' | tr '\n' ' ' | awk '{print("#vCPU : "$1 * $2 * $3)}'
free --mega | grep 'Mem' | awk '{print("#Memory Usage: "$3"/"$2"MB ("$3/$2*100"%)")}'
df --total -H | grep 'total'
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}' | awk '{print("#CPU load: "$0)}'
who -bs | cut -b 23-38 | awk '{print("#Last boot: "$0)}'
ss -ta state established | grep "EST" | wc -l | awk '{print("#Connexions TCP : "$0" ESTABLISHED")}'
who | wc -l | awk '{print("#User log: "$0)}'
hostname -I ; cat /sys/class/net/enp0s3/address
cat /var/log/auth.log | grep -a sudo | grep -a COMMAND | wc -l
