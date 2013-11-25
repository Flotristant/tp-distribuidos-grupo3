#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
    echo "USO: ${0} <IP_servidor_simulacion>"
    exit 0
fi


#Las variables que entran por linea de comando
IP_DST=${1}

NOMBRE_CLIENTE="DNSROOT"
echo "IP donde esta corriendo la simulación: ${IP_DST}"

#Configura el cliente indicado
TAP="tap83"
HOST_IP="10.47.1.131"
HOST_NET="10.47.1.128"
NETMASK="255.255.255.192"
PORT_NUM="14263"
DEFAULT_GATEWAY="10.47.1.129"     #R10


#Crea una interfaz "tap" ethernet que va a ser usada por el tunel
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia una IP_DST en otra ventana
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}

#No estoy seguro si esta entrada en la tabla es necesaria
#sudo route add -net ${SOME_NETWORK} netmask ${NETMASK} gw ${DEFAULT_GATEWAY} dev ${TAP}

#Agrega un 'default gateway' a la tabla de ruteo
sudo route add default gw ${DEFAULT_GATEWAY} ${TAP}
sudo route add default gw ${DEFAULT_GATEWAY}
