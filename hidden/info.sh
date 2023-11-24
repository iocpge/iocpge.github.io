#!/bin/bash

# Get the hostname
NAME=$(hostname)

# Get the MAC address of the first network interface (eth0)
MAC=$(cat /sys/class/net/eth0/address)
#$(ifconfig -a | grep -o -E '([0-9a-fA-F]{2}:){5}([0-9a-fA-F]{2})' | head -n 1)

# Get the IPv4 address of the first network interface (eth0)
IPV4=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
#ipv4_address=$(ifconfig -a | awk '/inet /{print $2}' | head -n 1)

# Print the results
echo "Hostname: $NAME"
echo "MAC Address: $MAC"
echo "IPv4 Address: $IPV4"


# Email configuration
TO_EMAIL="iocpge@gmail.com"
SUBJECT="Network Information for $HOSTNAME"
BODY="Hostname: $NAME\nMAC Address: $MAC_ADDRESS\nIPv4 Address: $IP_ADDRESS"

# Send email using the mail command
echo -e "$BODY" | mail -s "$SUBJECT" "$TO_EMAIL"
