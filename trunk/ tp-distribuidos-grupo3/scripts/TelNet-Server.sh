#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web> <dns1> <dns2> <dnsroot>"
	exit 0
fi


SERVER_TEL_IP_N=${1}
#SERVER_TEL_IP_N="192.168.50.3"      #..descomentar para automatizar conexion LAN
SERVER_TEL_PORT_N="32561"
SERVER_TEL_NETMASK_N="255.255.255.128"
SERVER_TEL_IP_TUNNEL_N="10.47.1.130"
SERVER_TEL_TAP_NUMBER_N="tap321"


#TELServer
sudo openvpn --mktun --dev ${SERVER_TEL_TAP_NUMBER}
sudo ifconfig ${SERVER_TEL_TAP_NUMBER} 0.0.0.0 promisc up

sudo openvpn --mktun --dev ${SERVER_TEL_TAP_NUMBER}
sudo ifconfig ${SERVER_TEL_TAP_NUMBER} 0.0.0.0 promisc up


gnome-terminal --title=TELServer_N -x sudo openvpn --remote ${SERVER_TEL_IP_N} --port ${SERVER_TEL_PORT_N} --dev ${SERVER_TEL_TAP_NUMBER_N} --ifconfig ${SERVER_TEL_IP_TUNNEL_N} ${SERVER_TEL_NETMASK_N}
gnome-terminal --title=TELServer_ENIE -x sudo openvpn --remote ${SERVER_TEL_IP_ENIE} --port ${SERVER_TEL_PORT_ENIE} --dev ${SERVER_TEL_TAP_NUMBER_ENIE} --ifconfig ${SERVER_TEL_IP_TUNNEL_ENIE} ${SERVER_TEL_NETMASK_ENIE}
