# load-balancer
resource "aws_lb" "lb" {
  name               = "lb-sg"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_para_lb.id]
  subnets            = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  depends_on         = [aws_internet_gateway.gw]
}

# target-group
resource "aws_lb_target_group" "lb_tg" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_test.id
}

# load-balancer listener
resource "aws_lb_listener" "lb_lt" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}

# Muestra URL de load_balancer
output "load_balancer_url" {
  description = "La URL del Load Balancer"
  value       = aws_lb.lb.dns_name
}