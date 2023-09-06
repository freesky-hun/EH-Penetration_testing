#!/bin/bash

# Check for the correct command-line arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <IP> <start_port> <end_port>"
    exit 1
fi

target_ip="$1"
start_port="$2"
end_port="$3"

echo "Port scanning target: $target_ip"
echo "Scanning ports $start_port through $end_port..."

# Function to check a port
scan_port() {
    port="$1"
    (echo >/dev/tcp/$target_ip/$port) 2>/dev/null && echo "Port $port is open"
}

# Main program
for ((port = start_port; port <= end_port; port++)); do
    scan_port $port &
done

wait

echo "Scanning completed."