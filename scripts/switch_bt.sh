#!/bin/bash
#bt enable/disable script

/etc/init.d/bluetooth status

if [ "$?" -ne 0 ]; then
	/etc/init.d/bluetooth start > /dev/null
	echo enabled > /proc/acpi/ibm/bluetooth
	echo "Bluetooth enabled"
else
	/etc/init.d/bluetooth stop > /dev/null
	echo disabled > /proc/acpi/ibm/bluetooth
	echo "Bluetooth disabled"
fi
