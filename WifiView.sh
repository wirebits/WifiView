#!/bin/bash

# WifiView
# A tool which show the all wifi interfaces (on-board and adapters) with some basic details.
# Author - WireBits

clear
printf "+------------------------------------------------+\n"
printf "|--------------╦ ╦╦╔═╗╦  ╦  ╦╦╔═╗╦ ╦-------------|\n"
printf "|--------------║║║║╠╣ ║  ╚╗╔╝║║╣ ║║║-------------|\n"
printf "|--------------╚╩╝╩╚  ╩   ╚╝ ╩╚═╝╚╩╝-------------|\n"
printf "+------------------------------------------------+\n"
printf "|-----Wireless Adapter Interface Information-----|\n"
printf "+------------------------------------------------+\n"
printf "| %-15s | %-10s | %-15s |\n" "Interface" "Mode" "Internet Access"
printf "+------------------------------------------------+\n"

interfaces=$(ip -o link show | awk -F': ' '$2 ~ /^wlan[0-9]+$/ {print $2}')

if [ -z "$interfaces" ]; then
    echo "No wireless interfaces found."
    exit 1
fi

for interface in $interfaces; do
    mode=$(iw dev $interface info | awk '/type/ {print $2}')
    
    if ping -I "$interface" -c 1 -W 1 8.8.8.8 &>/dev/null; then
        internet_access="Yes"
    else
        internet_access="No"
    fi

    printf "| %-15s | %-10s | %-15s |\n" "$interface" "$mode" "$internet_access"
    printf "+------------------------------------------------+\n"
done
