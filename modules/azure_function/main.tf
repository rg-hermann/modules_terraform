locals {
  base_tags = merge({ module = "azure_function" }, var.tags)
}

# Storage Account opcional (caso não seja fornecido)
resource "azurerm_storage_account" "fa" {
  count                    = var.storage_account_name == null ? 1 : 0
  name                     = substr(replace(lower(var.function_app_name), "-", ""), 0, 20)
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  tags                    = local.base_tags
}

# App Service Plan (Consumption ou Dedicado)
resource "azurerm_service_plan" "fa" {
  name                = "asp-${var.function_app_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.app_service_plan_sku
  tags                = local.base_tags
}

# Application Insights (opcional)
resource "azurerm_application_insights" "fa" {
  count               = var.enable_application_insights ? 1 : 0
  name                = "appi-${var.function_app_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  tags                = local.base_tags
}

# Function App (Linux)
resource "azurerm_linux_function_app" "this" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  service_plan_id            = azurerm_service_plan.fa.id
  storage_account_name       = var.storage_account_name == null ? azurerm_storage_account.fa[0].name : var.storage_account_name
  storage_account_access_key = var.storage_account_name == null ? azurerm_storage_account.fa[0].primary_access_key : null
  https_only                 = true
  functions_extension_version = "~4"
  tags                       = local.base_tags

  identity {
    type         = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" || var.identity_type == "SystemAssigned,UserAssigned" ? var.user_assigned_identity_ids : null
  }

  site_config {
    # Define somente um bloco application_stack dependendo do runtime escolhido
    dynamic "application_stack" {
      for_each = lower(var.runtime_stack) == "python" ? [1] : []
      content {
        python_version = var.runtime_version
      }
    }
    dynamic "application_stack" {
      for_each = lower(var.runtime_stack) == "node" ? [1] : []
      content {
        node_version = var.runtime_version
      }
    }
    dynamic "application_stack" {
      for_each = lower(var.runtime_stack) == "dotnet" ? [1] : []
      content {
        dotnet_version = var.runtime_version
      }
    }
    dynamic "application_stack" {
      for_each = lower(var.runtime_stack) == "java" ? [1] : []
      content {
        java_version = var.runtime_version
      }
    }
    dynamic "application_stack" {
      for_each = lower(var.runtime_stack) == "powershell" ? [1] : []
      content {
        powershell_core_version = var.runtime_version
      }
    }
    always_on = var.app_service_plan_sku == "Y1" ? false : var.always_on
  }

  app_settings = merge({
    FUNCTIONS_WORKER_RUNTIME = lower(var.runtime_stack)
    WEBSITE_RUN_FROM_PACKAGE = 1
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = var.storage_account_name == null ? azurerm_storage_account.fa[0].primary_connection_string : null
    WEBSITE_CONTENTSHARE                = "${lower(var.function_app_name)}-content"
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.enable_application_insights ? azurerm_application_insights.fa[0].connection_string : null
    APPINSIGHTS_INSTRUMENTATIONKEY        = var.enable_application_insights ? azurerm_application_insights.fa[0].instrumentation_key : null
  }, var.app_settings)

  lifecycle {
    ignore_changes = [app_settings]
  }
}
