# WifiView
# A tool which show the all wireless interfaces (on-board and adapters) with drivers and mode.
# Author - WireBits

#!/bin/bash
clear
printf "+--------------------------------------+\n"
printf "|---------╦ ╦╦╔═╗╦  ╦  ╦╦╔═╗╦ ╦--------|\n"
printf "|---------║║║║╠╣ ║  ╚╗╔╝║║╣ ║║║--------|\n"
printf "|---------╚╩╝╩╚  ╩   ╚╝ ╩╚═╝╚╩╝--------|\n"
printf "+--------------------------------------+\n"
printf "|Wireless Adapter Interface Information|\n"
printf "+--------------------------------------+\n"
printf "| %-10s | %-10s | %-10s |\n" "Interface" "Driver" "Mode"
printf "+--------------------------------------+\n"

wifi_interfaces=$(iwconfig 2>/dev/null | grep 'IEEE 802.11' | awk '{print $1}')

if [ -z "$wifi_interfaces" ]; then
    echo "No WiFi interfaces found."
    exit 1
fi

for interface in $wifi_interfaces; do
    driver=$(ethtool -i $interface 2>/dev/null | grep "driver" | awk '{print $2}')
    mode=$(iw $interface info | grep -E "type|mode" | awk '{print $2}')
    printf "| %-10s | %-10s | %-10s |\n" "$interface" "$driver" "$mode"
    printf "+--------------------------------------+\n"
done