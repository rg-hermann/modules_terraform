variable "tags" {
  description = "Tags para o cluster AKS"
  type        = map(string)
  default     = {}
}

variable "aks_name" {
  description = "Nome do cluster AKS"
  type        = string
  validation {
    condition     = length(var.aks_name) >= 3 && can(regex("^[a-zA-Z0-9-]+$", var.aks_name))
    error_message = "aks_name deve ter ao menos 3 caracteres (letras, números ou hífen)."
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

variable "dns_prefix" {
  description = "Prefixo DNS para o AKS"
  type        = string
  validation {
    condition     = length(var.dns_prefix) > 2
    error_message = "O prefixo DNS deve ter pelo menos 3 caracteres."
  }
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
  validation {
    condition     = length(var.subnet_id) > 0
    error_message = "O ID da subnet não pode ser vazio."
  }
}

variable "keyvault_id" {
  description = "ID do Key Vault para secrets"
  type        = string
  validation {
    condition     = length(var.keyvault_id) > 0
    error_message = "O ID do Key Vault não pode ser vazio."
  }
}

variable "kubernetes_version" {
  description = "Versão do Kubernetes"
  type        = string
  default     = "1.28.3"
}

variable "public_subnet_route_table_id" {
  description = "ID da route table da subnet pública para atribuição de permissão à managed identity do AKS"
  type        = string
  validation {
    condition     = length(var.public_subnet_route_table_id) > 0
    error_message = "O ID da route table não pode ser vazio."
  }
}
