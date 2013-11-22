#!/bin/bash

#Se chequean los parametros
if [ $# -ne "2" ]
then
	echo "USO: ${0} <Host> <IP_servidor_simulacion>"
	exit 0
fi

#La IP de la maquina con la topologia
IP_DST=${2}
NOMBRE_CLIENTE=${1}

if [ "${NOMBRE_CLIENTE}" == "A"  ]
then
	TAP="tap64"
	HOST_IP="10.118.5.6"
	NETMASK="255.255.255.0"
	PORT_NUM="14258"

elif [ "${NOMBRE_CLIENTE}" == "B" ]
then
	TAP="tap65"
	HOST_IP="10.19.3.35"
	NETMASK="255.255.255.224"
	PORT_NUM="14369"

elif [ "${NOMBRE_CLIENTE}" == "C" ]
then
	TAP="tap66"
	HOST_IP="10.19.3.99"
	NETMASK="255.255.255.224"
	PORT_NUM="14147"

else
	echo "El primer parametro debe ser: 'A', 'B' o 'C'"
	exit 1
fi

#Crea una interfaz "tap" ethernet que va a ser usada por el tunel
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia IP_DST en otra ventana
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}

