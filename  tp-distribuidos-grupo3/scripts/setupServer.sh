#!/bin/bash

echo "EXPERIMENTAL!!! PELIGRO"
exit 0

#Se chequea que todo este bien
if [ $# -ne "1" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web>"
	echo "EXPERIMENTAL!!! PELIGRO"
	exit 0
fi

#Las consifuraciones para cada elemento
#Los hosts A, B y C comparten la misma maquina fisica por lo que tienen la misma IP
#Lo mismo para con los servidores FTP, WEB y TEL

HOST_A_IP=${1}                      #La IP de la maquina fisica donde corre en host
HOST_A_PORT="14258"                 #El numero de puerto donde se conecta el tunel
HOST_A_NETMASK="255.255.255.0"      #La mascara de IP de la red donde se conecta el host
HOST_A_IP_TUNNEL="10.118.5.26"      #Una IP en la subred asignada al servidor de simulacion para poder establecer la conexion
HOST_A_TAP_NUMBER="tap64"           #La interfaz "tap" usada para este host

HOST_B_IP=${1}
HOST_B_PORT="14369"
HOST_B_NETMASK="255.255.255.224"
HOST_B_IP_TUNNEL="10.19.3.40"
HOST_B_TAP_NUMBER="tap65"

HOST_C_IP=${1}
HOST_C_PORT="14147"
HOST_C_NETMASK="255.255.255.224"
HOST_C_IP_TUNNEL="10.19.3.101"
HOST_C_TAP_NUMBER="tap66"

SERVER_WEB_IP=${2}
SERVER_WEB_PORT="25369"
SERVER_WEB_NETMASK="255.255.255.0"
SERVER_WEB_IP_TUNNEL="192.168.71.50"
SERVER_WEB_TAP_NUMBER="tap118"

SERVER_FTP_IP=${2}
SERVER_FTP_PORT="25147"
SERVER_FTP_NETMASK="255.255.255.128"
SERVER_FTP_IP_TUNNEL="10.19.2.10"
SERVER_FTP_TAP_NUMBER="tap119"

#Se crea una interfaz "tap" ethernet para cada cliente externo

#HostA
sudo openvpn --mktun --dev ${HOST_A_TAP_NUMBER}
sudo ifconfig ${HOST_A_TAP_NUMBER} 0.0.0.0 promisc up

#HostB
sudo openvpn --mktun --dev ${HOST_B_TAP_NUMBER}
sudo ifconfig ${HOST_B_TAP_NUMBER} 0.0.0.0 promisc up

#HostC
sudo openvpn --mktun --dev ${HOST_C_TAP_NUMBER}
sudo ifconfig ${HOST_C_TAP_NUMBER} 0.0.0.0 promisc up

#WebServer
sudo openvpn --mktun --dev ${SERVER_WEB_TAP_NUMBER}
sudo ifconfig ${SERVER_WEB_TAP_NUMBER} 0.0.0.0 promisc up

#FTPServer
sudo openvpn --mktun --dev ${SERVER_FTP_TAP_NUMBER}
sudo ifconfig ${SERVER_FTP_TAP_NUMBER} 0.0.0.0 promisc up

#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=HostA -x sudo openvpn --remote ${HOST_A_IP} --port ${HOST_A_PORT} --dev ${HOST_A_TAP_NUMBER} --ifconfig ${HOST_A_IP_TUNNEL} ${HOST_A_NETMASK}
gnome-terminal --title=HostB -x sudo openvpn --remote ${HOST_B_IP} --port ${HOST_B_PORT} --dev ${HOST_B_TAP_NUMBER} --ifconfig ${HOST_A_IP_TUNNEL} ${HOST_A_NETMASK}
gnome-terminal --title=HostC -x sudo openvpn --remote ${HOST_C_IP} --port ${HOST_C_PORT} --dev ${HOST_C_TAP_NUMBER} --ifconfig ${HOST_A_IP_TUNNEL} ${HOST_A_NETMASK}

gnome-terminal --title=FTPServer -x sudo openvpn --remote ${SERVER_WEB_IP} --port ${SERVER_WEB_PORT} --dev ${SERVER_WEB_TAP_NUMBER} --ifconfig ${SERVER_WEB_IP_TUNNEL} ${SERVER_WEB_NETMASK}
gnome-terminal --title=WEBServer -x sudo openvpn --remote ${SERVER_FTP_IP} --port ${SERVER_FTP_PORT} --dev ${SERVER_FTP_TAP_NUMBER} --ifconfig ${SERVER_FTP_IP_TUNNEL} ${SERVER_FTP_NETMASK}


