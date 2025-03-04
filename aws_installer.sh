#!/usr/bin/env bash
# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# Variables
AWS_URL="https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip"
AWS_ZIP="awscliv2.zip"
PATH_INSTALL=/home/vagrant/aws/install

# CTRL-C
trap ctrl_c INT
function ctrl_c() {
  echo -e "\n${ROJO}[AWS] Programa Terminado ${FIN}"
  exit 0
}

echo -e "${AMARILLO}[AWS] Descargando + instalando AWS ${FIN}"
curl -s $AWS_URL -o /tmp/$AWS_ZIP
unzip /tmp/$AWS_ZIP
sudo bash $PATH_INSTALL
aws --version

echo -e "${VERDE}[AWS] Todos los procesos terminaron correctamente!!! ${FIN}"





