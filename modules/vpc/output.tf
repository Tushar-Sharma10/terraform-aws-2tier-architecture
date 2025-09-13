# vpc id
output "vpc_id" {
  description = "VPC id"
  value       = aws_vpc.this.id
}

# PUBLIC SUBNET ID
output "public_subnet_ids" {
  description = "ID's of public subnets"
  value       = aws_subnet.publicsubnet[*].id
}

# PRIVATE SUBNET ID
output "private_subnet_ids" {
  description = "ID's of private subnets"
  value       = aws_subnet.privatesubnet[*].id
}