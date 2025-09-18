terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.41.0"
    }
  }
  # Para ativar backend remoto posteriormente, descomente e ajuste:
  # backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Tags base combinando tags padrão e específicas do workspace
locals {
  base_tags = merge({
    environment = lookup(var.tags, "environment", "dev")
    managed_by  = "terraform"
  }, var.tags)

  # Normalização do prefixo para garantir conformidade (minúsculo / sem espaços)
  normalized_prefix = lower(replace(var.prefix, " ", "-"))

  # Exemplos de nomes derivados caso queira padronizar futuramente
  inferred_resource_group_name  = var.resource_group_name != "" ? var.resource_group_name : "rg-${local.normalized_prefix}"
  inferred_storage_account_name = var.storage_account_name != "" ? var.storage_account_name : "${replace(local.normalized_prefix, "-", "")}sa"
}

resource "azurerm_resource_group" "tfstate" {
  name     = local.inferred_resource_group_name
  location = var.location
  tags     = local.base_tags
}

resource "azurerm_storage_account" "tfstate" {
  name                            = local.inferred_storage_account_name
  resource_group_name             = azurerm_resource_group.tfstate.name
  location                        = azurerm_resource_group.tfstate.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  min_tls_version                 = "TLS1_2"
  tags                            = local.base_tags
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = true
  lifecycle {
    prevent_destroy = false
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

module "vnet" {
  source                = "./modules/vnet"
  vnet_name             = var.vnet_name
  vnet_address_space    = var.vnet_address_space
  location              = var.location
  resource_group_name   = var.resource_group_name
  public_subnet_name    = var.public_subnet_name
  public_subnet_prefix  = var.public_subnet_prefix
  private_subnet_name   = var.private_subnet_name
  private_subnet_prefix = var.private_subnet_prefix
  tags                  = local.base_tags
}

module "keyvault" {
  source                                  = "./modules/keyvault"
  keyvault_name                           = var.keyvault_name
  location                                = var.location
  resource_group_name                     = var.resource_group_name
  tenant_id                               = var.tenant_id
  object_id                               = var.object_id
  sku_name                                = var.sku_name
  public_network_access_enabled           = var.public_network_access_enabled
  network_acls_allowed_ips                = var.network_acls_allowed_ips
  network_acls_virtual_network_subnet_ids = var.network_acls_virtual_network_subnet_ids
  network_acls_bypass                     = var.network_acls_bypass
  tags                                    = local.base_tags
}

module "aks" {
  source                          = "./modules/aks"
  aks_name                        = var.aks_name
  location                        = var.location
  resource_group_name             = var.resource_group_name
  dns_prefix                      = var.dns_prefix
  node_count                      = var.node_count
  vm_size                         = var.vm_size
  subnet_id                       = module.vnet.public_subnet_id
  public_subnet_route_table_id    = module.vnet.public_subnet_route_table_id
  keyvault_id                     = module.keyvault.keyvault_id
  kubernetes_version              = var.kubernetes_version
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges
  enable_private_cluster          = var.enable_private_cluster
  network_plugin                  = var.network_plugin
  network_policy                  = var.network_policy
  log_analytics_workspace_id      = var.aks_log_analytics_workspace_id
  tags                            = local.base_tags
}

# Criação opcional do ACR
module "acr" {
  count               = var.acr_name == null ? 0 : 1
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  acr_sku             = var.acr_sku
  tags                = local.base_tags
  assign_aks_pull     = var.acr_assign_aks_pull
  aks_principal_id    = module.aks.aks_principal_id
}

# Log Analytics opcional
module "log_analytics" {
  count               = var.log_analytics_workspace_name == null ? 0 : 1
  source              = "./modules/log_analytics"
  workspace_name      = var.log_analytics_workspace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.log_analytics_sku
  retention_days      = var.log_analytics_retention_days
  tags                = local.base_tags
  enable_diagnostics  = var.enable_diagnostics
}

# Azure Function opcional
module "azure_function" {
  count                             = var.function_app_name == null ? 0 : 1
  source                            = "./modules/azure_function"
  function_app_name                 = var.function_app_name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  storage_account_name              = var.function_storage_account_name
  app_service_plan_sku              = var.function_app_service_plan_sku
  runtime_stack                     = var.function_runtime_stack
  runtime_version                   = var.function_runtime_version
  enable_application_insights       = var.function_enable_application_insights
  always_on                         = var.function_always_on
  app_settings                      = var.function_app_settings
  identity_type                     = var.function_identity_type
  user_assigned_identity_ids        = var.function_user_assigned_identity_ids
  storage_account_access_key        = var.function_storage_account_access_key
  storage_account_connection_string = var.function_storage_account_connection_string
  tags                              = local.base_tags
}

