terraform {
   required_providers {
   aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
      }
   }
}

provider "aws" {
   region = var.region
   access_key = var.access_key
   secret_key = var.secret_key
}

variable "instance_count" {
   description = "cantidad de instancias a crear"
   default     = 2
}

# Definir un par de claves para acceder a la instancia
resource "aws_key_pair" "keys" {
   key_name   = "testing-cli"
   public_key = file("~/.ssh/id_rsa.pub")
}

# Definir el grupo de seguridad
resource "aws_security_group" "sg_webserver" {
   name        = "sg_webserver"
   description = "sg_webserver"

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
resource "aws_instance" "ec2_replicas" {
   count         = var.instance_count # multi-instancias
   ami           = "ami-0ae8f15ae66fe8cda"  # Amazon Linux
   instance_type = "t2.micro"
   key_name      = aws_key_pair.keys.key_name
   security_groups = [aws_security_group.sg_webserver.name]

   user_data = <<-EOF
      #!/bin/bash
      yum update -y
      yum install -y httpd
      systemctl enable httpd --now
      echo "<h1>Hola AWS! desde $(hostname -f)</h1>" > /var/www/html/index.html
   EOF

   tags = {
   #Name = "EC2-free_tier-01"
   Name = "EC2-free_tier-${count.index + 1}"
   }
}

# Crear Target Group para el Load Balancer
resource "aws_lb_target_group" "tg-webservers" {
   name     = "tg-webservers"
   port     = 80
   protocol = "HTTP"
   vpc_id   = var.vpc_default


   health_check {
      path                = "/index.html"
      interval            = 30
      timeout             = 5
      healthy_threshold   = 2
      unhealthy_threshold = 2
      matcher             = "200"
   }
}

# Asignar Instancias EC2 al Target Group
resource "aws_lb_target_group_attachment" "tg-webservers-attachment" {
   count            = var.instance_count
   target_group_arn = aws_lb_target_group.tg-webservers.arn
   target_id        = aws_instance.ec2_replicas[count.index].id
   port             = 80
}

# Crear Load Balancer
resource "aws_lb" "lb-webservers" {
   name               = "lb-webservers"
   internal           = false
   load_balancer_type = "application"
   security_groups    = [aws_security_group.sg_webserver.id]
   subnets            = [var.subnet_a, var.subnet_b, var.subnet_c]

   enable_deletion_protection = false

   tags = {
      Name = "lb-webservers"
   }
}

# Crear Listener para el Load Balancer
resource "aws_lb_listener" "list_webservers_lb" {
   load_balancer_arn = aws_lb.lb-webservers.arn
   port              = 80
   protocol          = "HTTP"

   default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.tg-webservers.arn
   }
}

# # Muestra IP pública de la instancia
# output "ip_publica" {
#    description = "La IP publica del server"
#    value       = aws_instance.EC2-free_tier-01.public_ip
# }

# Muestra las ips publicas de las instancias
output "ec2_public_ips" {
   description = "Las direcciones IP públicas de las instancias EC2 creadas"
   value       = [for instance in aws_instance.ec2_replicas : instance.public_ip]
}

# Output para mostrar la URL del Load Balancer
output "load_balancer_url" {
   description = "La URL del Load Balancer"
   value       = aws_lb.lb-webservers.dns_name
}