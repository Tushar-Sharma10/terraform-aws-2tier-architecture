output "public_sg_id" {
  value       = aws_security_group.public_sg.id
  description = "Public Security Group ID"
}

output "private_sg_id" {
  value       = aws_security_group.private_sg.id
  description = "Private Security Group ID"
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
  description = "RDS Security Group ID"
}