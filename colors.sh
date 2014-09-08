#!/bin/bash
	echo -en "\t \e[0;0m e[0;0m ██ \e[0;1m ██ e[0;1 \n"
for line in {30..37} ; do
	echo -en "\t \e[0;${line}m e[0;$line ██ \e[1;${line}m ██ e[1;$line \n"
done
echo
exit 0
