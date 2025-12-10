locals {
  kv_tags = merge({ module = "keyvault" }, var.tags)
}

resource "azurerm_key_vault" "this" {
  name                          = var.keyvault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = lower(var.sku_name)
  purge_protection_enabled      = true
  soft_delete_retention_days    = 7
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.kv_tags

  dynamic "network_acls" {
    for_each = var.public_network_access_enabled ? [] : [1]
    content {
      bypass                     = var.network_acls_bypass
      default_action             = "Deny"
      ip_rules                   = var.network_acls_allowed_ips
      virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
    }
  }

  access_policy {
    tenant_id               = var.tenant_id
    object_id               = var.object_id
    secret_permissions      = ["Get", "List", "Set", "Delete"]
    key_permissions         = ["Get", "List", "Create", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Delete"]
  }
}
