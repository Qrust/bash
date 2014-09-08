#!/bin/sh

if [ "$1" = "" ]; then
	echo "Usage: 4chan <board> <thread ID>"
	exit 1
fi

if [ "$2" = "" ]; then
	echo "Usage: 4chan <board> <thread ID>"
	exit 1
fi

echo "4chan downloader"
echo "Downloading until canceled or 404'd"
LOC=$(echo "$1-$2")
echo "Downloading to $LOC"

if [ ! -d $LOC ]; then
	mkdir $LOC
fi

cd $LOC

while [ "1" = "1" ]; do
	TMP=`mktemp`
	TMP2=`mktemp`

	wget -nv -O "$TMP" "https://boards.4chan.org/$1/thread/$2"

	if [ "$?" != "0" ]; then
		rm $TMP $TMP2
		exit 1
	fi

	egrep '//i.4cdn.org/[a-z0-9]+/([0-9]*).(jpg|png|gif|webm)' "$TMP" -o > "$TMP2"
	
	cat "$TMP2" | sed -e 's/^/https:/' $TMP2 > "$TMP"
	
	wget -nc -nv -i $TMP | sed 's/URL:https:\/\/i.4cdn.org\/g\//| /'
 
	rm $TMP $TMP2
 
	echo "Waiting 30 seconds before next run"
	sleep 30
done;
