#!/bin/bash

#Se chequean los parametros
if [ $# -ne "1" ]
then
	echo "USO: ${0} <nombre_maquina> "
	exit 0
fi

NOMBRE_CLIENTE=${1}

if [ "${NOMBRE_CLIENTE}" == "HostA"  ]
then
	TAP="tap64"

elif [ "${NOMBRE_CLIENTE}" == "HostB" ]
then
	TAP="tap65"

elif [ "${NOMBRE_CLIENTE}" == "HostC" ]
then
	TAP="tap66"

elif [ "${NOMBRE_CLIENTE}" == "WEBSERVER" ]
then
	TAP="tap118"

elif [ "${NOMBRE_CLIENTE}" == "FTPSERVER" ]
then
	TAP="tap119"

elif [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
	TAP="tap321"
	TAP_2="tap654"

else
	echo "El primer parametro debe ser: 'HostA', 'HostB', 'HostC', 'WEBSERVER', 'FTPSERVER' o 'TELSERVER'"
	exit 1
fi


sudo openvpn --rmtun --dev ${TAP}


#Porque el tel-server tiene dos interfaces
if [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
	sudo openvpn --rmtun --dev ${TAP_2}
fi
