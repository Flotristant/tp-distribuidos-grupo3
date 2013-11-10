#!/bin/bash

#Es necesario borrar todas las interfaces
HOST_A_TAP_NUMBER="tap64"
HOST_B_TAP_NUMBER="tap65"
HOST_C_TAP_NUMBER="tap66"

SERVER_WEB_TAP_NUMBER="tap118"
SERVER_FTP_TAP_NUMBER="tap119"

#Borra las interfaces
sudo openvpn --rmtun --dev ${HOST_A_TAP_NUMBER}
sudo openvpn --rmtun --dev ${HOST_B_TAP_NUMBER}
sudo openvpn --rmtun --dev ${HOST_C_TAP_NUMBER}

sudo openvpn --rmtun --dev ${SERVER_WEB_TAP_NUMBER}
sudo openvpn --rmtun --dev ${SERVER_FTP_TAP_NUMBER}


