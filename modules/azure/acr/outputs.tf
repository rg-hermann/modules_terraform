output "acr_id" {
  description = "ID do ACR"
  value       = azurerm_container_registry.this.id
}

output "acr_login_server" {
  description = "Login server (FQDN) do ACR"
  value       = azurerm_container_registry.this.login_server
}
