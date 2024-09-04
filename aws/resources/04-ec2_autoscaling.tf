# ec2
resource "aws_launch_template" "ec2" {
  name_prefix   = "ec2"
  image_id      = "ami-0ae8f15ae66fe8cda"
  instance_type = "t2.micro"
  user_data     = filebase64("user_data.sh")

  network_interfaces {
    associate_public_ip_address = false
    subnet_id                   = aws_subnet.subnet_3.id
    security_groups             = [aws_security_group.sg_para_ec2.id]
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ec2-01"
    }
  }
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity = 1
  max_size         = 1
  min_size         = 1

  # Connect to the target group
  target_group_arns = [aws_lb_target_group.lb_tg.arn]

  vpc_zone_identifier = [
    aws_subnet.subnet_3.id
  ]

  launch_template {
    id      = aws_launch_template.ec2.id
    version = "$Latest"
  }
}
