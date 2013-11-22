#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del DNS root"

DEFAULT_GATEWAY_N="10.47.1.129"     #R9

sudo route add default gw ${DEFAULT_GATEWAY_N}
