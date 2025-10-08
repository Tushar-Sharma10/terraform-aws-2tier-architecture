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
  default     = null
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

## AUTO SCALING GROUP VARIABLES
variable "subnets" {
  description = "A list of az's where instances in asg can be created"
  type        = list(string)
}

variable "max_size" {
  description = "Maximum size of the auto scaling group"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum size of auto scaling group"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired capacity size of auto scaling group"
  type        = number
  default     = 2
}

variable "default_cooldown" {
  description = "Default cooldown after a scaling activity completes before another scaling activiy can start"
  type        = number
  default     = 30 # SECONDS
}

variable "default_instance_warmup" {
  description = "Time until a mew instance contribute to cloudwatch metrics"
  type        = number
  default     = 30 #SECONDS    
}

variable "health_check_grace_period" {
  description = "Time after instance comes into service before checking health"
  type        = number
  default     = 300 #SECONDS
}

variable "health_check_type" {
  description = "Controls how health check is done"
  type        = string
  default     = "EC2"
  validation {
    condition     = contains(["EC2", "ELB"], upper(var.health_check_type))
    error_message = "Valid values are only EC2 and ELB"
  }
}

variable "force_delete" {
  description = "Allows deleting the Auto Scaling Group without waiting for all instances in the pool to terminate."
  type        = bool
  default     = true
}

variable "target_group_arns" {
  description = "Arn of the target group"
  type        = list(string)
}

variable "strategy" {
  description = "Strategy to use for instance refresh"
  type        = string
  default     = "Rolling"
}

variable "max_healthy_percentage" {
  description = "Amount of capacity in the asg that can be in service and healthy"
  type        = number
  default     = 100
}

variable "min_healthy_percentage" {
  description = "Amount of capacity in the asg that must be in service and healthy"
  type        = number
  default     = 90
}

variable "enable_scaling" {
  description = "Whether the scalling policy is enabled or not"
  type        = bool
  default     = true
}

variable "policy_type" {
  description = "Type of the asg policy"
  type        = string
  default     = "TargetTrackingScaling"
  validation {
    condition     = contains(["TargetTrackingScaling"], var.policy_type)
    error_message = "This module is only valid for TargetTrackingScaling"
  }
}

variable "target_value" {
  description = "Target value for the metric"
  type        = number
  default     = 50
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to EC2 instances"
  type        = string
  default     = null
}
