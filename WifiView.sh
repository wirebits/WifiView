#!/bin/bash

# WifiView
# A tool which show the all wifi interfaces (on-board and adapters) with some basic details.
# Author - WireBits

clear
printf "+-------------------------------------------------------------+\n"
printf "|------------------╦ ╦╦╔═╗╦  ╦  ╦╦╔═╗╦ ╦----------------------|\n"
printf "|------------------║║║║╠╣ ║  ╚╗╔╝║║╣ ║║║----------------------|\n"
printf "|------------------╚╩╝╩╚  ╩   ╚╝ ╩╚═╝╚╩╝----------------------|\n"
printf "+-------------------------------------------------------------+\n"
printf "|-----------Wireless Adapter Interface Information------------|\n"
printf "+-------------------------------------------------------------+\n"
printf "|%-15s| %-10s| %-10s| %-20s|\n" "Interface" "Driver" "Mode" "Internet Access"
printf "+-------------------------------------------------------------+\n"

# Get all network interfaces and filter out WiFi interfaces
interfaces=$(ip -o link show | awk -F': ' '$2 ~ /^wlan[0-9]+$/ {print $2}')

if [ -z "$interfaces" ]; then
    echo "No network interfaces found."
    exit 1
fi

for interface in $interfaces; do
    driver=$(ethtool -i $interface 2>/dev/null | awk '/driver/ {print $2}')
    mode=$(iw $interface info | awk '/type|mode/ {print $2}')
    if [ -n "$mode" ]; then
        gateway=$(ip route show default | awk '/via/ {print $3}')
        internet_access=$(ip route get $gateway | grep -q $interface && echo "Yes" || echo "No")
        printf "|%-15s| %-10s| %-10s| %-20s|\n" "$interface" "$driver" "$mode" "$internet_access"
        printf "+-------------------------------------------------------------+\n"
    fi
done
