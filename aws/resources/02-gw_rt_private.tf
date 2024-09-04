# Elastic IP para NAT gateway
resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.gw]
  domain = "vpc"
  tags = {
    Name = "eip_nat"
  }
}

# NAT gateway para subred privada
resource "aws_nat_gateway" "nat_subred_privada" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.subnet_1.id # nat tiene que estar en subred publica

  tags = {
    Name = "nat_subred_privada"
  }

  depends_on = [aws_internet_gateway.gw]
}

# tabla de ruteo para la subred privada - conexion al gateway
resource "aws_route_table" "rt_privada" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_subred_privada.id
  }
}

# asociacion de tabla de ruteo con subred privada
resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.subnet_3.id
  route_table_id = aws_route_table.rt_privada.id
}