#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del WebServer"

DEFAULT_GATEWAY_C="192.168.71.1"     #R3

sudo route add default gw ${DEFAULT_GATEWAY_C}
