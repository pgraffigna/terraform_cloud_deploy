#!/usr/bin/env bash

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# Variables
TERRA_URL="https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip"
TERRA_ZIP="terraform_1.3.6.zip"
HOME_USER="/home/vagrant"
USER_API=""
PASS_API=""

# CTRL-C
trap ctrl_c INT
function ctrl_c() {
   echo -e "\n${ROJO}[TERRAFORM] Programa Terminado ${FIN}"
   exit 0
}

echo -e "${AMARILLO}[TERRAFORM] Descargando + instalando Terraform ${FIN}"
wget -q "$TERRA_URL" -O "/tmp/$TERRA_ZIP" && sudo unzip "/tmp/$TERRA_ZIP" -d /usr/local/bin

echo -e "${AMARILLO}[TERRAFORM] Creando las credenciales de acceso para upcloud ${FIN}"
tee -a "$HOME_USER/.bashrc" >/dev/null <<EOF
################ UPCLOUD-API ###############
export UPCLOUD_USERNAME="$USER_API"
export UPCLOUD_PASSWORD="$PASS_API"
EOF

echo -e "${VERDE}[TERRAFORM] Todos los procesos terminaron correctamente!!! ${FIN}"



