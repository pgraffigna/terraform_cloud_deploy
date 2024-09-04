# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_test.id
}

# tabla de ruteo para la subred publica - conexion al gateway
resource "aws_route_table" "rt_publica" {
  vpc_id = aws_vpc.vpc_test.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# asociacion de tabla de ruteo con subred publica 1
resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.subnet_1.id
  route_table_id = aws_route_table.rt_publica.id
}
# asociacion de tabla de ruteo con subred publica 2
resource "aws_route_table_association" "rta_2" {
  subnet_id      = aws_subnet.subnet_2.id
  route_table_id = aws_route_table.rt_publica.id
}