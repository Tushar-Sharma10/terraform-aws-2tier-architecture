output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "public_sg_id" {
  description = "Public Security Group ID for ALB/NAT"
  value       = module.security_group.public_sg_id
}

output "private_sg_id" {
  description = "Private Security Group ID for EC2"
  value       = module.security_group.private_sg_id
}

output "rds_sg_id" {
  description = "Security Group ID for RDS"
  value       = module.security_group.rds_sg_id
}

output "ec2_instance_profile" {
  description = "Instance profile name to attach to EC2"
  value       = module.iam.instance_profile_name
}

output "ec2_role_arn" {
  description = "IAM Role ARN for EC2 instances"
  value       = module.iam.ec2_role_arn
}

output "alb_name" {
  description = "Name of the Application Load Balancer"
  value       = module.alb.lb_name
}

output "alb_arn" {
  description = "ARN of the Application Load Balancer"
  value       = module.alb.load_balancer_arn
}

output "alb_target_group_arn" {
  description = "ARN of the ALB Target Group"
  value       = module.alb.target_arn
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.asg.asg_name
}

output "rds_endpoint" {
  description = "Endpoint of the RDS instance"
  value       = module.rds.rds_endpoint
}

output "rds_port" {
  description = "Port of the RDS instance"
  value       = module.rds.rds_port
}

output "rds_instance_id" {
  description = "RDS instance ID"
  value       = module.rds.rds_instance_id
}

output "rds_arn" {
  description = "ARN of the RDS instance"
  value       = module.rds.rds_arn
}
