#!/bin/bash

#Recupera todas las interfaces tap del sistema
LISTA_TAPS=$(ifconfig -a | grep 'tap' | cut -d' ' -f1)

for TAP in ${LISTA_TAPS}
do
	#Limpia la tabla de ruteo
	sudo ip route flush dev ${TAP}

	#Elimina el tunel ethernet
	sudo openvpn --rmtun --dev ${TAP}
done

exit 0

