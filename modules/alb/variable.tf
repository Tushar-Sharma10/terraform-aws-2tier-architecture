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


# LOAD BALANCER VARIABLES
variable "load_balancer_type" {
  description = "Type of load balancer"
  type        = string
  default     = "application"

  validation {
    condition     = contains(["application", "gateway", "network"], lower(var.load_balancer_type))
    error_message = "Select from these 3 load balacners only(application, gateway, network)"
  }
}

variable "lb_ip_type" {
  description = "Type of ip address type for load balancer"
  type        = string
  default     = "ipv4"

  validation {
    condition     = contains(["ipv4", "dualstack", "dualstack-without-public-ipv4"], var.lb_ip_type)
    error_message = "LB ip type must be ipv4, dualstack or dualstack-without-public-ipv4"
  }
}

variable "internal" {
  description = "Select false for internet-facing lb and vice-versa for internal"
  type        = bool
  default     = false

}

variable "security_group" {
  description = "Security group id for load balancer"
  type        = list(string)
}

variable "subnets" {
  description = "List of subnets to attach to LB"
  type        = list(string)
}

variable "enable_access_logs" {
  description = "Boolean to enable/disable access logs"
  type        = bool
  default     = false
}

variable "enable_connection_logs" {
  description = "Boolean to enable/disable access logs"
  type        = bool
  default     = false
}

variable "bucket_name" {
  description = "Bucket name where access logs or connection logs need to be stored"
  type        = string
}

variable "type" {
  description = "Type of routing action"
  type        = string
  default     = "forward"
}