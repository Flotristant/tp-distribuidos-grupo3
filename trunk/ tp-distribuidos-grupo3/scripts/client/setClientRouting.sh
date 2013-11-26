#!/bin/bash

if [ $# -ne "1" ]
then
    echo "USO: ${0} <nombre_cliente> "
    exit 0
fi

NOMBRE_CLIENTE=${1}

#Redes y mascaras para el ruteo
RED_A="10.118.5.0"
RED_B1="172.143.0.64"
RED_B2="172.143.0.68"
RED_B3="172.143.0.72"
RED_C="192.168.71.0"
RED_G="10.19.3.32"
RED_H="10.19.3.128"
RED_I="10.19.3.0"
RED_J="10.19.2.0"
RED_K="10.19.3.4"
RED_L="10.19.3.64"
RED_M="10.19.3.96"
RED_N="10.47.1.128"
RED_ENIE="10.47.2.0"
RED_O="10.19.3.144"
RED_P="10.19.3.16"
RED_Q="10.19.3.8"
RED_R="10.19.3.12"
RED_S="10.19.3.152"
MASK_24="255.255.255.0"
MASK_25="255.255.255.128"
MASK_26="255.255.255.192"
MASK_27="255.255.255.224"
MASK_28="255.255.255.240"
MASK_29="255.255.255.248"
MASK_30="255.255.255.252"

#Borra el  gateway existente
sudo route del default
if [ "${NOMBRE_CLIENTE}" == "DNSROOT" ]
then
	echo "DNSROOT"
 	TAP="tap83"
	sudo route add -net $RED_A netmask $MASK_24 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_B1 netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_B2 netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_B3 netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_C netmask $MASK_24 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_G netmask $MASK_27 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_H netmask $MASK_28 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_I netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_J netmask $MASK_25 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_K netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_L netmask $MASK_27 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_M netmask $MASK_27 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_ENIE netmask $MASK_24 gw 10.47.1.129  dev ${TAP}
	sudo route add -net $RED_O netmask $MASK_29 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_P netmask $MASK_28 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_Q netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_R netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
	sudo route add -net $RED_S netmask $MASK_30 gw 10.47.1.129 dev ${TAP}
elif [ "${NOMBRE_CLIENTE}" == "DNS1" ]
then
	echo "DNS1"
        TAP="tap81"
	sudo route add -net $RED_B1 netmask $MASK_30 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_B2 netmask $MASK_30 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_B3 netmask $MASK_30 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_C netmask $MASK_24 gw 10.118.5.5 dev ${TAP}
	sudo route add -net $RED_G netmask $MASK_27 gw 10.118.5.2 dev ${TAP}
	sudo route add -net $RED_H netmask $MASK_28 gw 10.118.5.5 dev ${TAP}
	sudo route add -net $RED_I netmask $MASK_30 gw 10.118.5.2 dev ${TAP}
	sudo route add -net $RED_J netmask $MASK_25 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_K netmask $MASK_30 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_L netmask $MASK_27 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_M netmask $MASK_27 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_N netmask $MASK_26 gw 10.118.5.2 dev ${TAP}
	sudo route add -net $RED_ENIE netmask $MASK_24 gw 10.118.5.5 dev ${TAP}
	sudo route add -net $RED_O netmask $MASK_29 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_P netmask $MASK_28 gw 10.118.5.1 dev ${TAP}
	sudo route add -net $RED_Q netmask $MASK_30 gw 10.118.5.5 dev ${TAP}
	sudo route add -net $RED_R netmask $MASK_30 gw 10.118.5.5 dev ${TAP}
	sudo route add -net $RED_S netmask $MASK_30 gw 10.118.5.5 dev ${TAP}
elif [ "${NOMBRE_CLIENTE}" == "DNS2" ]
then
    echo "DNS2"
    TAP="tap82"
    sudo route add -net ${RED_A} netmask ${MASK_24} gw 10.19.2.3 dev ${TAP}
    sudo route add -net ${RED_B1} netmask ${MASK_30} gw 10.19.2.3 dev ${TAP}
    sudo route add -net ${RED_B2} netmask ${MASK_30} gw 10.19.2.3 dev ${TAP}
    sudo route add -net ${RED_B3} netmask ${MASK_30} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_C} netmask ${MASK_24} gw 10.19.2.3 dev ${TAP}
    sudo route add -net ${RED_G} netmask ${MASK_27} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_H} netmask ${MASK_28} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_I} netmask ${MASK_30} gw 10.19.2.3 dev ${TAP}
    sudo route add -net ${RED_K} netmask ${MASK_30} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_L} netmask ${MASK_27} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_M} netmask ${MASK_27} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_N} netmask ${MASK_26} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_ENIE} netmask ${MASK_24} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_O} netmask ${MASK_29} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_P} netmask ${MASK_28} gw 10.19.2.2 dev ${TAP}
    sudo route add -net ${RED_Q} netmask ${MASK_30} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_R} netmask ${MASK_30} gw 10.19.2.5 dev ${TAP}
    sudo route add -net ${RED_S} netmask ${MASK_30} gw 10.19.2.5 dev ${TAP}
fi
then
	TAP="tap64"
	sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "10.118.5.5" dev "${TAP}"
	sudo route add -net "${RED_D}" netmask "${MASK_24}" gw "10.118.5.5" dev "${TAP}"
	sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "10.118.5.2" dev "${TAP}"
	sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "10.118.5.2" dev "${TAP}"
	sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "10.118.5.2" dev "${TAP}"
	sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_N}" netmask "${MASK_26}" gw "10.118.5.2" dev "${TAP}"
	sudo route add -net "${RED_ENIE}" netmask "${MASK_24}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "10.118.5.1" dev "${TAP}"
	sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "10.118.5.5" dev "${TAP}"
	sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "10.118.5.2" dev "${TAP}"
	sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "10.118.5.5" dev "${TAP}"

