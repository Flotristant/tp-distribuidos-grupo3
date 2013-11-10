#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <nombre_cliente>\n"
	exit 0
fi

#Configura el cliente indicado
if [ "${1}" == "HostA"  ]
then
	TAP="tap64"

elif [ "${1}" == "HostB" ]
then
	TAP="tap65"

elif [ "${1}" == "HostC" ]
then
	TAP="tap66"

elif [ "${1}" == "WebServer" ]
then
	TAP="tap118"

elif [ "${1}" == "FTPServer" ]
then
	TAP="tap119"

else
	echo "No es uno de los servicios esperados"
	exit 1
fi

#Elimina el tunel ethernet
sudo openvpn --rmtun --dev ${TAP}

