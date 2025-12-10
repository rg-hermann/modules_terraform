variable "workspace_name" {
  description = "Nome do Log Analytics Workspace"
  type        = string
}

variable "location" {
  description = "Região do workspace"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group do workspace"
  type        = string
}

variable "sku" {
  description = "SKU do workspace"
  type        = string
  default     = "PerGB2018"
}

variable "retention_days" {
  description = "Dias de retenção (30-730)"
  type        = number
  default     = 30
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}

variable "enable_diagnostics" {
  description = "Se true cria diagnostic settings para recursos passados."
  type        = bool
  default     = true
}

variable "aks_id" {
  description = "ID do cluster AKS (opcional)"
  type        = string
  default     = ""
}

variable "keyvault_id" {
  description = "ID do Key Vault (opcional)"
  type        = string
  default     = ""
}

variable "storage_account_id" {
  description = "ID do Storage Account (opcional)"
  type        = string
  default     = ""
}

variable "acr_id" {
  description = "ID do ACR (opcional)"
  type        = string
  default     = ""
}
