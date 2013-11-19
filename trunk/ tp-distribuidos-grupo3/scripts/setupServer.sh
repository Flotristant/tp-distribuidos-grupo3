#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "3" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web> <dns1> <dns2> <dnsroot>"
	exit 0
fi

# Configura la interfaz fisica de la PC para conectar las distintas maquinas fisicas (descomentar)
#sudo echo "auto lo
#iface lo inet loopback
#auto eth0
#iface eth0 inet static
#        address 192.168.50.1
#        netmask 255.255.255.0
#        network 192.168.50.0
#        broadcast 192.168.50.255" > /etc/network/interfaces


#Las consifuraciones para cada elemento
#Los hosts A, B y C comparten la misma maquina fisica por lo que tienen la misma IP
#Lo mismo para con los servidores FTP, WEB y TEL

HOST_A_IP=${1}                      #La IP de la maquina fisica donde corre en host
#HOST_A_IP="192.168.50.2"            #..Descomentar para automatizar conexion LAN
HOST_A_PORT="14258"                 #El numero de puerto donde se conecta el tunel
HOST_A_NETMASK="255.255.255.0"      #La mascara de IP de la red donde se conecta el host
HOST_A_IP_TUNNEL="10.118.5.26"      #Una IP en la subred asignada al servidor de simulacion para poder establecer la conexion
HOST_A_TAP_NUMBER="tap64"           #La interfaz "tap" usada para este host

HOST_B_IP=${1}
#HOST_B_IP="192.168.50.2"            #..descomentar para automatizar conexion LAN
HOST_B_PORT="14369"
HOST_B_NETMASK="255.255.255.224"
HOST_B_IP_TUNNEL="10.19.3.40"
HOST_B_TAP_NUMBER="tap65"

HOST_C_IP=${1}
#HOST_C_IP="192.168.50.2"            #..descomentar para automatizar conexion LAN
HOST_C_PORT="14147"
HOST_C_NETMASK="255.255.255.224"
HOST_C_IP_TUNNEL="10.19.3.101"
HOST_C_TAP_NUMBER="tap66"

SERVER_WEB_IP=${2}
#SERVER_WEB_IP="192.168.50.3"        #..descomentar para automatizar conexion LAN
SERVER_WEB_PORT="25369"
SERVER_WEB_NETMASK="255.255.255.0"
SERVER_WEB_IP_TUNNEL="192.168.71.50"
SERVER_WEB_TAP_NUMBER="tap118"

SERVER_FTP_IP=${2}
#SERVER_FTP_IP="192.168.50.3"        #..descomentar para automatizar conexion LAN
SERVER_FTP_PORT="25147"
SERVER_FTP_NETMASK="255.255.255.128"
SERVER_FTP_IP_TUNNEL="10.19.2.10"
SERVER_FTP_TAP_NUMBER="tap119"

SERVER_TEL_IP_N=${2}
#SERVER_TEL_IP_N="192.168.50.3"      #..descomentar para automatizar conexion LAN
SERVER_TEL_PORT_N="32561"
SERVER_TEL_NETMASK_N="255.255.255.128"
SERVER_TEL_IP_TUNNEL_N="10.47.1.130"
SERVER_TEL_TAP_NUMBER_N="tap321"

SERVER_TEL_IP_ENIE=${2}
#SERVER_TEL_IP_ENIE="192.168.50.3"   #..descomentar para automatizar conexion LAN
SERVER_TEL_PORT_ENIE="32516"
SERVER_TEL_NETMASK_ENIE="255.255.254"
SERVER_TEL_IP_TUNNEL_ENIE="10.47.2.129"
SERVER_TEL_TAP_NUMBER_ENIE="tap654"

#agregar datos DNS1, DNS2, DNSroot..
DNS1_IP=${3}
#DNS1_IP="192.168.50.11"   #..descomentar para automatizar conexion LAN
DNS1_PORT="331"
DNS1_NETMASK="255.255.255.0"
DNS1_IP_TUNNEL="10.118.5.6"
DNS1_TAP_NUMBER="tap81"

DNS2_IP=${4}
#DNS2_IP="192.168.50.12"   #..descomentar para automatizar conexion LAN
DNS2_PORT="332"
DNS2_NETMASK="255.255.128"
DNS2_IP_TUNNEL="10.19.2.1"
DNS2_TAP_NUMBER="tap82"

