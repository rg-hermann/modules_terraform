terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0"
    }
  }
}

# AWS Provider (uncomment if using AWS modules)
# provider "aws" {
#   region = var.aws_region
# }

# Azure Provider (uncomment if using Azure modules)
# provider "azurerm" {
#   features {}
#   subscription_id = var.subscription_id
# }

locals {
  base_tags = merge({
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project_name
  }, var.tags)
}

# ============================================================================
# AWS EXAMPLES (uncomment modules after merging PR #X)
# ============================================================================

# module "aws_vpc" {
#   count              = var.enable_aws_vpc ? 1 : 0
#   source             = "./modules/aws/vpc"
#   cidr_block         = var.aws_vpc_cidr
#   public_subnets    = var.aws_public_subnets
#   availability_zones = var.aws_azs
#   tags               = local.base_tags
# }

# module "aws_security_group" {
#   count  = var.enable_aws_security_group ? 1 : 0
#   source = "./modules/aws/security_group"
#   name   = "${var.project_name}-sg"
#   vpc_id = var.enable_aws_vpc ? module.aws_vpc[0].vpc_id : null
#   tags   = local.base_tags
# }

# module "aws_load_balancer" {
#   count              = var.enable_aws_alb ? 1 : 0
#   source             = "./modules/aws/elb"
#   name               = "${var.project_name}-alb"
#   subnets            = var.enable_aws_vpc ? module.aws_vpc[0].public_subnet_ids : []
#   vpc_id             = var.enable_aws_vpc ? module.aws_vpc[0].vpc_id : null
#   security_groups    = var.enable_aws_security_group ? [module.aws_security_group[0].security_group_id] : []
#   target_group_name  = "${var.project_name}-tg"
#   tags               = local.base_tags
# }

# module "aws_s3" {
#   count      = var.enable_aws_s3 ? 1 : 0
#   source     = "./modules/aws/s3"
#   bucket     = "${var.project_name}-bucket"
#   versioning = true
#   tags       = local.base_tags
# }

# module "aws_rds" {
#   count          = var.enable_aws_rds ? 1 : 0
#   source         = "./modules/aws/rds"
#   identifier     = "${var.project_name}-db"
#   engine         = var.aws_db_engine
#   instance_class = var.aws_db_instance_class
#   username       = var.aws_db_username
#   password       = var.aws_db_password
#   tags           = local.base_tags
# }

# ============================================================================
# AZURE EXAMPLES (uncomment modules after merging PR #X)
# ============================================================================

# resource "azurerm_resource_group" "main" {
#   count    = var.enable_azure ? 1 : 0
#   name     = "rg-${var.project_name}"
#   location = var.azure_location
#   tags     = local.base_tags
# }

# module "azure_vnet" {
#   count               = var.enable_azure_vnet ? 1 : 0
#   source              = "./modules/azure/vnet"
#   name                = "vnet-${var.project_name}"
#   resource_group_name = azurerm_resource_group.main[0].name
#   location            = azurerm_resource_group.main[0].location
#   address_space       = var.azure_vnet_address_space
#   subnets = [
#     {
#       name             = "subnet-default"
#       address_prefixes = var.azure_subnet_address_prefix
#     }
#   ]
#   tags = local.base_tags
# }

# module "azure_storage" {
#   count               = var.enable_azure_storage ? 1 : 0
#   source              = "./modules/azure/storage_account"
#   name                = "sa${replace(var.project_name, "-", "")}"
#   resource_group_name = azurerm_resource_group.main[0].name
#   location            = azurerm_resource_group.main[0].location
#   tags                = local.base_tags
# }

# module "azure_identity" {
#   count               = var.enable_azure_identity ? 1 : 0
#   source              = "./modules/azure/managed_identity"
#   name                = "id-${var.project_name}"
#   resource_group_name = azurerm_resource_group.main[0].name
#   location            = azurerm_resource_group.main[0].location
#   tags                = local.base_tags
# }

# module "azure_postgres" {
#   count               = var.enable_azure_postgres ? 1 : 0
#   source              = "./modules/azure/postgresql"
#   server_name         = "pgserver-${var.project_name}"
#   location            = azurerm_resource_group.main[0].location
#   resource_group_name = azurerm_resource_group.main[0].name
#   admin_login         = var.azure_pg_admin_login
#   admin_password      = var.azure_pg_admin_password
#   sku_name            = var.azure_pg_sku
#   tags                = local.base_tags
# }

# module "azure_app_service" {
#   count                   = var.enable_azure_app_service ? 1 : 0
#   source                  = "./modules/azure/app_service"
#   app_service_name        = "app-${var.project_name}"
#   app_service_plan_name   = "plan-${var.project_name}"
#   location                = azurerm_resource_group.main[0].location
#   resource_group_name     = azurerm_resource_group.main[0].name
#   sku_tier                = var.azure_app_service_tier
#   linux_fx_version        = var.azure_app_service_runtime
#   tags                    = local.base_tags
# }

