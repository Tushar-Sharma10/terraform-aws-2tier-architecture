variable "cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "Select where the resources need to be build(e.g Shared hardware or dedicated hardware)"
  type        = string
  default     = "default" # Can be set to dedicated for dedicated servers
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Working environment"
  type        = string
  default     = "Production"
}

variable "availability_zone" {
  description = "List of AZ's"
  type        = list(string)
}

variable "public_cidr" {
  description = "CIDR block(s) for public subnet(s)"
  type        = list(string)
}

variable "private_cidr" {
  description = "CIDR block(s) for private subnet(s)"
  type        = list(string)
}