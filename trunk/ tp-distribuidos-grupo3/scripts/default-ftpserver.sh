#!/bin/bash

echo "Se limpia toda la tabla de ruteo"
sudo ip route flush table all

echo "Setea la tabla de routeo del FTPServer"

DEFAULT_GATEWAY_J="10.19.2.2"     #R11

sudo route add default gw ${DEFAULT_GATEWAY_J}
