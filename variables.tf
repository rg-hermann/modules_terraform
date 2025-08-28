variable "aks_name" {
  description = "Nome do cluster AKS"
  type        = string
}

variable "dns_prefix" {
  description = "Prefixo DNS para o AKS"
  type        = string
}

variable "node_count" {
  description = "Quantidade de nós do cluster"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "Tamanho da VM dos nós"
  type        = string
  default     = "Standard_DS2_v2"
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28.3"
}
variable "keyvault_name" {
  description = "Nome do Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "ID do tenant Azure"
  type        = string
}

variable "object_id" {
  description = "Object ID do usuário ou aplicação para política de acesso"
  type        = string
}

variable "sku_name" {
  description = "SKU do Key Vault (Standard ou Premium)"
  type        = string
  default     = "standard"
}
variable "subscription_id" {
  description = "ID da subscription Azure"
  type        = string
}

variable "storage_account_name" {
  description = "Nome do Storage Account para o backend"
  type        = string
}

variable "storage_container_name" {
  description = "Nome do container para o backend"
  type        = string
}

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
  description = "Nome do Resource Group para os recursos principais"
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
