output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.launch_template.id
}

output "launch_template_name" {
  description = "The name of the launch template"
  value       = aws_launch_template.launch_template.name
}

output "ami_id" {
  description = "The AMI ID used in the launch template"
  value       = data.aws_ami.ubuntu_ami.image_id
}

output "key_pair_name" {
  description = "The name of the key pair associated with the instances"
  value       = aws_key_pair.ec2_key.key_name
}

output "asg_name" {
  value = aws_autoscaling_group.asg.name
}