locals {
  acr_tags = merge({ module = "acr" }, var.tags)
}

resource "azurerm_container_registry" "this" {
  name                          = var.acr_name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  sku                           = var.acr_sku
  admin_enabled                 = false
  public_network_access_enabled = true
  tags                          = local.acr_tags
  # Observação: blocks como retention_policy/trust_policy/encryption variam por versão.
  # Adicionar posteriormente conforme necessidade/compliance.
}

# Concede permissão AcrPull à identidade do AKS se solicitado
resource "azurerm_role_assignment" "acr_pull" {
  count                = var.assign_aks_pull && length(var.aks_principal_id) > 0 ? 1 : 0
  scope                = azurerm_container_registry.this.id
  role_definition_name = "AcrPull"
  principal_id         = var.aks_principal_id
}
