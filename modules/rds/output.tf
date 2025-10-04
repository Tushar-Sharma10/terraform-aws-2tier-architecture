output "rds_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.db_instance.endpoint
}

output "rds_port" {
  description = "The port the RDS instance is listening on"
  value       = aws_db_instance.db_instance.port
}

output "rds_instance_id" {
  description = "The RDS instance ID"
  value       = aws_db_instance.db_instance.id
}

output "rds_arn" {
  description = "The ARN of the RDS instance"
  value       = aws_db_instance.db_instance.arn
}
