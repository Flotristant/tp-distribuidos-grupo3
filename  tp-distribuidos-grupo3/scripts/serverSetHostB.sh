#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_host_b>"
	exit 0
fi

IP=${1}                      #La IP de la maquina fisica donde corre en host
TAP="tap65"     	     #La interfaz "tap" usada para este host
TITULO="Host_B"
PORT_NUM="14369"             #El numero de puerto donde se conecta el tunel
NETMASK="255.255.255.224"      #La mascara de IP de la red donde se conecta el host
IP_END_TUNNEL="10.19.3.40"	#Una IP en la subred asignada al servidor de simulacion para poder establecer la conexion

#Se crea una interfaz "tap" ethernet para cada cliente externo
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=${TITULO} -x sudo openvpn --remote ${IP} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${IP_END_TUNNEL} ${NETMASK}

