#!/bin/bash

#Los PID de todos los processos que se llaman "openvpn"
PID_OPENVPN=$(ps -a | grep 'openvpn' | cut -d' ' -f2)

for PID in ${PID_OPENVPN}
do
    sudo kill ${PID}
done


#Recupera todas las interfaces tap del sistema
LISTA_TAPS=$(ifconfig -a | grep 'tap' | cut -d' ' -f1)

for TAP in ${LISTA_TAPS}
do
	#Limpia la tabla de ruteo
	#sudo ip route flush dev ${TAP}

	#Elimina el tunel ethernet
	sudo openvpn --rmtun --dev ${TAP}
done


#Las taps que no se pudieron cerrar de la forma "normal"
LISTA_TAPS_REMANENTE=$(ifconfig -a | grep 'tap' | cut -d' ' -f1)
for TAP_REMANENTE in ${LISTA_TAPS_REMANENTE}
do
	#Elimina la interfaz virtual
	sudo ip link delete ${TAP_REMANENTE}
done


exit 0

