output "server_id" {
  value = azurerm_postgresql_flexible_server.this.id
}

output "fqdn" {
  value = azurerm_postgresql_flexible_server.this.fqdn
}

output "database_ids" {
  value = azurerm_postgresql_flexible_server_database.this[*].id
}
