output "vnet_id" {
  description = "ID da Virtual Network criada pelo módulo vnet"
  value       = module.vnet.vnet_id
}

output "public_subnet_id" {
  description = "ID da Subnet Pública criada pelo módulo vnet"
  value       = module.vnet.public_subnet_id
}

output "private_subnet_id" {
  description = "ID da Subnet Privada criada pelo módulo vnet"
  value       = module.vnet.private_subnet_id
}

output "keyvault_id" {
  description = "ID do Key Vault criado pelo módulo keyvault"
  value       = module.keyvault.keyvault_id
}

output "keyvault_uri" {
  description = "URI do Key Vault criado pelo módulo keyvault"
  value       = module.keyvault.keyvault_uri
}

output "aks_id" {
  description = "ID do cluster AKS criado pelo módulo aks"
  value       = module.aks.aks_id
}

output "aks_kube_config" {
  description = "Kubeconfig do cluster AKS criado pelo módulo aks"
  value       = module.aks.kube_config
  sensitive   = true
}
output "aks_api_server_endpoint" {
  description = "Endpoint da API do cluster AKS"
  value       = module.aks.api_server_endpoint
}

output "acr_id" {
  description = "ID do Azure Container Registry (se criado)"
  value       = try(module.acr[0].acr_id, null)
}

output "acr_login_server" {
  description = "Login server do ACR (se criado)"
  value       = try(module.acr[0].acr_login_server, null)
}

output "log_analytics_workspace_id" {
  description = "ID do Log Analytics Workspace (se criado)"
  value       = try(module.log_analytics[0].log_analytics_workspace_id, null)
}

output "log_analytics_customer_id" {
  description = "Customer ID do Log Analytics (se criado)"
  value       = try(module.log_analytics[0].log_analytics_customer_id, null)
}
output "resource_group_name" {
  description = "Nome do Resource Group criado para o backend"
  value       = azurerm_resource_group.tfstate.name
}

output "storage_account_name" {
  description = "Nome do Storage Account criado para o backend"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_container_name" {
  description = "Nome do container criado para o backend"
  value       = azurerm_storage_container.tfstate.name
}

output "storage_account_id" {
  description = "ID do Storage Account criado para o backend"
  value       = azurerm_storage_account.tfstate.id
}

output "storage_container_id" {
  description = "ID do container criado para o backend"
  value       = azurerm_storage_container.tfstate.id
}

# =============================
# Azure Function (opcional)
# =============================
output "function_app_id" {
  description = "ID da Function App (se criada)"
  value       = try(module.azure_function[0].function_app_id, null)
}

output "function_app_name" {
  description = "Nome da Function App (se criada)"
  value       = try(module.azure_function[0].function_app_name, null)
}

output "function_app_default_hostname" {
  description = "Hostname padrão da Function (se criada)"
  value       = try(module.azure_function[0].default_hostname, null)
}

output "function_app_principal_id" {
  description = "Principal ID da Function (se criada)"
  value       = try(module.azure_function[0].principal_id, null)
}

output "function_app_insights_connection_string" {
  description = "Connection string do App Insights da Function (se criado)"
  value       = try(module.azure_function[0].app_insights_connection_string, null)
  sensitive   = true
}

output "function_app_insights_instrumentation_key" {
  description = "Instrumentation Key do App Insights da Function (se criado)"
  value       = try(module.azure_function[0].app_insights_instrumentation_key, null)
  sensitive   = true
}
