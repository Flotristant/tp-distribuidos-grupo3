#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
	echo "USO: ${0} <nombre_cliente> <IP_servidor_simulacion>"
	exit 0
fi

#Las variables que entran por linea de comando 
IP_DST=${2}
echo "IP donde esta corriendo la simulación: ${IP_DST}"

#Configura el cliente indicado
if [ "${1}" == "HostA"  ]
then
	TAP="tap64"
	HOST_IP="10.118.5.6"
	NETMASK="255.255.255.0"

elif [ "${1}" == "HostB" ]
then
	TAP="tap65"
	HOST_IP="10.19.3.35"
	NETMASK="255.255.255.224"

elif [ "${1}" == "HostC" ]
then
	TAP="tap66"
	HOST_IP="10.19.3.99"
	NETMASK="255.255.255.224"

elif [ "${1}" == "WebServer" ]
then
	TAP="tap118"
	HOST_IP="192.168.71.71"
	NETMASK="255.255.255.0"

elif [ "${1}" == "FTPServer" ]
then
	TAP="tap119"
	HOST_IP="10.19.2.1"
	NETMASK="255.255.255.128"

else
	echo "No es uno de los servicios esperados"
	exit 1
fi

#Crea un tunel ethernet 
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia una IP_DST
sudo openvpn --remote ${IP_DST} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}



