#!/bin/bash

if [ $# -ne "1" ]
then
    echo "USO: ${0} <nombre_cliente> "
    exit 0
fi

NOMBRE_CLIENTE=${1}

#Basado en el tap que esta presente podriamos adivinar cual es el cliente y setearlo automaticamente
#Pero falta testearlo
NOM_TAP=$(ifconfig | grep '^tap' | cut -d' ' -f1)
echo "-> ${NOM_TAP}"


#Borra el default gateway existente
sudo route del default

if [ "${NOMBRE_CLIENTE}" == "DNSROOT"  ]
then
	DEFAULT_GATEWAY="10.47.1.129"     #R9

elif [ "${NOMBRE_CLIENTE}" == "DNS1"  ]
then
	DEFAULT_GATEWAY="10.118.5.2"     #R2

elif [ "${NOMBRE_CLIENTE}" == "DNS2"  ]
then
	DEFAULT_GATEWAY="10.19.2.2"     #R11

elif [ "${NOMBRE_CLIENTE}" == "HostA"  ]
then
	DEFAULT_GATEWAY="10.118.5.2"     #R2

elif [ "${NOMBRE_CLIENTE}" == "HostB" ]
then
	DEFAULT_GATEWAY="10.19.3.33"     #R6

elif [ "${NOMBRE_CLIENTE}" == "HostC" ]
then
	DEFAULT_GATEWAY="10.19.3.97"     #R13

elif [ "${NOMBRE_CLIENTE}" == "WEBSERVER" ]
then
	DEFAULT_GATEWAY="192.168.71.1"     #R3

elif [ "${NOMBRE_CLIENTE}" == "FTPSERVER" ]
then
	DEFAULT_GATEWAY="10.19.2.2"     #R11

elif [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
	DEFAULT_GATEWAY_N="10.47.1.129"     #R9
	DEFAULT_GATEWAY_ENIE="10.47.2.1"    #R14

	sudo ip route flush table all

	#El TelServer tiene dos default gateway, uno para cada red a la que esta conectada
	sudo route add default gw ${DEFAULT_GATEWAY_N}
	sudo route add default gw ${DEFAULT_GATEWAY_ENIE}

	exit 0

else
	echo "El primer parametro debe ser: 'HostA', 'HostB', 'HostC', 'DNSROOT', 'DNS1', 'DNS2', 'WEBSERVER', 'FTPSERVER' o 'TELSERVER'"
	exit 1
fi

sudo route add default gw ${DEFAULT_GATEWAY}

exit 0


