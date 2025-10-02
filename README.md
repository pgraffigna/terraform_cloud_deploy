# terraform_deploy

Archivos de configuración y notas para desplegar servicios usando terraform.

Testeado con Vagrant + QEMU + ubuntu_22.04.

---

### Descripción

La idea del proyecto es automatizar vía terraform el despliegue de infraestructura en diferentes proveedores, el repo cuenta con 4 perfiles:
1. aws
2. proxmox
3. upcloud
4. vagrant

### Dependencias

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* Archivo con notas para utilizar terraform.
* Script para instalar terraform,aws en linx.

### Uso Vagrant
```shell
vagrant up
vagrant upload file
vagrant ssh
```

### Comandos Terraform

| comando                                                 | Descripcion                                                 |
|---------------------------------------------------------|-------------------------------------------------------------|
| terraform init  	                                      | Inicializa Terraform  	                                    |
| terraform fmt	                                          | Formatea los archivos tf                                    |
| terraform validate	                                    | Valida la configuracion del plan                            |
| terraform plan 	                                        | Lista el plan de ejecución  	                              |
| terraform plan -destroy                                 | Revisa los recursos a destruir                              |
| terraform apply -auto-approve	                          | Aplica la configuración                                     |
| terraform destroy	                                      | Destruye los recursos                                       |
| terraform destroy -target=aws_instance.ec2-01         	| Destruye una instancia especifica                           |
