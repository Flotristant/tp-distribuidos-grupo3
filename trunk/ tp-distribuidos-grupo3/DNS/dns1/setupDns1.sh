#!/bin/bash

privateNetworkIp="192.168.50.11"
privateNetworkInterface="eth0"
tunnelInterface="tap81"
defaultGateway="10.118.5.5"

#Trek="10.26.29.64" 	   # /27
#Specialized="192.168.56.0"      # /24
#GT="10.26.29.192"      # /28
#Lapierre="10.64.74.0"          # /24
#Raleigh="10.64.75.0"  # /24
#BH="10.26.29.128"	   # /30
#MMR="10.26.29.96"	   # /27
#Cannondale="10.86.5.128"         # /25
#Scott="10.26.29.0"        # /26
#Giant="10.26.29.160"        # /27
#Orbea="10.31.25.0"	   # /25
#Kona="10.26.29.208"	   # /29
#Merida="10.26.29.208"	   # /29

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
        netmask 255.255.255.0
        network 192.168.50.0
        broadcast 192.168.50.255" > /etc/network/interfaces
sudo cp resolv.conf /etc/
sudo /etc/init.d/bind9 restart
sudo /etc/init.d/networking restart

sudo /etc/init.d/openvpn stop
sudo rm /etc/openvpn/*.conf
sudo cp clienteDNS1.conf /etc/openvpn/
sudo /etc/init.d/openvpn start
# sudo openvpn /etc/openvpn/clienteDNS1.conf &
sudo ifconfig tap81 promisc up

route add default gw $defaultGateway dev $tunnelInterface

#route add -net $Aguila       netmask $Mask27 gw $ipR15inOstrero dev $tunnelInterface
#route add -net $Buitre       netmask $Mask24 gw $ipR15inOstrero dev $tunnelInterface
#route add -net $Condor       netmask $Mask28 gw $ipR15inOstrero dev $tunnelInterface
#route add -net $Dodo         netmask $Mask24 gw $ipR12inOstrero dev $tunnelInterface
#route add -net $Espartillero netmask $Mask24 gw $ipR15inOstrero dev $tunnelInterface
#route add -net $Fenix        netmask $Mask30 gw $ipR12inOstrero dev $tunnelInterface
#route add -net $Halcon       netmask $Mask27 gw $ipR13inOstrero dev $tunnelInterface
#route add -net $Ibis         netmask $Mask25 gw $ipR13inOstrero dev $tunnelInterface
#route add -net $Jacana       netmask $Mask26 gw $ipR15inOstrero dev $tunnelInterface
#route add -net $Kiwi         netmask $Mask27 gw $ipR13inOstrero dev $tunnelInterface
#route add -net $Picaflor     netmask $Mask29 gw $ipR15inOstrero dev $tunnelInterface

