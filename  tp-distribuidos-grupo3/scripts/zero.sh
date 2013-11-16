#!/bin/bash

#Elimina todas la configuracion de la maquina para poder usar el TP

LISTA_TAPS=$(ifconfig -s | grep '^tap' | cut -d' ' -f1)

for TAP in ${LISTA_TAPS}
do
    sudo ip route fulsh dev ${TAP}  #Limpia la tabla de ruteo
    sudo ip link delete ${TAP}      #Elimina la interfaz virtual
done

exit 0

