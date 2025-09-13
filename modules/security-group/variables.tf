variable "vpc_id" {
  description = "VPC_id for associating security groups"
  type        = string
}

variable "ip_protocol" {
  description = "IP protocol"
  type        = string
  default     = "tcp"
}

variable "all_ports" {
  description = "All ports ip protocol"
  type        = string
  default     = "-1"
}

variable "environment" {
  description = "Working environment"
  default     = "Testing"
}

variable "public_sg" {
  description = "Name of the public security group"
  type        = string
  default     = "public-sg"
}

variable "private_sg" {
  description = "Name of the private security group"
  type        = string
  default     = "private-sg"
}