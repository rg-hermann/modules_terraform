resource "azurerm_key_vault" "this" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  tenant_id                   = var.tenant_id
  sku_name                    = var.sku_name
  purge_protection_enabled    = true
  tags                       = var.tags

  access_policy {
    tenant_id = var.tenant_id
    object_id = var.object_id
    secret_permissions = ["Get", "List", "Set", "Delete"]
    key_permissions    = ["Get", "List", "Create", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Delete"]
  }
}
