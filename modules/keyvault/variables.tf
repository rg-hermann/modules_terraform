variable "prefix" {
  description = "Prefixo para nomeação dos recursos."
  type        = string
  default     = "demo"
}

variable "tags" {
  description = "Tags para todos os recursos criados."
  type        = map(string)
  default     = {
    environment = "dev"
    managed_by  = "terraform"
    module      = "keyvault"
  }
}
variable "keyvault_name" {
  description = "Nome do Key Vault"
  type        = string
}

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
}
  validation {
    condition     = length(var.keyvault_name) > 2
    error_message = "O nome do Key Vault deve ter pelo menos 3 caracteres."
  }

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}

  validation {
    condition     = can(regex("^(eastus|westeurope|brazilsouth)", var.location))
    error_message = "A localização deve ser uma região Azure válida."
  }
variable "tenant_id" {
  description = "ID do tenant Azure"
  type        = string
}

variable "sku_name" {
  validation {
    condition     = length(var.resource_group_name) > 2
    error_message = "O nome do Resource Group deve ter pelo menos 3 caracteres."
  }
  description = "SKU do Key Vault (Standard ou Premium)"
  type        = string
  default     = "standard"
}

variable "object_id" {
  description = "Object ID do usuário ou aplicação para política de acesso"
  type        = string
}
