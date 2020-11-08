#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
redColour="\e[0;31m\033[1m"
yellowColour="\e[0;33m\033[1m"
endColour="\033[0m\e[0m"

#Variables
VERSION=0.13.5

#CTRL-C
trap ctrl_c INT
function ctrl_c() {
   echo -e "\n${redColour}[!!] Programa Terminado ${endColour}"
   exit 0
}

echo -e "${yellowColour} [!!] Descargando e instalado Terraform ${endColour}"
wget https://releases.hashicorp.com/terraform/"$VERSION"/terraform_"$VERSION"_linux_amd64.zip
sudo unzip terraform_"$VERSION"_linux_amd64.zip -d /usr/local/bin

echo -e "${yellowColour} [!!] Creando las credenciales de acceso para UPCLOUD ${endColour}"
echo "export UPCLOUD_USERNAME=USER_API" | tee -a ~/.bashrc
echo "export UPCLOUD_PASSWORD=PASS_API" | tee -a ~/.bashrc

echo -e "${greenColour} [!!] Todos los procesos terminaron correctamente!!! ${endColour}"



