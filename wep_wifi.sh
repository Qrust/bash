#! /bin/bash
ifconfig wlan0 up
iwconfig wlan0 essid $1 key s:$2
sleep 10
dhclient wlan0
