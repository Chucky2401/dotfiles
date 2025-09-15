#!/usr/bin/env bash

fortistatus=$(forticlient vpn status |
  grep -E "^  VPN name|^  IP|^  Duration|^  Username" |
  sed -E "s|^ +||")

vpnname=$(echo "$fortistatus" | grep "VPN name")
ip=$(echo "$fortistatus" | grep "IP")
duration=$(echo "$fortistatus" | grep "Duration")
username=$(echo "$fortistatus" | grep "Username" | sed -E 's|Username: ||')

tooltip="${vpnname}\n${ip}\n${duration}"

echo "{\"alt\": \"${username}\", \"tooltip\": \"${tooltip}\", \"class\": \"${username}\"}" | jq --unbuffered --compact-output
