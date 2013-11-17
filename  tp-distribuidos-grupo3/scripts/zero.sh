#!/bin/bash

#Elimina todas la configuracion de la maquina para poder usar el TP

PID_OPENVPN=$(ps -a | grep 'openvpn' | cut -d' ' -f2)   #Los PID de todos los processos que se llaman "openvpn"
for PID in ${PID_OPENVPN}
do
    sudo kill ${PID}
done


LISTA_TAPS=$(ifconfig -s | grep '^tap' | cut -d' ' -f1)

for TAP in ${LISTA_TAPS}
do
    sudo ip route flush dev ${TAP}  #Limpia la tabla de ruteo
    sudo ip link delete ${TAP}      #Elimina la interfaz virtual
done

exit 0

