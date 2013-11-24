#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_DNS_root>"
	exit 0
fi

IP=${1}
TAP="tap83"
TITULO="DNS_root"
PORT_NUM="14262"
NETMASK="255.255.255.192"
IP_END_TUNNEL="10.47.1.150"

#Se crea una interfaz "tap" ethernet para cada cliente externo
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=${TITULO} -x sudo openvpn --remote ${IP} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${IP_END_TUNNEL} ${NETMASK}

