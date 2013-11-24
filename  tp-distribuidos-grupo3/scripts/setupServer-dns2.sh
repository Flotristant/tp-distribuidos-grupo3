#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web> <dns1> <dns2> <dnsroot>"
	exit 0
fi

DNS2_IP=${1}
#DNS2_IP="192.168.50.12"   #..descomentar para automatizar conexion LAN
DNS2_PORT="14261"
DNS2_NETMASK="255.255.255.128"
DNS2_IP_TUNNEL="10.19.2.1"
DNS2_TAP_NUMBER="tap82"

#DNS 2
sudo openvpn --mktun --dev ${DNS2_TAP_NUMBER}
sudo ifconfig ${DNS2_TAP_NUMBER} 0.0.0.0 promisc up

gnome-terminal --title=DNS2 -x sudo openvpn --remote ${DNS2_IP} --port ${DNS2_PORT} --dev ${DNS2_TAP_NUMBER} --ifconfig ${DNS2_IP_TUNNEL} ${DNS2_NETMASK}
