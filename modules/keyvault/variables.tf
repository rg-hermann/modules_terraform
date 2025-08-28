variable "keyvault_name" {
  description = "Nome do Key Vault"
  type        = string
}

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

variable "tenant_id" {
  description = "ID do tenant Azure"
  type        = string
}

variable "sku_name" {
  description = "SKU do Key Vault (Standard ou Premium)"
  type        = string
  default     = "standard"
}

variable "object_id" {
  description = "Object ID do usuário ou aplicação para política de acesso"
  type        = string
}
