# terraform_deploy

Archivos de configuración y notas para desplegar servicios usando terraform.

Testeado con Vagrant + QEMU + ubuntu_22.04.

---

### Descripción

La idea del proyecto es automatizar vía terraform el despliegue de infraestructura en diferentes proveedores cloud, el repo cuenta con 4 perfiles:
1. aws
2. localstack
3. proxmox
4. upcloud

### Dependencias

* [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [Vagrant](https://developer.hashicorp.com/vagrant/install) (opcional)

### Extras
* Archivo de configuración (Vagrantfile) para desplegar una VM descartable con ubuntu-22.04 con libvirt como hipervisor.
* Archivo con notas para utilizar terraform.

### Uso Vagrant
```shell
vagrant up
vagrant upload file
vagrant ssh
```