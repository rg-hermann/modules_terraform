variable "function_app_name" {
  description = "Nome da Function App (único globalmente)."
  type        = string
}

variable "location" {
  description = "Região Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group onde a Function será criada"
  type        = string
}

variable "storage_account_name" {
  description = "Nome do Storage Account (caso queira reutilizar). Se null, será criado um novo."
  type        = string
  default     = null
}

variable "app_service_plan_sku" {
  description = "SKU do App Service Plan (Y1 para Consumption, EP1 para Premium, B1/S1 para dedicado)."
  type        = string
  default     = "Y1"
  validation {
    condition     = can(regex("^(?i)(Y1|EP1|EP2|EP3|B1|B2|B3|S1|S2|S3)$", var.app_service_plan_sku))
    error_message = "Valor inválido para app_service_plan_sku."
  }
}

variable "runtime_stack" {
  description = "Runtime principal (python|node|dotnet|java|powershell)."
  type        = string
  default     = "python"
  validation {
    condition     = can(regex("^(?i)(python|node|dotnet|java|powershell)$", var.runtime_stack))
    error_message = "runtime_stack deve ser python, node, dotnet, java ou powershell."
  }
}

variable "runtime_version" {
  description = "Versão do runtime (ex: 3.11 para Python, 18 para Node, v8.0 para dotnet)."
  type        = string
  default     = "3.11"
}

variable "enable_application_insights" {
  description = "Se true cria Application Insights vinculado."
  type        = bool
  default     = true
}

variable "always_on" {
  description = "Habilitar Always On (ignorando se consumo Y1)."
  type        = bool
  default     = false
}

variable "app_settings" {
  description = "Mapa adicional de APP SETTINGS a serem mesclados."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags para a Function App e recursos relacionados"
  type        = map(string)
  default     = {}
}

variable "identity_type" {
  description = "Tipo de identidade gerenciada (SystemAssigned|UserAssigned|SystemAssigned,UserAssigned)."
  type        = string
  default     = "SystemAssigned"
  validation {
    condition     = can(regex("^(SystemAssigned|UserAssigned|SystemAssigned,UserAssigned)$", var.identity_type))
    error_message = "identity_type inválido."
  }
}

variable "user_assigned_identity_ids" {
  description = "Lista de IDs de identidades atribuídas pelo usuário (se identity_type incluir UserAssigned)."
  type        = list(string)
  default     = []
}

variable "storage_account_access_key" {
  description = "Access key do Storage Account reutilizado (obrigatório se storage_account_name não for null)."
  type        = string
  default     = null
}

variable "storage_account_connection_string" {
  description = "Connection string do Storage Account reutilizado (obrigatório se storage_account_name não for null)."
  type        = string
  default     = null
  validation {
    condition = var.storage_account_name == null || (
      var.storage_account_name != null &&
      var.storage_account_access_key != null &&
      var.storage_account_connection_string != null
    )
    error_message = "Quando reutilizando um storage (storage_account_name != null) é obrigatório informar storage_account_access_key e storage_account_connection_string."
  }
}
# Updated 1765335467
