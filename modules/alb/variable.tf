variable "project_name" {
  description = "Name of the Project"
  type        = string
}

variable "target_type" {
  description = "Type of target(e.g; instance, ip, alb)"
  type        = string
  default     = "instance"
}

variable "port" {
  description = "Port number on which target receives traffic"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol to use for routing traffic to the targets"
  type        = string
  default     = "HTTP"
}

variable "protocol_version" {
  description = "The protocol version"
  type        = string
  default     = "HTTP1"
}

variable "ip_address_type" {
  description = "Type of ip address(e.g: ipv4 or ipv6)"
  type        = string
  default     = "ipv4"

  validation {
    condition     = contains(["ipv4", "ipv6"], lower(var.ip_address_type))
    error_message = "Ip address type must be ipv4 or ipv6"
  }
}

variable "vpc_id" {
  description = "Identifier of the vpc"
  type        = string
}

variable "path" {
  description = "health check path"
  type        = string
  default     = "/"
}

variable "healthy_threshold" {
  description = "Number of health checks required to consider the target healthy"
  type        = number
  default     = 3
}

variable "interval" {
  description = "Time duration between health checks of a target"
  type        = number # Seconds
  default     = 30
}

variable "unhealthy_threshold" {
  description = "Number of health check required to consider the target unhealthy"
  type        = number
  default     = 10
}

variable "timeout" {
  description = "Amount of time during which no response from target means a failed health check"
  type        = number # Seconds
  default     = 10
}

variable "enable_health_check" {
  type    = bool
  default = true
}

variable "environment" {
  description = "Working Environment"
  type        = string
  default     = "Testing"
}