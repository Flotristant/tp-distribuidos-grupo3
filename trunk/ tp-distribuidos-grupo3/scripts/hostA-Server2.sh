#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web> <dns1> <dns2> <dnsroot>"
	exit 0
fi


#Las consifuraciones para cada elemento
#Los hosts A, B y C comparten la misma maquina fisica por lo que tienen la misma IP
#Lo mismo para con los servidores FTP, WEB y TEL

HOST_A_IP=${1}                      #La IP de la maquina fisica donde corre en host
#HOST_A_IP="192.168.50.2"            #..Descomentar para automatizar conexion LAN
HOST_A_PORT="14258"                 #El numero de puerto donde se conecta el tunel
HOST_A_NETMASK="255.255.255.0"      #La mascara de IP de la red donde se conecta el host
HOST_A_IP_TUNNEL="10.118.5.26"      #Una IP en la subred asignada al servidor de simulacion para poder establecer la conexion
HOST_A_TAP_NUMBER="tap64"           #La interfaz "tap" usada para este host


#HostA
sudo openvpn --mktun --dev ${HOST_A_TAP_NUMBER}
sudo ifconfig ${HOST_A_TAP_NUMBER} 0.0.0.0 promisc up


#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=HostA -x sudo openvpn --remote ${HOST_A_IP} --port ${HOST_A_PORT} --dev ${HOST_A_TAP_NUMBER} --ifconfig ${HOST_A_IP_TUNNEL} ${HOST_A_NETMASK}
