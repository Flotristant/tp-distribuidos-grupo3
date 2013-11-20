#!/bin/bash

#Se chequea que todo este bien
if [ $# -ne "2" ]
then
	echo "USO: ${0} <IP_host_a_b_c> <IP_servidores_ftp_web> <dns1> <dns2> <dnsroot>"
	exit 0
fi

SERVER_FTP_IP=${2}
#SERVER_FTP_IP="192.168.50.3"        #..descomentar para automatizar conexion LAN
SERVER_FTP_PORT="25147"
SERVER_FTP_NETMASK="255.255.255.128"
SERVER_FTP_IP_TUNNEL="10.19.2.10"
SERVER_FTP_TAP_NUMBER="tap119"


#FTPServer
sudo openvpn --mktun --dev ${SERVER_FTP_TAP_NUMBER}
sudo ifconfig ${SERVER_FTP_TAP_NUMBER} 0.0.0.0 promisc up

gnome-terminal --title=FTPServer -x sudo openvpn --remote ${SERVER_FTP_IP} --port ${SERVER_FTP_PORT} --dev ${SERVER_FTP_TAP_NUMBER} --ifconfig ${SERVER_FTP_IP_TUNNEL} ${SERVER_FTP_NETMASK}
