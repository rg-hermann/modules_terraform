variable "identifier" {
  description = "DB instance identifier"
  type        = string
}

variable "engine" {
  description = "DB engine"
  type        = string
  default     = "postgres"
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Allocated storage (GB)"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password (sensitive)"
  type        = string
  sensitive   = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot on destroy"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
