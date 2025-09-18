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

variable "prefix" {
  description = "Prefixo opcional para nomear recursos (usado em convenções futuras)."
  type        = string
  default     = "demo"
  validation {
    condition     = length(var.prefix) <= 12 && can(regex("^[a-z0-9-]+$", var.prefix))
    error_message = "prefix deve ter até 12 caracteres, minúsculos, números ou hífen."
  }
}

variable "tags" {
  description = "Mapa de tags adicionais para todos os recursos. 'managed_by' será sobrescrito para 'terraform'."
  type        = map(string)
  default = {
    environment = "dev"
    project     = "demo"
  }
}

# =============================
# ACR (Azure Container Registry)
# =============================
variable "acr_name" {
  description = "Nome do Azure Container Registry (5-50 chars, minúsculo e único global). Se null, ACR não será criado."
  type        = string
  default     = null
  validation {
    condition = var.acr_name == null || (
      length(var.acr_name) >= 5 && length(var.acr_name) <= 50 && can(regex("^[a-z0-9]+$", var.acr_name))
    )
    error_message = "acr_name deve ter 5-50 caracteres apenas com letras minúsculas e números."
  }
}

variable "acr_sku" {
  description = "SKU do ACR (Basic, Standard, Premium)."
  type        = string
  default     = "Basic"
  validation {
    condition     = can(regex("^(?i)(Basic|Standard|Premium)$", var.acr_sku))
    error_message = "acr_sku deve ser Basic, Standard ou Premium."
  }
}

variable "acr_assign_aks_pull" {
  description = "Se true e AKS existir, atribui role 'AcrPull' para a Managed Identity do AKS."
  type        = bool
  default     = true
}

# =============================
# Log Analytics Workspace
# =============================
variable "log_analytics_workspace_name" {
  description = "Nome do Log Analytics Workspace (se null não cria)."
  type        = string
  default     = null
  validation {
    condition = var.log_analytics_workspace_name == null || (
      length(var.log_analytics_workspace_name) >= 4 && length(var.log_analytics_workspace_name) <= 63
    )
    error_message = "log_analytics_workspace_name deve ter 4-63 caracteres."
  }
}

variable "log_analytics_sku" {
  description = "SKU do workspace (PerGB2018 / Free / Standalone / CapacityReservation)."
  type        = string
  default     = "PerGB2018"
  validation {
    condition     = can(regex("^(?i)(PerGB2018|Free|Standalone|CapacityReservation)$", var.log_analytics_sku))
    error_message = "log_analytics_sku inválido."
  }
}

variable "log_analytics_retention_days" {
  description = "Retenção de dados em dias (30-730)."
  type        = number
  default     = 30
  validation {
    condition     = var.log_analytics_retention_days >= 30 && var.log_analytics_retention_days <= 730
    error_message = "retention deve estar entre 30 e 730 dias."
  }
}

variable "enable_diagnostics" {
  description = "Se true, cria Diagnostic Settings para recursos suportados (AKS, Key Vault, Storage, ACR)."
  type        = bool
  default     = true
}
