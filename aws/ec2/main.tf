terraform {
   required_providers {
      aws = {
         source = "hashicorp/aws"
         version = "~> 4.0"
      }
   }
}

provider "aws" {
   region = "us-east-1"
   access_key = "AKIAQKPIL7S4K2GMC34K"
   secret_key = "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"
}

# Definir un par de claves para acceder a la instancia
resource "aws_key_pair" "pgraffigna" {
   key_name   = "pgraffigna-cli"
   public_key = file("~/.ssh/id_rsa.pub")
}

# Definir el grupo de seguridad
resource "aws_security_group" "webserver" {
   name        = "webserver"
   description = "webserver"

# Allow ssh solo desde mi IP
ingress {
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   #cidr_blocks = ["0.0.0.0/0"]
   cidr_blocks = ["IP/32"]
   }

# Allow http desde todos lados
ingress {
   from_port   = 80
   to_port     = 80
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
}

egress {
   from_port   = 0
   to_port     = 0
   protocol    = "-1"
   cidr_blocks = ["0.0.0.0/0"]
   }
}

# Crear la instancia EC2
resource "aws_instance" "EC2-free_tier-01" {
   ami           = "ami-0ae8f15ae66fe8cda"  # Amazon Linux 2, free tier eligible AMI
   instance_type = "t2.micro"  # Free tier elegible instance type
   key_name      = aws_key_pair.pgraffigna.key_name
   security_groups = [aws_security_group.webserver.name]

   user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl enable httpd --now
      echo "<h1>Hola AWS! desde $(hostname -f)</h1>" > /var/www/html/index.html
   EOF

   tags = {
   Name = "EC2-free_tier-01"
   }
}

# Muestra IP pública de la instancia
output "ip_publica" {
   description = "La IP publica del server"
   value       = aws_instance.EC2-free_tier-01.public_ip
}