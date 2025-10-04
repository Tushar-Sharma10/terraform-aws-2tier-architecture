output "ec2_role_name" {
  description = "IAM Role Name for EC2"
  value       = aws_iam_role.ec2_role.name
}

output "ec2_role_arn" {
  description = "IAM Role ARN for EC2"
  value       = aws_iam_role.ec2_role.arn
}

output "attached_policies" {
  description = "List of attached managed policies"
  value = [
    aws_iam_role_policy_attachment.cloudwatch.policy_arn,
    aws_iam_role_policy_attachment.s3_read_only.policy_arn
  ]
}
