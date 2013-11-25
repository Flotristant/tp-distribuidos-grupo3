#!/bin/bash

echo "Setea la tabla de routes del telnet server"

TAP_RED_N="tap321"
TAP_RED_ENIE="tap654"

DEFAULT_GATEWAY_N="10.47.1.129"     #R9
DEFAULT_GATEWAY_ENIE="10.47.2.1"    #R14

#Una vez que los tuneles esten corriendo se agregan las entradas en la tabla de ruteo
sudo route add default gw ${DEFAULT_GATEWAY_N} ${TAP_RED_N}
sudo route add default gw ${DEFAULT_GATEWAY_ENIE} ${TAP_RED_ENIE}
