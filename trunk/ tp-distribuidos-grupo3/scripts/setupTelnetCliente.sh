#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_servidor_simulacion>"
	exit 0
fi

IP_SIMULACION=${1}
echo "IP donde esta corriendo la simulación: ${IP_SIMULACION}"

#Este servidor tiene dos conexiones a dos subredes distintas
TAP_RED_N="tap321"
NETMASK_N="255.255.255.128"
PORTNUM_N=32561			#Random
IP_RED_N="10.47.1.130"
DEFAULT_GATEWAY_N="10.47.1.129"     #R9

TAP_RED_ENIE="tap654"
NETMASK_ENIE="255.255.254.0"
PORTNUM_ENIE=32516		#Random
IP_RED_ENIE="10.47.2.129"
DEFAULT_GATEWAY_ENIE="10.47.2.1"    #R14

#Crea las interfacez ethernet
sudo openvpn --mktun --dev ${TAP_RED_N}
sudo ifconfig ${TAP_RED_N} 0.0.0.0 promisc up

sudo openvpn --mktun --dev ${TAP_RED_ENIE}
sudo ifconfig ${TAP_RED_ENIE} 0.0.0.0 promisc up

#Levanta los tuneles en distintas consolas
gnome-terminal --title=TELServer_n -x sudo openvpn --remote ${IP_SIMULACION} --port ${PORTNUM_N} --dev ${TAP_RED_N} --ifconfig ${IP_RED_N} ${NETMASK_N} 
gnome-terminal --title=TELServer_enie -x sudo openvpn --remote ${IP_SIMULACION} --port ${PORTNUM_ENIE} --dev ${TAP_RED_ENIE} --ifconfig ${IP_RED_ENIE} ${NETMASK_ENIE}

#Una vez que los tuneles esten corriendo se agregan las entradas en la tabla de ruteo
sudo route add default gw ${DEFAULT_GATEWAY_N} ${TAP_RED_N}
sudo route add default gw ${DEFAULT_GATEWAY_ENIE} ${TAP_RED_ENIE}




