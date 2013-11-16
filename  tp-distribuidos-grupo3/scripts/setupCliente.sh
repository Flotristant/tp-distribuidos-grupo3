#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
	echo "USO: ${0} <nombre_cliente> <IP_servidor_simulacion>"
	exit 0
fi

#Las variables que entran por linea de comando 
IP_DST=${2}
NOMBRE_CLIENTE=${1}
echo "IP donde esta corriendo la simulación: ${IP_DST}"

#Configura el cliente indicado
if [ "${NOMBRE_CLIENTE}" == "HostA"  ]
then
	TAP="tap64"
	HOST_IP="10.118.5.6"
	NETMASK="255.255.255.0"
	PORT_NUM="14258"
    DEFAULT_GATEWAY="10.118.5.1"    #R1

elif [ "${NOMBRE_CLIENTE}" == "HostB" ]
then
	TAP="tap65"
	HOST_IP="10.19.3.35"
	NETMASK="255.255.255.224"
	PORT_NUM="14369"
    DEFAULT_GATEWAY="10.19.3.33"    #R6

elif [ "${NOMBRE_CLIENTE}" == "HostC" ]
then
	TAP="tap66"
	HOST_IP="10.19.3.99"
	NETMASK="255.255.255.224"
	PORT_NUM="14147"
    DEFAULT_GATEWAY="10.19.3.97"    #R13

elif [ "${NOMBRE_CLIENTE}" == "WebServer" ]
then
	TAP="tap118"
	HOST_IP="192.168.71.71"
	NETMASK="255.255.255.0"
	PORT_NUM="25369"
    DEFAULT_GATEWAY="192.168.71.3"  #R-virtual

elif [ "${NOMBRE_CLIENTE}" == "FTPServer" ]
then
	TAP="tap119"
	HOST_IP="10.19.2.1"
	NETMASK="255.255.255.128"
	PORT_NUM="25147"
    DEFAULT_GATEWAY="10.19.2.5"     #R10

else
	echo "No es uno de los servicios esperados"
	exit 1
fi

#Crea una interfaz "tap" ethernet que va a ser usada por el tunel
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia una IP_DST en otra ventana
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}

#No estoy seguro si esta entrada en la tabla es necesaria
#sudo route add -net ${SOME_NETWORK} netmask ${NETMASK} gw ${DEFAULT_GATEWAY} dev ${TAP}

#Agrega un 'default gateway' a la tabla de ruteo
sudo route add default gw ${DEFAULT_GATEWAY} ${TAP}



