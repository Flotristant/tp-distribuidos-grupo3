#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del Host C"

DEFAULT_GATEWAY_M="10.19.3.97"     #R13

sudo route add default gw ${DEFAULT_GATEWAY_M}
