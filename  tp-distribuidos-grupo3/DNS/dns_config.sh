#!/bin/bash

DNS_NAME=${1} 
if [ "$DNS_NAME" == "dns1"  ]
then
	TAP="tap81"
	HOST_IP="10.118.5.7"
	NETMASK="255.255.255.0"
	PORT_NUM="14258"
  DEFAULT_GATEWAY="10.118.5.1"    #R1
fi
if [ "$DNS_NAME" == "dns2"  ]
then
	TAP="tap82"
	HOST_IP="10.19.2.4"
	NETMASK="255.255.255.128"
	PORT_NUM="14258"
  DEFAULT_GATEWAY="10.19.2.5"    #R10
fi
if [ "$DNS_NAME" == "dnsroot"  ]
then
	TAP="tap83"
	HOST_IP="10.47.1.131"
	NETMASK="255.255.255.192"
	PORT_NUM="14258"
  DEFAULT_GATEWAY="10.47.1.129"    #R9
fi
	
function import {
    echo "Vaciando la carpeta /etc/bind/..."
    sudo rm /etc/bind/*
	
    echo "Verificando si hacen falta bind.keys y rndc.key.."
    cd $DNS_NAME
 
    echo "Copiando el contenido en la carpeta /etc/bind/..."
    sudo cp ./* /etc/bind/

    cd ..

    sudo chattr -i /etc/resolv.conf
    sudo chmod 777 /etc/resolv.conf
    echo "Agregando la direccion IP de DNS al archivo /etc/resolv.conf..."
    echo "# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)" > /etc/resolv.conf
    echo "#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN" >> /etc/resolv.conf
    echo "domain stacruz.dc.fi.uba.ar" >> /etc/resolv.conf
    echo "search stacruz.dc.fi.uba.ar" >> /etc/resolv.conf
    echo "nameserver 127.0.0.1" >> /etc/resolv.conf
    echo "nameserver ${HOST_IP}" >> /etc/resolv.conf #DNS2
    sudo chmod 644 /etc/resolv.conf

    echo "Reiniciando bind9 con la nueva configuracion..."
    /etc/init.d/bind9 restart
}

##### MAIN #####

echo "DNS: Importando nuestros archivos de configuracion..."
import
echo "DNS: Importación finalizada!"
exit 0