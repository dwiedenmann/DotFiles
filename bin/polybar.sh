#!/bin/sh
polybarconf="$HOME/.config/polybar/polybar.conf"

killall polybar
polybar top     -c "$polybarconf" &
polybar bottom  -c "$polybarconf" &
polybar left    -c "$polybarconf" &
polybar right   -c "$polybarconf" &

