#!/usr/bin/env bash
# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# Variables
TERRA_URL="https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip"
TERRA_ZIP="terraform_1.7.5_linux_amd64.zip"

# CTRL-C
trap ctrl_c INT
function ctrl_c() {
   echo -e "\n${ROJO}[TERRAFORM] Programa Terminado ${FIN}"
   exit 0
}

echo -e "${AMARILLO}[TERRAFORM] Descargando + instalando Terraform ${FIN}"
wget -q "$TERRA_URL" -O "/tmp/$TERRA_ZIP" && sudo unzip "/tmp/$TERRA_ZIP" -d /usr/local/bin

echo -e "${VERDE}[TERRAFORM] Todos los procesos terminaron correctamente!!! ${FIN}"

# terraform fmt
# terraform init
# terraform plan
# terraform apply 