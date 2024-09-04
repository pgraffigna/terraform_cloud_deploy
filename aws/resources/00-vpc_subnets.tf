# VPC
resource "aws_vpc" "vpc_test" {
  cidr_block = "10.0.0.0/23"
  tags = {
    Name = "pgraffigna-vpc"
  }
}

# subred publica
resource "aws_subnet" "subnet_1" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = "10.0.0.1/27"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
}
# subred publica
resource "aws_subnet" "subnet_2" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = "10.0.0.32/27"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
}
# subred privada
resource "aws_subnet" "subnet_3" {
  vpc_id                  = aws_vpc.vpc_test.id
  cidr_block              = "10.0.0.64/27"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
}