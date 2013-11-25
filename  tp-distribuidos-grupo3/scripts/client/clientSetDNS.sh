#!/bin/bash

if [ $# -ne "2" ]
then
    echo "USO: ${0} <DNS_nombre> <IP_servidor_simulacion>"
    exit 0
fi

IP_DST=${2}
NOMBRE_CLIENTE=${1}

if [ "${NOMBRE_CLIENTE}" == "DNSROOT"  ]
then

    TAP="tap83"
    HOST_IP="10.47.1.131"
    NETMASK="255.255.255.192"
    PORT_NUM="14263"
    DEFAULT_GATEWAY="10.47.1.129"	#R9

elif [ "${NOMBRE_CLIENTE}" == "DNS1"  ]
then

    TAP="tap81"
    HOST_IP="10.118.5.7"
    NETMASK="255.255.255.0"
    PORT_NUM="14262"
    DEFAULT_GATEWAY="10.118.5.5"	#R4

elif [ "${NOMBRE_CLIENTE}" == "DNS2"  ]
then

    TAP="tap82"
    HOST_IP="10.19.2.4"
    NETMASK="255.255.255.128"
    PORT_NUM="14261"
    DEFAULT_GATEWAY="10.19.2.5"	#R10

else
    echo "Debe ser uno de: 'DNSROOT', 'DNS1' o 'DNS2'"
    exit 1
fi

#La interfaz tap
sudo openvpn --mktun --dev ${TAP}
sudo ifconfig ${TAP} 0.0.0.0 promisc up

#El tunel
gnome-terminal --title=${NOMBRE_CLIENTE} -x sudo openvpn --remote ${IP_DST} --port ${PORT_NUM} --dev ${TAP} --ifconfig ${HOST_IP} ${NETMASK}

exit 0


