variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Working enviornment"
  type        = string
  default     = "Testing"

}
variable "subnet_ids" {
  description = "Ids of the subnets where rds instance need to be created"
  type        = list(string)
}
variable "instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "allocated_storage" {
  description = "The amount of allocated storage"
  type        = number
  default     = 5
}

variable "max_allocated_storage" {
  description = "Specify the maximum storage"
  type        = number
  default     = 10
}

variable "engine" {
  description = "The database engine to use for this db instance"
  type        = string
  default     = "mysql"
}

variable "db_name" {
  description = "Name of the Database to create when the DB instance is created"
  type        = string
}

variable "delete_automated_backups" {
  description = "Specifies whether to remove the automated backup after the db instance has been deleted"
  type        = bool
  default     = true
}

variable "skip_final_snapshot" {
  description = "Do you want to skip the final snapshot or not "
  type        = bool
  default     = true
}

variable "final_snapshot_identifier" {
  description = "The name of your final db snapshot when db instane is deleted"
  type        = string
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately"
  type        = bool
  default     = false
}

variable "database_insights_mode" {
  description = "The mode of database insight that is enabled for the instance"
  type        = string
  validation {
    condition     = contains(["standard", "advanced"], var.database_insights_mode)
    error_message = "Only standard and advanced option can be selected"
  }
  default = "standard"
}

variable "cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs"
  type        = list(string)
  default     = ["error", "general"]
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = false
}

variable "network_type" {
  description = "The network type of the DB instance."
  type        = string
  default     = "IPV4"
  validation {
    condition     = contains(["IPV4", "DUAL"], var.network_type)
    error_message = "Only valid values are ipv4 and dual"
  }
}

variable "port" {
  description = "The port on which the MySQL DB accepts connections"
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  description = "Bool to control if instance is publicly accessible."
  type        = bool
  default     = false
}

variable "engine_version" {
  description = "version of engine"
  type        = string
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "security_group_ids" {
  description = "Security Group ID"
  type        = list(string)
}