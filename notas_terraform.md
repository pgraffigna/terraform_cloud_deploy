### Inicializa Terraform
```shell
terraform init
```

### Revisa el plan de ejecución
```shell
terraform plan
```

### Aplica la configuración
```shell
terraform apply
```

### Revisa los recursos a destruir
```shell
terraform plan -destroy
```

### Destruye los recursos
```shell
terraform destroy
```

### Eliminar recursos específicos
```shell
terraform destroy -target=aws_instance.EC2-free_tier-01
```