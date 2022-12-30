# terraform_upcloud_deploy

Repo con archivos para crear una VM via Terraform en Upcloud + instalación de docker y docker-compose.

---

pasos:
- "terraform init" para crear el proyecto
- "terraform plan" para definir el plan
- "terraform apply" para desplegar la infra
- "terraform destroy" para destruir la infra

archivos:
- 00-terra_install.sh
- 01-version.tf
- 02-server_deploy.tf


