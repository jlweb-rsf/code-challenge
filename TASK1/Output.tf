
output "ALB_DNS_RECORD" {
  value       = aws_alb.assignment_alb.dns_name
  description = "Public DNS of Application load balancer"
}


output "APACHE_PRIVATE_IP" {
  value       = aws_instance.apache_server.private_ip
  description = "Apache Server Private IP"
}


output "private_az_subnet_ids" {
  value = module.private_subnets.az_subnet_ids
}

output "public_az_subnet_ids" {
  value = module.public_subnets.az_subnet_ids
}