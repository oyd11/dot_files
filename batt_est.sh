#!/usr/bin/env bash
# Linux: full style battery info line, including Estimation
# Example output:
# discharging|98%|2,0 hours|h(ealth):96,7386%

all="$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)"

l1=$(echo "${all}" | grep 'state:')
l2=$(echo "${all}" | grep 'percentage:')
l3=$(echo "${all}" | grep -E 'time to .*:')
l4=$(echo "${all}" | grep -E 'capacity:')
#  state:               charging
# percentage:          25%
state=$(echo "${l1}" | grep -Eo ":.+$" | grep -Eo "\S*$")
#state=${state:3}
percentage=$(echo "${l2}" | grep -Eo ":.+$" | grep -Eo "[0-9].*$")
#percentage=${percentage:3}
time_to_full=$(echo "${l3}" | grep -Eo ":.+$" | grep -Eo "[0-9].*$")
#time_to_full=${time_to_full:3}
health=$(echo "${l4}" | grep -Eo ":.+$" | grep -Eo "[0-9].*$")

#
echo -n "$state|$percentage|$time_to_full|h:$health"
