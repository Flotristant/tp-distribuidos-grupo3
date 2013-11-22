#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_FTP_server>"
	exit 0
fi

IP=${1}
TAP="tap119"
TITULO="FTP_Server"
PORT_NUM="25147"
NETMASK="255.255.255.128"
IP_END_TUNNEL="10.19.2.10"

#Se crea una interfaz "tap" ethernet para cada cliente externo
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=${TITULO} -x sudo openvpn --remote ${IP} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${IP_END_TUNNEL} ${NETMASK}

