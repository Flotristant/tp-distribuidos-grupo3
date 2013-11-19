#!/bin/bash

IP_DNS_2="10.19.2.4"

function import {
    echo "Vaciando la carpeta /etc/bind/..."
    sudo rm /etc/bind/*

    cd ./dns2

    echo "Copiando el contenido en la carpeta /etc/bind/..."
    sudo cp ./* /etc/bind/

    cd ..

    sudo chattr -i /etc/resolv.conf
    sudo chmod 777 /etc/resolv.conf
    echo "Agregando la direccion IP de DNS2 al archivo /etc/resolv.conf..."
    echo "# Dynamic resolv.conf(5) file for glibc resolver(3) generated by resolvconf(8)" > /etc/resolv.conf
    echo "#     DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN" >> /etc/resolv.conf
    echo "domain stacruz.dc.fi.uba.ar" >> /etc/resolv.conf
    echo "search stacruz.dc.fi.uba.ar" >> /etc/resolv.conf
    echo "nameserver 127.0.0.1" >> /etc/resolv.conf
    echo "nameserver 10.19.2.4" >> /etc/resolv.conf #DNS2
    sudo chmod 644 /etc/resolv.conf

    echo "Reiniciando bind9 con la nueva configuracion..."
    /etc/init.d/bind9 restart
}

##### MAIN #####

echo "DNS2: Importando nuestros archivos de configuracion..."
import
echo "DNS2: Importación finalizada!"
exit 0