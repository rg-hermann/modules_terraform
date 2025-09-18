locals {
  la_tags = merge({ module = "log-analytics" }, var.tags)
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = var.workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
  retention_in_days   = var.retention_days
  tags                = local.la_tags
}

# (Opcional) Diagnostic Settings removidos para evitar incompatibilidades de versão do provider.
# Podem ser adicionados em uma futura versão com checagem condicional refinada.
