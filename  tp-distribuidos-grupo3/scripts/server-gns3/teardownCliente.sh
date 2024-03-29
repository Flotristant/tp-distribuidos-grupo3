#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <nombre_cliente>"
	exit 0
fi

#Configura el cliente indicado
if [ "${1}" == "HostA"  ]
then
	TAP="tap64"
	PUERTO="14258"

elif [ "${1}" == "HostB" ]
then
	TAP="tap65"
	PUERTO="14369"

elif [ "${1}" == "HostC" ]
then
	TAP="tap66"
	PUERTO="14147"

elif [ "${1}" == "WebServer" ]
then
	TAP="tap118"
	PUERTO="25369"

elif [ "${1}" == "FTPServer" ]
then
	TAP="tap119"
	PUERTO="25147"
elif [ "${1}" == "DNS1" ]
then
	TAP="tap81"
	PUERTO="14262"
elif [ "${1}" == "DNS2" ]
then
	TAP="tap82"
	PUERTO="14261"
elif [ "${1}" == "DNSRoot" ]
then
	TAP="tap83"
	PUERTO="14263"
elif [ "${1}" == "TelServer" ]
then
	TAP="tap321"
	PUERTO="14363"
	TAP_2="tap654"
	PUERTO_2="14364"
else
	echo "No es uno de los servicios esperados"
	exit 1
fi

#Elimina el tunel ethernet
sudo openvpn --rmtun --dev ${TAP}
ret=$?
#si el anterior no funciona, kill
if [ $ret != 0 ] 
then
	pid=$(sudo netstat -ap | grep "\:$PUERTO" | sed 's%.* \([0-9]\+\)\(\/openvpn\)%\1%')
	echo "kill process $pid"
	sudo kill $pid
	#elimina la interfaz
	sudo ifconfig ${TAP} down
fi



if [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
	#Elimina el tunel ethernet
	sudo openvpn --rmtun --dev ${TAP_2}
	ret=$?
	#si el anterior no funciona, kill
	if [ $ret != 0 ] 
	then
		pid2=$(sudo netstat -ap | grep "\:$PUERTO_2" | sed 's%.* \([0-9]\+\)\(\/openvpn\)%\1%')
		echo "kill process $pid2"
		sudo kill $pid2
		#elimina la interfaz
		sudo ifconfig ${TAP_2} down
		sudo ip route flush dev ${TAP_2}
	fi	
fi

	
#Limpia la tabla de ruteo
sudo ip route flush dev ${TAP}
