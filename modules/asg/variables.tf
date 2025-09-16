variable "project_name" {
  description = "name of the project"
  type        = string
}
variable "description" {
  description = "Description of the launch template"
  type        = string
  default     = "Launch template for ASG that includes ec2 instances"
}

variable "instance_type" {
  description = "Type of the instance"
  type        = string
  default     = "t2.micro"
}

variable "security_group_ids" {
  description = "list of the names of the security groups"
  type        = list(string)
}

variable "user_data" {
  description = "User data file"
  type        = string
  default     = "null"
}

variable "enabled_monitoring" {
  description = "Enable monitoring select from true or false"
  type        = bool
  default     = true
}

variable "public_key_path" {
  description = "path to the public key"
  type        = string
  default     = "~/.ssh/my-aws-key.pub"
}

variable "environment" {
  description = "Working Environment"
  type        = string
  default     = "Testing"
}