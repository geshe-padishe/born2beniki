uname --all
nproc --all | awk '{print("#CPU physical : "$0)}'
lscpu | grep 'Core(s)\|Socket\|CPU(s):      ' | grep -Eo '[0-9]{1,}' | tr '\n' ' ' | awk '{print("#vCPU : "$1 * $2 * $3)}'
free --mega | grep 'Mem' | awk '{print("#Memory Usage: "$3"/"$2"MB ("$3/$2*100"%)")}'
df --total -H | grep 'total'
