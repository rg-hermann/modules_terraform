variable "acr_name" {
  description = "Nome do Azure Container Registry (já validado no root)."
  type        = string
}

variable "location" {
  description = "Localização onde criar o ACR"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group do ACR"
  type        = string
}

variable "acr_sku" {
  description = "SKU do ACR (Basic, Standard, Premium)."
  type        = string
  default     = "Basic"
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}

variable "assign_aks_pull" {
  description = "Se true e principal_id informado, atribui AcrPull."
  type        = bool
  default     = true
}

variable "aks_principal_id" {
  description = "Principal ID da Managed Identity do AKS para conceder AcrPull (opcional)."
  type        = string
  default     = ""
}
