output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.main.id
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.main.public_ip
}

output "instance_ipv6" {
  description = "IPv6 pública de la instancia"
  value       = try(aws_instance.main.ipv6_addresses[0], "No tiene IPv6")
}
