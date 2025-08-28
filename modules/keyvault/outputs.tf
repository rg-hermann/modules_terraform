output "keyvault_id" {
  description = "ID do Key Vault criado"
  value       = azurerm_key_vault.this.id
}

output "keyvault_uri" {
  description = "URI do Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}
