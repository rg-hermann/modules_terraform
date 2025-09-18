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
    module      = "aks"
  }
}
variable "aks_name" {
  description = "Nome do cluster AKS"
  type        = string
}
 variable "aks_name" {
   description = "Nome do cluster AKS"
   type        = string
   validation {
     condition     = length(var.aks_name) > 2
     error_message = "O nome do AKS deve ter pelo menos 3 caracteres."
   }

variable "location" {
  description = "Localização do recurso Azure"
  type        = string
}
 variable "location" {
   description = "Localização do recurso Azure"
   type        = string
   validation {
     condition     = can(regex("^(eastus|westeurope|brazilsouth)", var.location))
     error_message = "A localização deve ser uma região Azure válida."
   }

variable "resource_group_name" {
  description = "Nome do Resource Group"
  type        = string
}
 variable "resource_group_name" {
   description = "Nome do Resource Group"
   type        = string
   validation {
     condition     = length(var.resource_group_name) > 2
     error_message = "O nome do Resource Group deve ter pelo menos 3 caracteres."
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

variable "subnet_id" {
  description = "ID da subnet da VNet para o AKS"
  type        = string
}

variable "keyvault_id" {
  description = "ID do Key Vault para secrets"
  type        = string
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28.3"
}

variable "public_subnet_route_table_id" {
  description = "ID da route table da subnet pública para atribuição de permissão à managed identity do AKS"
  type        = string
}
