#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_Telnet_server>"
	exit 0
fi

IP_N=${1}
TAP_N="tap321"
TITULO_N="Telnet_N"
PORT_NUM_N="14363"
NETMASK_N="255.255.255.128"
IP_END_TUNNEL_N="10.47.1.140"

IP_ENIE=${1}
TAP_ENIE="tap654"
TITULO_ENIE="Telnet_ENIE"
PORT_NUM_ENIE="14364"
NETMASK_ENIE="255.255.254.0"
IP_END_TUNNEL_ENIE="10.47.2.139"

#Se crea una interfaz "tap" ethernet para cada cliente externo
sudo openvpn --mktun --dev ${TAP_N}
sudo ifconfig ${TAP_N} 0.0.0.0 promisc up

sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=${TITULO_N} -x sudo openvpn --remote ${IP_N} --port ${PORT_NUM_N} --dev ${TAP_N} --ifconfig ${IP_END_TUNNEL_N} ${NETMASK_N}

gnome-terminal --title=${TITULO_ENIE} -x sudo openvpn --remote ${IP_ENIE} --port ${PORT_NUM_ENIE} --dev ${TAP_ENIE} --ifconfig ${IP_END_TUNNEL_ENIE} ${NETMASK_ENIE}


