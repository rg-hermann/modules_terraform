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
