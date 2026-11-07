#!/bin/bash
# Script to retrieve and print watchdog log messages from one or more
# hosts, given in the array below. Excludes the "ping OK" messages.
# By default, prints messages since yesterday, but a command line
# argument can be given to go back further. The argument is in
# the form "-Ndays", e.g. "-3days".
# J.Christensen 26Aug2026

# an array listing the hostnames to be checked
hosts=(cam1 cam2 cam3 z21 t1 pi42)

# ansi colors
CYAN='\033[0;36m'
NC='\033[0m'

# check for command line argument
if [ $1 ]; then
    since=$1
else
    since="yesterday"
fi

# loop once for each host
for h in ${hosts[*]}; do
    echo -e "\n${CYAN}#------ $h ------#${NC}"
    ssh $h "journalctl --since "$since" --grep \"wifi-watchdog:\"" | grep -v "ping OK"
done
echo
