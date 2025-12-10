variable "name" {
  description = "Load balancer name"
  type        = string
}

variable "internal" {
  description = "Is internal LB"
  type        = bool
  default     = false
}

variable "type" {
  description = "LB type (application or network)"
  type        = string
  default     = "application"
}

variable "security_groups" {
  description = "Security group IDs"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "Subnet IDs"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "target_group_name" {
  description = "Target group name"
  type        = string
}

variable "target_port" {
  description = "Target port"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "Listener port"
  type        = number
  default     = 80
}

variable "protocol" {
  description = "Protocol (HTTP or TCP)"
  type        = string
  default     = "HTTP"
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
# Updated 1765335459
# Updated 1765335730