elif [ "${NOMBRE_CLIENTE}" == "HostB" ]
then
	TAP="tap65"
	sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "10.19.3.33" dev "${TAP}"
	sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "10.19.3.33" dev "${TAP}"
	sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "10.19.3.33" dev "${TAP}"
	sudo route add -net "${RED_D}" netmask "${MASK_24}" gw "10.19.3.33" dev "${TAP}"
	sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "10.19.3.33" dev "${TAP}"
	sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_N}" netmask "${MASK_26}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_ENIE}" netmask "${MASK_24}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "10.19.3.34" dev "${TAP}"
	sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "10.19.3.33" dev "${TAP}"

elif [ "${NOMBRE_CLIENTE}" == "HostC" ]
then
	_GATEWAY="10.19.3.97"     #R13
	TAP="tap66"
	sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_D}" netmask "${MASK_24}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_N}" netmask "${MASK_26}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_ENIE}" netmask "${MASK_24}" gw "10.19.3.98" dev "${TAP}"
	sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "10.19.3.98" dev "${TAP}"
	sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "10.19.3.98" dev "${TAP}"
	sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "10.19.3.97" dev "${TAP}"
	sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "10.19.3.98" dev "${TAP}"
	sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "10.19.3.98" dev "${TAP}"

elif [ "${NOMBRE_CLIENTE}" == "WEBSERVER" ]
then
    #_GATEWAY="192.168.71.1"     #R3
    C_GW_ABIJMK="192.168.71.3" #Rv34
    C_GW_GHLNENIEOPQRS="192.168.71.4" #R5
    TAP="tap118"
    
    #ruteo de C
    sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"

    sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "${C_GW_ABIJMK}" dev "${TAP}"
    sudo route add -net "${RED_N}" netmask "${MASK_26}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_ENIE}" netmask "${MASK_24}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"
    sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "${C_GW_GHLNENIEOPQRS}" dev "${TAP}"

elif [ "${NOMBRE_CLIENTE}" == "FTPSERVER" ]
then
    #_GATEWAY="10.19.2.2"     #R11
    J_GW_GHLNQRS="10.19.2.5" #R10
    J_GW_KMOPENIEB3="10.19.2.2" #R11
    J_GW_B12ACI="10.19.2.3" #R12
    TAP="tap119"
    
    #ruteo de J
    sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "${J_GW_B12ACI}" dev "${TAP}"
    sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "${J_GW_B12ACI}" dev "${TAP}"
    sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "${J_GW_B12ACI}" dev "${TAP}"
    sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "${J_GW_B12ACI}" dev "${TAP}"
    sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "${J_GW_B12ACI}" dev "${TAP}"
    sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_N}" netmask "${MASK_26}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_ENIE}" netmask "${MASK_24}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "${J_GW_KMOPENIEB3}" dev "${TAP}"
    sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "${J_GW_GHLNQRS}" dev "${TAP}"
    sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "${J_GW_GHLNQRS}" dev "${TAP}"

elif [ "${NOMBRE_CLIENTE}" == "TELSERVER" ]
then
    #_GATEWAY_N="10.47.1.129"     #R9
    #_GATEWAY_ENIE="10.47.2.1"    #R14
    N_GW="10.47.1.129" #R9
    ENIE_GW_ABMK="10.47.2.1" #R14
    ENIE_GW_OP="10.47.2.2" #R15
    ENIE_GW_HIJGLC="10.47.2.3" #R16
    TAPN="tap321"
    TAPENIE="tap654"
    
    #ruteo de N. Todos van por R9 (unico)
    sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "${N_GW}" dev "${TAPN}"
    
    #ruteo de enie.
    sudo route add -net "${RED_A}" netmask "${MASK_24}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_B1}" netmask "${MASK_30}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_B2}" netmask "${MASK_30}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_B3}" netmask "${MASK_30}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_G}" netmask "${MASK_27}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_H}" netmask "${MASK_28}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_I}" netmask "${MASK_30}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_J}" netmask "${MASK_25}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_K}" netmask "${MASK_30}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_L}" netmask "${MASK_27}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_M}" netmask "${MASK_27}" gw "${ENIE_GW_ABMK}" dev "${TAPENIE}"
    sudo route add -net "${RED_O}" netmask "${MASK_29}" gw "${ENIE_GW_OP}" dev "${TAPENIE}"
    sudo route add -net "${RED_P}" netmask "${MASK_28}" gw "${ENIE_GW_OP}" dev "${TAPENIE}"
    sudo route add -net "${RED_Q}" netmask "${MASK_30}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_R}" netmask "${MASK_30}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
    sudo route add -net "${RED_S}" netmask "${MASK_30}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
	sudo route add -net "${RED_C}" netmask "${MASK_24}" gw "${ENIE_GW_HIJGLC}" dev "${TAPENIE}"
	exit 0
else
	echo "El primer parametro debe ser: 'HostA', 'HostB', 'HostC', 'DNSROOT', 'DNS1', 'DNS2', 'WEBSERVER', 'FTPSERVER' o 'TELSERVER'"
	exit 1
fi

#sudo route add gw ${_GATEWAY}

exit 0


