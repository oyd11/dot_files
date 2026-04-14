#!/usr/bin/env bash

## MacOS - power parsing, very manual:
## TODO: return value that determines the colour in ScreenRC status line...

GBATT=$(pmset -g batt)

# NOTE: always keep "" around before greping, to avoid new-line removal!
GBATT1=$(echo "$GBATT" | grep 'Now drawing')
GBATT2=$(echo "$GBATT" | grep -v 'Now drawing')

#echo 1: $GBATT1
#echo 2: $GBATT2

src="$(echo $GBATT1 | grep 'Now drawing' | grep -o \''.\+'\' )" # drawing from power-source surrounded by ''
power_source=${src: 1: ${#src}-2}   # chop initial and final ' : funny old bash version for MACOS bash 3 versions.

battery_percentage="$(echo $GBATT2 | grep -oE '\d+\%' )"
st=$(echo "$GBATT2" | grep -oE '\%;.+;')
battery_status=${st: 3: ${#st}-4}
est=$(echo "$GBATT2" | grep -Eo ";[^;]+present:") # -> charging; 0:25
battery_est=${est: 2: ${#est}-11}

# Debug version:
#echo -n "src:$power_source|p1:$battery_status|p2:$battery_percentage|p3:$battery_est|E"

echo -n "$power_source|$battery_status|$battery_percentage|$battery_est"
