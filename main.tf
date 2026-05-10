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

# AWS Provider (configurado para LocalStack)
provider "aws" {
  region = "us-east-1"
  endpoints {
    s3   = "http://localhost:4566"
    elb  = "http://localhost:4566"
    ec2  = "http://localhost:4566"
    rds  = "http://localhost:4566"
    iam  = "http://localhost:4566"
    logs = "http://localhost:4566"
  }
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}

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
# MÓDULOS AWS (ATIVADOS/DESATIVADOS VIA ENV TFVARS)
# ============================================================================

module "aws_vpc" {
  count              = var.enable_aws_vpc ? 1 : 0
  source             = "./modules/aws/vpc"
  vpc_name           = "${var.project_name}-vpc"
  cidr_block         = var.aws_vpc_cidr
  public_subnets     = var.aws_public_subnets
  private_subnets    = var.aws_private_subnets
  availability_zones = var.aws_azs
  enable_nat_gateway = var.aws_enable_nat_gateway
  tags               = local.base_tags
}

module "aws_security_group" {
  count       = var.enable_aws_security_group ? 1 : 0
  source      = "./modules/aws/security_group"
  name        = "${var.project_name}-sg"
  description = "Security group for ${var.project_name}"
  vpc_id      = var.enable_aws_vpc ? module.aws_vpc[0].vpc_id : null
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.aws_sg_ingress_cidr]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = [var.aws_sg_ingress_cidr]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = local.base_tags
}

module "aws_ec2" {
  count               = var.enable_aws_ec2 ? 1 : 0
  source              = "./modules/aws/ec2"
  instance_name       = "${var.project_name}-ec2"
  ami_id              = var.aws_ec2_ami_id
  instance_type       = var.aws_ec2_instance_type
  subnet_id           = var.enable_aws_vpc ? module.aws_vpc[0].public_subnet_ids[0] : null
  security_groups     = var.enable_aws_security_group ? [module.aws_security_group[0].security_group_id] : []
  key_name            = var.aws_ec2_key_name
  associate_public_ip = true
  tags                = local.base_tags
}

module "aws_rds" {
  count               = var.enable_aws_rds ? 1 : 0
  source              = "./modules/aws/rds"
  identifier          = "${var.project_name}-db"
  engine              = var.aws_db_engine
  engine_version      = var.aws_db_engine_version
  instance_class      = var.aws_db_instance_class
  allocated_storage   = var.aws_db_allocated_storage
  username            = var.aws_db_username
  password            = var.aws_db_password
  db_name             = var.aws_db_name
  subnet_ids          = var.enable_aws_vpc ? module.aws_vpc[0].private_subnet_ids : []
  security_groups     = var.enable_aws_security_group ? [module.aws_security_group[0].security_group_id] : []
  publicly_accessible = false
  tags                = local.base_tags
}

module "aws_load_balancer" {
  count             = var.enable_aws_alb ? 1 : 0
  source            = "./modules/aws/elb"
  name              = "${var.project_name}-alb"
  internal          = var.aws_alb_internal
  subnets           = var.enable_aws_vpc ? module.aws_vpc[0].public_subnet_ids : []
  vpc_id            = var.enable_aws_vpc ? module.aws_vpc[0].vpc_id : null
  security_groups   = var.enable_aws_security_group ? [module.aws_security_group[0].security_group_id] : []
  target_group_name = "${var.project_name}-tg"
  target_port       = 80
  listener_port     = 80
  tags              = local.base_tags
}

module "aws_s3" {
  count         = var.enable_aws_s3 ? 1 : 0
  source        = "./modules/aws/s3"
  bucket_name   = "${var.project_name}-${var.aws_s3_bucket_prefix}"
  versioning    = var.aws_s3_versioning
  encryption    = var.aws_s3_encryption
  public_access = var.aws_s3_public_access
  tags          = local.base_tags
}

module "aws_iam_role" {
  count     = var.enable_aws_iam ? 1 : 0
  source    = "./modules/aws/iam"
  role_name = "${var.project_name}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
  tags = local.base_tags
}

module "aws_cloudwatch" {
  count             = var.enable_aws_cloudwatch ? 1 : 0
  source            = "./modules/aws/cloudwatch"
  log_group_name    = "/aws/${var.project_name}/logs"
  retention_in_days = var.aws_cw_retention_days
  tags              = local.base_tags
}

# ============================================================================
# OUTPUTS DOS MÓDULOS
# ============================================================================

output "vpc_id" {
  value = var.enable_aws_vpc ? module.aws_vpc[0].vpc_id : null
}

output "security_group_id" {
  value = var.enable_aws_security_group ? module.aws_security_group[0].security_group_id : null
}

output "ec2_instance_id" {
  value = var.enable_aws_ec2 ? module.aws_ec2[0].instance_id : null
}

output "ec2_public_ip" {
  value = var.enable_aws_ec2 ? module.aws_ec2[0].instance_public_ip : null
}

output "rds_endpoint" {
  value = var.enable_aws_rds ? module.aws_rds[0].endpoint : null
}

output "alb_dns_name" {
  value = var.enable_aws_alb ? module.aws_load_balancer[0].dns_name : null
}

output "s3_bucket_name" {
  value = var.enable_aws_s3 ? module.aws_s3[0].bucket_name : null
}

output "iam_role_arn" {
  value = var.enable_aws_iam ? module.aws_iam_role[0].role_arn : null
}

output "cloudwatch_log_group" {
  value = var.enable_aws_cloudwatch ? module.aws_cloudwatch[0].log_group_name : null
}


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

