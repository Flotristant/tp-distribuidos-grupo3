#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del Host B"

DEFAULT_GATEWAY_G="10.19.3.33"     #R6

sudo route add default gw ${DEFAULT_GATEWAY_G}
