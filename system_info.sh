#!/bin/bash

upinfo ()
{
  echo -ne "\t ";uptime | awk /'up/ {print $3,$4,$5,$6,$7,$8,$9,$10}'
}

FGNAMES=('██' '██' '██' '██' '██' '██' '██' '██')

for b in $(seq 0 0); do
  if [ "$b" -gt 0 ]; then
    bg=$(($b+39))
  fi  
  for f in $(seq 0 7); do
    echo -en "\033[${bg}m\033[$(($f+30))m ${FGNAMES[$f]} "
    echo -en "\033[${bg}m\033[1;$(($f+30))m ${FGNAMES[$f]} "
  done
  echo -ne "\n\n${red}Today is:\t\t${cyan}" `date`; echo ""
  echo -e "${red}Kernel Information: \t${cyan}" `uname -smr`
  echo -ne "${red}Uptime is: \t${cyan}";upinfo;echo ""
  echo -e "\033[0m"  
done

