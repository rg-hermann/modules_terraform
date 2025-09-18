locals {
  kv_tags = merge({ module = "keyvault" }, var.tags)
}

resource "azurerm_key_vault" "this" {
  name                          = var.keyvault_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  # Key Vault aceita 'standard' ou 'premium' (case-insensitive). Normalizamos para lower-case.
  sku_name                      = lower(var.sku_name)
  purge_protection_enabled      = true
  soft_delete_retention_days    = 7
  public_network_access_enabled = true
  tags                          = local.kv_tags

  access_policy {
    tenant_id               = var.tenant_id
    object_id               = var.object_id
    secret_permissions      = ["Get", "List", "Set", "Delete"]
    key_permissions         = ["Get", "List", "Create", "Delete"]
    certificate_permissions = ["Get", "List", "Create", "Delete"]
  }
}
