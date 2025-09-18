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
variable "api_server_authorized_ip_ranges" {
  description = "Lista de IPs/CIDRs autorizados a acessar o API Server do AKS (vazio = sem restrição)."
  type        = list(string)
  default     = []
}

variable "enable_private_cluster" {
  description = "Se true habilita AKS private cluster."
  type        = bool
  default     = false
}

variable "network_plugin" {
  description = "Plugin de rede do AKS (azure|kubenet)."
  type        = string
  default     = "azure"
}

variable "network_policy" {
  description = "Network policy (azure|calico)."
  type        = string
  default     = "azure"
}

variable "aks_log_analytics_workspace_id" {
  description = "ID de um Log Analytics Workspace existente para o AKS (se null e módulo log_analytics criado, pode referenciar manualmente depois)."
  type        = string
  default     = null
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
variable "public_network_access_enabled" {
  description = "Key Vault público (true) ou exigir network_acls (false)."
  type        = bool
  default     = false
}

variable "network_acls_allowed_ips" {
  description = "IPs/CIDRs permitidos no Key Vault."
  type        = list(string)
  default     = []
}

variable "network_acls_virtual_network_subnet_ids" {
  description = "Subnets autorizadas ao Key Vault."
  type        = list(string)
  default     = []
}

variable "network_acls_bypass" {
  description = "Bypass de serviços para o Key Vault (AzureServices|None)."
  type        = string
  default     = "AzureServices"
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

# =============================
# Azure Function (Opcional)
# =============================
variable "function_app_name" {
  description = "Nome da Azure Function App (se null não cria). Deve ser único globalmente."
  type        = string
  default     = null
  validation {
    condition = var.function_app_name == null || can(regex("^[a-z0-9][a-z0-9-]{1,58}[a-z0-9]$", var.function_app_name))
    error_message = "function_app_name deve ter 2-60 chars, letras/números/hífens, não iniciar/terminar com hífen."
  }
}

variable "function_app_service_plan_sku" {
  description = "SKU do App Service Plan para a Function (Y1 consumo, EPx premium, Bx/Sx dedicado)."
  type        = string
  default     = "Y1"
  validation {
    condition     = can(regex("^(?i)(Y1|EP1|EP2|EP3|B1|B2|B3|S1|S2|S3)$", var.function_app_service_plan_sku))
    error_message = "Valor inválido para function_app_service_plan_sku."
  }
}

variable "function_runtime_stack" {
  description = "Runtime principal da Function (python|node|dotnet|java|powershell)."
  type        = string
  default     = "python"
  validation {
    condition     = can(regex("^(?i)(python|node|dotnet|java|powershell)$", var.function_runtime_stack))
    error_message = "function_runtime_stack inválido."
  }
}

variable "function_runtime_version" {
  description = "Versão do runtime (ex: 3.11 para Python, 18 para Node, v8.0 para dotnet)."
  type        = string
  default     = "3.11"
}

variable "function_enable_application_insights" {
  description = "Se true cria Application Insights para a Function."
  type        = bool
  default     = true
}

variable "function_always_on" {
  description = "Habilitar Always On (ignorado se SKU consumo Y1)."
  type        = bool
  default     = false
}

variable "function_app_settings" {
  description = "Mapa adicional de APP SETTINGS para a Function."
  type        = map(string)
  default     = {}
}

variable "function_identity_type" {
  description = "Tipo de identidade gerenciada (SystemAssigned|UserAssigned|SystemAssigned,UserAssigned)."
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = can(regex("^(SystemAssigned|UserAssigned|SystemAssigned,UserAssigned)$", var.function_identity_type))
    error_message = "function_identity_type inválido."
  }
}

variable "function_user_assigned_identity_ids" {
  description = "Lista de IDs de identidades atribuídas pelo usuário para a Function (se aplicável)."
  type        = list(string)
  default     = []
}

variable "function_storage_account_name" {
  description = "Nome de Storage Account existente para a Function (se null módulo cria um novo)."
  type        = string
  default     = null
  validation {
    condition = var.function_storage_account_name == null || can(regex("^[a-z0-9]{3,24}$", var.function_storage_account_name))
    error_message = "function_storage_account_name deve atender regras de Storage (3-24 chars minúsculos/números)."
  }
}

variable "function_storage_account_access_key" {
  description = "Access key do Storage Account reutilizado pela Function (obrigatório se function_storage_account_name != null)."
  type        = string
  default     = null
}

variable "function_storage_account_connection_string" {
  description = "Connection string do Storage Account reutilizado pela Function (obrigatório se function_storage_account_name != null)."
  type        = string
  default     = null
}
