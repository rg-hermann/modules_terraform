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
    module      = "vnet"
  }
}
// variables.tf - Variáveis do módulo VNet
variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string
  validation {
    condition     = length(var.vnet_name) > 2
    error_message = "O nome da VNet deve ter pelo menos 3 caracteres."
  }
}

variable "vnet_address_space" {
  description = "Espaço de endereçamento da VNet"
  type        = list(string)
}

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
  validation {
    condition     = can(regex("^(eastus|westeurope|brazilsouth)", var.location))
    error_message = "A localização deve ser uma região Azure válida."
  }
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
  validation {
    condition     = length(var.resource_group_name) > 2
    error_message = "O nome do Resource Group deve ter pelo menos 3 caracteres."
  }
}

variable "public_subnet_name" {
  description = "Nome da Subnet Pública"
  type        = string
}

variable "public_subnet_prefix" {
  description = "Prefixo da Subnet Pública"
  type        = list(string)
}

variable "private_subnet_name" {
  description = "Nome da Subnet Privada"
  type        = string
}

variable "private_subnet_prefix" {
  description = "Prefixo da Subnet Privada"
  type        = list(string)
}
