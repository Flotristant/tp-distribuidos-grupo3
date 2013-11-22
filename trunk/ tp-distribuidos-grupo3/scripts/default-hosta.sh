#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del Host A"

DEFAULT_GATEWAY_A="10.118.5.2"     #R2

sudo route add default gw ${DEFAULT_GATEWAY_A}
