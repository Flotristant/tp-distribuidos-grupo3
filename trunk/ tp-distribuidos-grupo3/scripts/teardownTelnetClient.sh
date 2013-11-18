#!/bin/bash

#Los nombres de las interfaces
TAP_TELNET_N="tap321"
TAP_TELNET_ENIE="tap654"

#Elimina el tunel ethernet
sudo openvpn --rmtun --dev ${TAP_TELNET_N}
sudo openvpn --rmtun --dev ${TAP_TELNET_ENIE}

#Limpia la tabla de ruteo
sudo ip route flush dev ${TAP_TELNET_N}
sudo ip route flush dev ${TAP_TELNET_ENIE}

