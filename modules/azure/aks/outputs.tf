output "aks_principal_id" {
  description = "Principal ID da Managed Identity do AKS"
  value       = azurerm_kubernetes_cluster.this.identity[0].principal_id
}

output "aks_tenant_id" {
  description = "Tenant ID da Managed Identity do AKS"
  value       = azurerm_kubernetes_cluster.this.identity[0].tenant_id
}

output "aks_identity_ids" {
  description = "Lista de User Assigned Managed Identity IDs do AKS"
  value       = azurerm_kubernetes_cluster.this.identity[0].identity_ids
}
output "aks_id" {
  description = "ID do cluster AKS"
  value       = azurerm_kubernetes_cluster.this.id
}

output "kube_config" {
  description = "Configuração do kubeconfig para acesso ao cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config_raw
  sensitive   = true
}

output "api_server_endpoint" {
  description = "Endpoint da API do cluster"
  value       = azurerm_kubernetes_cluster.this.kube_config[0].host
}
