#!/bin/bash

DURA=$1

XWININFO=$(xwininfo)
	read X < <(awk -F: '/Absolute upper-left X/{print $2}' <<< "$XWININFO")
	read Y < <(awk -F: '/Absolute upper-left Y/{print $2}' <<< "$XWININFO")
	read W < <(awk -F: '/Width/{print $2}' <<< "$XWININFO")
	read H < <(awk -F: '/Height/{print $2}' <<< "$XWININFO")

byzanz-record -c --duration=$DURA --x=$X --y=$Y --width=$W --height=$H sweet.gif 2>/dev/null
