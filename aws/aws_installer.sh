#!/usr/bin/env bash
#
# Autor: Pablo Graffigna
# URL: www.linkedin.com/in/pablo-graffigna
#

# Colores
VERDE="\e[0;32m\033[1m"
ROJO="\e[0;31m\033[1m"
AMARILLO="\e[0;33m\033[1m"
FIN="\033[0m\e[0m"

# CTRL-C
trap ctrl_c INT
function ctrl_c() {
   echo -e "\n${ROJO}[AWS-CLI] Programa Terminado ${FIN}"
   exit 0
}

echo -e "${AMARILLO}[AWS-CLI] Instalando aws-cli ${FIN}"
sudo apt-get update && sudo apt-get install -y awscli

echo -e "${VERDE}[AWS-CLI] Configurando perfil ${FIN}"
mkdir ~/.aws && touch ~/.aws/{config,credentials}

cat << 'EOF' | tee ~/.aws/config > /dev/null
[profile localstack]
region=us-east-1
output=json
endpoint_url = http://localhost:4566
EOF

cat << 'EOF' | tee ~/.aws/credentials > /dev/null
[localstack]
aws_access_key_id=testing_ACCESS
aws_secret_access_key=testing_SECRET
EOF

# export AWS_PROFILE=localstack