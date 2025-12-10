resource "azurerm_postgresql_flexible_server" "this" {
  name                   = var.server_name
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = var.admin_login
  administrator_password = var.admin_password
  sku_name               = var.sku_name
  storage_mb             = var.storage_mb
  backup_retention_days  = var.backup_retention_days
  tags                   = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "this" {
  count           = length(var.databases)
  name            = var.databases[count.index]
  server_id       = azurerm_postgresql_flexible_server.this.id
  charset         = "UTF8"
  collation       = "en_US.utf8"
}
