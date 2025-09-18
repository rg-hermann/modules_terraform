terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.41.0"
    }
  }
  # backend "azurerm" {
  #   resource_group_name   = "rg-tfstate"
  #   storage_account_name  = "tfstateaccountdemo"
  #   container_name        = "tfstate"
  prefix = var.prefix
  tags   = var.tags
  #   key                   = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "tfstate" {
  prefix   = var.prefix
  tags     = var.tags
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "tfstate" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "tfstate" {
  name                  = var.storage_container_name
  prefix                = var.prefix
  tags                  = var.tags
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
}

module "keyvault" {
  source              = "./modules/keyvault"
  keyvault_name       = var.keyvault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  sku_name            = var.sku_name
}

module "aks" {
  source                       = "./modules/aks"
  aks_name                     = var.aks_name
  location                     = var.location
  resource_group_name          = var.resource_group_name
  dns_prefix                   = var.dns_prefix
  node_count                   = var.node_count
  vm_size                      = var.vm_size
  subnet_id                    = module.vnet.public_subnet_id
  public_subnet_route_table_id = module.vnet.public_subnet_route_table_id
  keyvault_id                  = module.keyvault.keyvault_id
  kubernetes_version           = var.kubernetes_version
}

