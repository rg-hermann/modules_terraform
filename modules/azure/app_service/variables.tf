variable "app_service_name" {
  description = "App Service name"
  type        = string
}

variable "app_service_plan_name" {
  description = "App Service Plan name"
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

variable "kind" {
  description = "Kind (Linux or Windows)"
  type        = string
  default     = "Linux"
}

variable "reserved" {
  description = "Is reserved (Linux)"
  type        = bool
  default     = true
}

variable "sku_tier" {
  description = "SKU tier (Free, Basic, Standard)"
  type        = string
  default     = "Basic"
}

variable "sku_size" {
  description = "SKU size (B1, B2, S1)"
  type        = string
  default     = "B1"
}

variable "dotnet_framework_version" {
  description = ".NET Framework version"
  type        = string
  default     = ""
}

variable "linux_fx_version" {
  description = "Linux FX version"
  type        = string
  default     = "NODE|16-lts"
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
# Updated 1765335468
