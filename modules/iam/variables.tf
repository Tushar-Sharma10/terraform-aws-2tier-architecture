variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev/prod)"
  type        = string
}

variable "attach_s3_read_only" {
  description = "Whether to attach S3 ReadOnly policy"
  type        = bool
  default     = true
}

