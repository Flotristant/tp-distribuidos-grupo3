#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del TelServer"

DEFAULT_GATEWAY_N="10.47.1.129"     #R9
DEFAULT_GATEWAY_ENIE="10.47.2.1"    #R14

TAP_RED_N="tap321"
TAP_RED_ENIE="tap654"

sudo route add default gw ${DEFAULT_GATEWAY_N} ${TAP_RED_N}
sudo route add default gw ${DEFAULT_GATEWAY_ENIE} ${TAP_RED_ENIE}
