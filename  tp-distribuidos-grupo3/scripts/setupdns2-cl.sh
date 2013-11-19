#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
    echo "USO: ${0} <nombre_cliente> <IP_servidor_simulacion>"
    exit 0
fi


#Las variables que entran por linea de comando
IP_DST=${2}
#IP_DST="192.168.50.1" # ip de server con gns3 preconfigurado (descomentar para automatizar)

NOMBRE_CLIENTE=${1}
echo "IP donde esta corriendo la simulación: ${IP_DST}"

#Configura el cliente indicado
if [ "${NOMBRE_CLIENTE}" == "DNS2"  ]
then
    IP_FISICA="192.168.50.2"

    TAP="tap82"
    HOST_IP="10.19.2.4"
    NETMASK="255.255.255.128"
    PORT_NUM="14261"
    DEFAULT_GATEWAY="10.19.2.5"    #R8

else
    echo "No es uno de los servicios esperados"
    exit 1
fi

# Configura la interfaz fisica de la PC para conectar las distintas maquinas fisicas (descomentar)
#sudo echo "auto lo
#iface lo inet loopback
#auto eth0
#iface eth0 inet static
#        address ${IP_FISICA}
#        netmask 255.255.255.0
#        network 192.168.50.0
#        broadcast 192.168.50.255" > /etc/network/interfaces

#Crea una interfaz "tap" ethernet que va a ser usada por el tunel
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#Abre el tunel hacia una IP_DST en otra ventana
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}

#No estoy seguro si esta entrada en la tabla es necesaria
#sudo route add -net ${SOME_NETWORK} netmask ${NETMASK} gw ${DEFAULT_GATEWAY} dev ${TAP}

#Agrega un 'default gateway' a la tabla de ruteo
sudo route add default gw ${DEFAULT_GATEWAY} ${TAP}