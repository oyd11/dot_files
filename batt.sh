#!/usr/bin/env bash

onAc=`cat /sys/class/power_supply/AC/online`
bat_status=`cat /sys/class/power_supply/BAT0/status`

firstCharacter=${bat_status:0:1}

echo -n $firstCharacter~
if (( $onAc == 1 )); then
      echo -n AC
fi

bat_level=`cat /sys/class/power_supply/BAT0/capacity`
echo $bat_level

