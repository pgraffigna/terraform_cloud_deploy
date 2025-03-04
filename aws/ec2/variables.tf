variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0" # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "terra-vm"
}

variable "my_ip" {
  default = "0.0.0.0/0"
}
