resource "azurerm_app_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = var.kind
  reserved            = var.reserved

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }

  tags = var.tags
}

resource "azurerm_app_service" "this" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.this.id
  tags                = var.tags

  site_config {
    dotnet_framework_version = var.dotnet_framework_version
    linux_fx_version         = var.linux_fx_version
  }
}
