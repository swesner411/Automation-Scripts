#!/bin/bash

echo "============================"
echo "  GENERAL"
echo "============================"
echo ""

printf '%-25s %s\n' "Hostname:" "$(hostname)"
printf '%-25s %s\n' "OS:" "$(uname -o)"
printf '%-25s %s\n' "Kernel:" "$(uname -r)"
printf '%-25s %s\n' "Architecture:" "$(uname -m)"
printf '%-25s %s\n' "Uptime:" "$(uptime -p)"
printf '%-25s %s\n' "System Load (1/5/15 min):" "$(cat /proc/loadavg | awk '{print $1, $2, $3}')"

echo ""
echo "============================"
echo "  CPU"
echo "============================"
echo ""

lscpu | grep -E '^Model name|^CPU\(s\):|^Thread|^Core'

echo ""
echo "============================"
echo "  MEMORY"
echo "============================"
echo ""

free -h

echo ""
echo "============================"
echo "  DISK"
echo "============================"
echo ""

df -h --total | grep -E '^Filesystem|^total'

echo ""
echo "============================"
echo "  NETWORK"
echo "============================"
echo ""

printf "%-15s %-10s %-20s %-30s\n" "Interface" "Status" "IP Address" "DNS Server(s)"
printf "%-15s %-10s %-20s %-30s\n" "---------" "------" "----------" "-------------"

# Get all network interfaces except loopback
interfaces=$(ip -o link show | awk -F': ' '{print $2}' | grep -v lo)

for iface in $interfaces; do
    # Get interface status (up or down)
    status=$(cat /sys/class/net/$iface/operstate)

    # Get IP address (IPv4 only for simplicity)
    ip_addr=$(ip -4 addr show "$iface" | grep -oP '(?<=inet\s)\d+(\.\d+){3}' || echo "N/A")

    # Get DNS servers from resolv.conf (global, not per-interface unless using systemd-resolved)
    dns_servers=$(grep '^nameserver' /etc/resolv.conf | awk '{print $2}' | paste -sd "," -)

    # Print results
    printf "%-15s %-10s %-20s %-30s\n" "$iface" "$status" "$ip_addr" "$dns_servers"
done

echo ""
echo "============================"
echo "  USERS"
echo "============================"
echo ""

printf '%-25s %s\n' "Logged In User(s):" "$(who)"