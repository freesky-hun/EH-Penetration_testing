#!/bin/bash
# Tested on pop-os 6.4.6-76060406 and kali 6.4.0

# Verify if 'nmap' is installed on the system.
if ! command -v nmap &> /dev/null
then
    echo "Error: nmap is not installed on the system."
    exit 1
fi

# Check for the correct command-line arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <IP> <min rate>"
    exit 1
fi


echo "[!] Starting scan"
echo
ports=$(nmap -p- --min-rate $2 $1 | grep 'open' | awk '{print $1}' | cut -d'/' -f1 | tr '\n' ',' | sed 's/,$//')
echo "[i] Open ports: $ports"
echo
echo "[!] Starting OS detection, version detection, script scanning, and traceroute"
echo
nmap -p $ports -A -v $1
echo
echo "[!] Starting aggressive vulnerability scan"
echo
nmap -p $ports -v --script vuln $1
