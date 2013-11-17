#!/bin/bash

privateNetworkIp="192.168.73.2"
privateNetworkInterface="eth1"
tunnelInterface="tap2"

ipR10enHalcon="10.26.29.97"

Aguila="10.26.29.64" 	   # /27
Buitre="192.168.56.0"      # /24
Condor="10.26.29.192"      # /28
Dodo="10.64.74.0"          # /24
Espartillero="10.64.75.0"  # /24
Fenix="10.26.29.128"	   # /30
Halcon="10.26.29.96"	   # /27
Ibis="10.86.5.128"         # /25
Jacana="10.26.29.0"        # /26
Kiwi="10.26.29.160"        # /27
Ostrero="10.31.25.0"	   # /25
Picaflor="10.26.29.208"	   # /29

Mask24="255.255.255.0"
Mask25="255.255.255.128"
Mask26="255.255.255.192"
Mask27="255.255.255.224"
Mask28="255.255.255.240"
Mask29="255.255.255.248"
Mask30="255.255.255.252"

function limpiarInterfacesYRutas {
	#Borrado rutas
	`ip route flush all`

	#Borrado interfaces eth y ppp
	ifconfig | grep "eth" > interfaces.tmp
	ifconfig | grep "ppp" >> interfaces.tmp

	i=`wc -l interfaces.tmp | cut -d" " -f1`
	while [ $i -ne 0 ];	do
		if=`head -$i interfaces.tmp | tail -1 | cut -d" " -f1 `
		`ip addr flush $if`
		i=`expr $i - 1`
	done

  ifconfig -a | grep "tap" > tap.tmp
  i=`wc -l tap.tmp | cut -d" " -f1`
  while [ $i -ne 0 ]; do
	  if=`head -$i tap.tmp | tail -1 | cut -d" " -f1 `
   	echo "sudo openvpn --rmtun --dev $if"
	  `sudo openvpn --rmtun --dev $if`
  	i=`expr $i - 1`
  done

	rm interfaces.tmp
	rm tap.tmp


	#Agregado de loopback
	route add -net 127.0.0.0 netmask 255.0.0.0 gw 127.0.0.0
}

user=`whoami`
if [ $user != "root" ]; then
	echo -e "\n\tError: requiere sudo\n"
	exit 2
fi

limpiarInterfacesYRutas

ifconfig $privateNetworkInterface $privateNetworkIp netmask $Mask24

sudo rm /etc/bind/*
sudo cp named.* /etc/bind/
sudo cp db.* /etc/bind/
sudo echo "auto lo
iface lo inet loopback
auto $privateNetworkInterface
iface $privateNetworkInterface inet static
        address $privateNetworkIp
        netmask 255.255.255.224
        network 192.168.73.0
        broadcast 192.168.73.255" > /etc/network/interfaces
sudo cp resolv.conf /etc/
sudo /etc/init.d/bind9 restart
sudo /etc/init.d/networking restart

sudo /etc/init.d/openvpn stop
sudo rm /etc/openvpn/*.conf
sudo cp clienteDNS2.conf /etc/openvpn/
sudo /etc/init.d/openvpn start
# sudo openvpn /etc/openvpn/clienteDNS2.conf &
sudo ifconfig tap2 promisc up

route add default gw $ipR10enHalcon dev $tunnelInterface