DNSROOT_IP=${5}
#DNSROOT_IP="192.168.50.13"   #..descomentar para automatizar conexion LAN
DNSROOT_PORT="333"
DNSROOT_NETMASK="255.255.192"
DNSROOT_IP_TUNNEL="10.47.1.131"
DNSROOT_TAP_NUMBER="tap83"

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

#TELServer
sudo openvpn --mktun --dev ${SERVER_TEL_TAP_NUMBER}
sudo ifconfig ${SERVER_TEL_TAP_NUMBER} 0.0.0.0 promisc up

sudo openvpn --mktun --dev ${SERVER_TEL_TAP_NUMBER}
sudo ifconfig ${SERVER_TEL_TAP_NUMBER} 0.0.0.0 promisc up

#DNS 1
sudo openvpn --mktun --dev ${DNS1_TAP_NUMBER}
sudo ifconfig ${DNS1_TAP_NUMBER} 0.0.0.0 promisc up

#DNS 2
sudo openvpn --mktun --dev ${DNS2_TAP_NUMBER}
sudo ifconfig ${DNS2_TAP_NUMBER} 0.0.0.0 promisc up

#DNS Root
sudo openvpn --mktun --dev ${DNSROOT_TAP_NUMBER}
sudo ifconfig ${DNSROOT_TAP_NUMBER} 0.0.0.0 promisc up


#Abre una terminal para cada tunel en ventanas distintas
gnome-terminal --title=HostA -x sudo openvpn --remote ${HOST_A_IP} --port ${HOST_A_PORT} --dev ${HOST_A_TAP_NUMBER} --ifconfig ${HOST_A_IP_TUNNEL} ${HOST_A_NETMASK}
gnome-terminal --title=HostB -x sudo openvpn --remote ${HOST_B_IP} --port ${HOST_B_PORT} --dev ${HOST_B_TAP_NUMBER} --ifconfig ${HOST_B_IP_TUNNEL} ${HOST_B_NETMASK}
gnome-terminal --title=HostC -x sudo openvpn --remote ${HOST_C_IP} --port ${HOST_C_PORT} --dev ${HOST_C_TAP_NUMBER} --ifconfig ${HOST_C_IP_TUNNEL} ${HOST_C_NETMASK}

gnome-terminal --title=WEBServer -x sudo openvpn --remote ${SERVER_WEB_IP} --port ${SERVER_WEB_PORT} --dev ${SERVER_WEB_TAP_NUMBER} --ifconfig ${SERVER_WEB_IP_TUNNEL} ${SERVER_WEB_NETMASK}
gnome-terminal --title=FTPServer -x sudo openvpn --remote ${SERVER_FTP_IP} --port ${SERVER_FTP_PORT} --dev ${SERVER_FTP_TAP_NUMBER} --ifconfig ${SERVER_FTP_IP_TUNNEL} ${SERVER_FTP_NETMASK}
gnome-terminal --title=TELServer_N -x sudo openvpn --remote ${SERVER_TEL_IP_N} --port ${SERVER_TEL_PORT_N} --dev ${SERVER_TEL_TAP_NUMBER_N} --ifconfig ${SERVER_TEL_IP_TUNNEL_N} ${SERVER_TEL_NETMASK_N}
gnome-terminal --title=TELServer_ENIE -x sudo openvpn --remote ${SERVER_TEL_IP_ENIE} --port ${SERVER_TEL_PORT_ENIE} --dev ${SERVER_TEL_TAP_NUMBER_ENIE} --ifconfig ${SERVER_TEL_IP_TUNNEL_ENIE} ${SERVER_TEL_NETMASK_ENIE}

gnome-terminal --title=DNS1 -x sudo openvpn --remote ${DNS1_IP} --port ${DNS1_PORT} --dev ${DNS1_TAP_NUMBER} --ifconfig ${DNS1_IP_TUNNEL} ${DNS1_NETMASK}
gnome-terminal --title=DNS2 -x sudo openvpn --remote ${DNS2_IP} --port ${DNS2_PORT} --dev ${DNS2_TAP_NUMBER} --ifconfig ${DNS2_IP_TUNNEL} ${DNS2_NETMASK}
gnome-terminal --title=DNSRoot -x sudo openvpn --remote ${DNSROOT_IP} --port ${DNSROOT_PORT} --dev ${DNSROOT_TAP_NUMBER} --ifconfig ${DNSROOT_IP_TUNNEL} ${DNSROOT_NETMASK}
