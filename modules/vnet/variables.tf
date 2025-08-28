// variables.tf - Variáveis do módulo VNet
variable "vnet_name" {
  description = "Nome da Virtual Network"
  type        = string
}

variable "vnet_address_space" {
  description = "Espaço de endereçamento da VNet"
  type        = list(string)
}

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
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
