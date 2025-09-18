variable "tags" {
  description = "Tags para o Key Vault"
  type        = map(string)
  default     = {}
}

variable "keyvault_name" {
  description = "Nome do Key Vault"
  type        = string
  validation {
    condition     = length(var.keyvault_name) >= 3 && length(var.keyvault_name) <= 24 && can(regex("^[a-z0-9-]+$", var.keyvault_name))
    error_message = "keyvault_name deve ter 3-24 chars, minúsculos, números ou hífen."
  }
}

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
  validation {
    condition     = can(regex("^(eastus|westeurope|brazilsouth)", var.location))
    error_message = "location deve ser uma das regiões permitidas (eastus|westeurope|brazilsouth)."
  }
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 3
    error_message = "resource_group_name deve ter pelo menos 3 caracteres."
  }
}

variable "tenant_id" {
  description = "ID do tenant Azure"
  type        = string
}

variable "sku_name" {
  description = "SKU do Key Vault (standard ou premium)"
  type        = string
  default     = "standard"
  validation {
    condition     = can(regex("^(?i)(standard|premium)$", var.sku_name))
    error_message = "sku_name deve ser 'standard' ou 'premium'."
  }
}

variable "object_id" {
  description = "Object ID do usuário ou aplicação para política de acesso"
  type        = string
  validation {
    condition     = length(var.object_id) > 0
    error_message = "object_id não pode ser vazio."
  }
}
