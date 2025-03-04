# grupo de seguridad
resource "aws_security_group" "vm_sg" {
  name        = "vm_security_group"
  description = "Permite SSH, HTTP y HTTPS solo desde mi IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "udp"
    cidr_blocks = [var.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "terra_keys"
  public_key = file("~/.ssh/terra_keys.pub")
}

resource "aws_instance" "main" {
  ami           = var.ami_id
  instance_type = var.instance_type
  user_data     = filebase64("user_data.sh")
  key_name      = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.vm_sg.id]

  tags = {
    Name = var.instance_name
  }
}
