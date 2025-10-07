variable "region" {
  description = "Region where resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "two-tier-architecture"
}

variable "environment" {
  description = "Working Environment"
  type        = string
  default     = "Development"
}

variable "bucket_name" {
  description = "Bucket name where access logs and connection logs need to be stored"
  type        = string
  default     = "bucket-name" # CHANGE IT ACCORDINGLY
}

variable "db_username" {
  description = "Username of the database"
  type        = string
  sensitive   = true
  default     = "username" # CREATE YOUR OWN USERNAME
}

variable "db_password" {
  description = "Database Password"
  type        = string
  sensitive   = true
  default     = "password" # CREATE YOUR OWN PASSWORD
}

variable "final_snapshot_identifier" {
  description = "Name of the final snapshot"
  type        = string
  default     = "Final_snap"
}

variable "instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro" # CHANGE IT ACCORDING TO USAGE
}