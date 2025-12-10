variable "server_name" {
  description = "PostgreSQL server name"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "admin_login" {
  description = "Admin username"
  type        = string
}

variable "admin_password" {
  description = "Admin password (sensitive)"
  type        = string
  sensitive   = true
}

variable "sku_name" {
  description = "SKU name (e.g. B_Standard_B1ms)"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "storage_mb" {
  description = "Storage in MB"
  type        = number
  default     = 32768
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "databases" {
  description = "List of database names"
  type        = list(string)
  default     = ["appdb"]
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
