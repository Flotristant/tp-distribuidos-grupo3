#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
	echo "USO: ${0} <server> <IP_servidor_simulacion>"
	exit 0
fi

#Donde esta el servidor de simulacion
IP_DST=${2}
NOMBRE_CLIENTE=${1}


if [ "${NOMBRE_CLIENTE}" == "WEBSERVER" ]
then
	TAP="tap118"
	HOST_IP="192.168.71.71"
	NETMASK="255.255.255.0"
	PORT_NUM="25369"

elif [ "${NOMBRE_CLIENTE}" == "FTPSERVER" ]
then
	TAP="tap119"
	HOST_IP="10.19.2.1"
	NETMASK="255.255.255.128"
	PORT_NUM="25147"

elif [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
	#Esta seria la red N
	TAP="tap321"
	HOST_IP="10.47.1.130"
	NETMASK="255.255.255.128"
	PORT_NUM="32561"

	#Esta seria la red ENIE
	TAP_2="tap654"
	HOST_IP_2="10.47.2.129"
	NETMASK_2="255.255.254.0"
	PORT_NUM_2="32516"

else
	echo "El server debe ser: 'WEBSERVER', 'FTPSERVER' o 'TELSERVER'"
	exit 1
fi


#Crea una interfaz "tap" ethernet que va a ser usada por el tunel
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia una IP_DST en otra ventana
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}


#Si es un servidor TELnet hay que abrir otro tunel
if [ "${NOMBRE_CLIENTE}" == "TEL" ]
then
	sudo openvpn --mktun --dev ${TAP_2}
	sudo ifconfig ${TAP_2} 0.0.0.0 promisc up
	gnome-terminal --title="TEL_2" -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM_2} --dev ${TAP_2} --ifconfig ${HOST_IP_2} ${NETMASK_2}
fi

exit 0

