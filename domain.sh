#!/bin/bash

# Check root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root!"
   exit 1
fi

if [ "$(systemd-detect-virt)" == "openvz" ]; then
   echo "OpenVZ is not supported!"
   exit 1
fi

# Get domain
clear
echo -e ""
read -p "Please enter your domain : " domain
echo -e ""
ip=$(wget -qO- ipv4.icanhazip.com)
domain_ip=$(ping "${domain}" -c 1 | sed '1{s/[^(]*(//;s/).*//;q}')
if [[ ${domain_ip} == "${ip}" ]]; then
	echo -e "IP matched with the server. The installation will continue."
	sleep 2
	clear
else
	echo -e "IP does not match with the server. Make sure to point A record to your server."
	echo -e ""
	exit 1
fi
