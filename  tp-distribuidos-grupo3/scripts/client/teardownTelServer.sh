#!/bin/bash

#Los PID de todos los processos que se llaman "openvpn"
PID_OPENVPN=$(ps -a | grep 'openvpn' | cut -d' ' -f2)

#Como se corre en un cliente los unicos tuneles openVPN van a ser los nuestros
for PID in ${PID_OPENVPN}
do
    echo "Cerrando openVPN (${PID})..."
    sudo kill ${PID}
done

#Las taps del telserver, no se porque no funciona el script normal
TAP_TEL_1="tap321"
TAP_TEL_2="tap654"

#Limpia la tabla de ruteo
echo "Limpiando las tablas de ruteo"
sudo ip route flush dev ${TAP_TEL_1}
sudo ip route flush dev ${TAP_TEL_2}

#Elimina el tunel ethernet
echo "Eliminando las interfaces de los tuneles"
sudo openvpn --rmtun --dev ${TAP_TEL_1}
sudo openvpn --rmtun --dev ${TAP_TEL_2}


exit 0

