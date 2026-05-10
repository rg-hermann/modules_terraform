# ============================================================================
# GENERAL VARIABLES
# ============================================================================

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

# ============================================================================
# AWS VARIABLES
# ============================================================================

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "enable_aws_vpc" {
  description = "Enable AWS VPC module"
  type        = bool
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR block"
  type        = string
}

variable "aws_public_subnets" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
}

variable "aws_azs" {
  description = "AWS Availability Zones"
  type        = list(string)
}

variable "enable_aws_security_group" {
  description = "Enable AWS Security Group module"
  type        = bool
}

variable "aws_sg_ingress_cidr" {
  description = "CIDR block for security group ingress"
  type        = string
}

variable "enable_aws_alb" {
  description = "Enable AWS Application Load Balancer"
  type        = bool
}

variable "aws_alb_internal" {
  description = "ALB internal or external"
  type        = bool
}

variable "enable_aws_s3" {
  description = "Enable AWS S3 bucket module"
  type        = bool
}

variable "aws_s3_bucket_prefix" {
  description = "S3 bucket name prefix"
  type        = string
}

variable "enable_aws_rds" {
  description = "Enable AWS RDS module"
  type        = bool
}

variable "aws_db_engine" {
  description = "RDS engine (postgres, mysql)"
  type        = string
}

variable "aws_db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "aws_db_username" {
  description = "RDS master username"
  type        = string
  sensitive   = true
}

variable "aws_db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "aws_db_name" {
  description = "RDS database name"
  type        = string
}

variable "aws_db_engine_version" {
  description = "RDS engine version"
  type        = string
}

variable "aws_db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "enable_aws_ec2" {
  description = "Enable AWS EC2 instance module"
  type        = bool
}

variable "aws_ec2_ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "aws_ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "aws_ec2_key_name" {
  description = "SSH key pair name for EC2"
  type        = string
}

variable "enable_aws_iam" {
  description = "Enable AWS IAM role module"
  type        = bool
}

variable "enable_aws_cloudwatch" {
  description = "Enable AWS CloudWatch log group module"
  type        = bool
}

variable "aws_cw_retention_days" {
  description = "CloudWatch log retention in days"
  type        = number
}

variable "aws_private_subnets" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
}

variable "aws_enable_nat_gateway" {
  description = "Enable NAT Gateway in VPC"
  type        = bool
}

variable "aws_s3_versioning" {
  description = "Enable S3 versioning"
  type        = bool
}

variable "aws_s3_encryption" {
  description = "Enable S3 server-side encryption"
  type        = bool
}

variable "aws_s3_public_access" {
  description = "Block public access to S3 bucket"
  type        = bool
}

# ============================================================================
# AZURE VARIABLES
# ============================================================================

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "enable_azure" {
  description = "Enable Azure resources"
  type        = bool
}

variable "azure_location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Azure Resource Group name"
  type        = string
}

variable "enable_azure_vnet" {
  description = "Enable Azure VNet module"
  type        = bool
}

variable "azure_vnet_name" {
  description = "Azure VNet name"
  type        = string
}

variable "azure_vnet_address_space" {
  description = "Azure VNet address space"
  type        = list(string)
}

variable "azure_subnet_address_prefix" {
  description = "Azure subnet address prefix"
  type        = list(string)
}

variable "enable_azure_storage" {
  description = "Enable Azure Storage Account module"
  type        = bool
}

variable "azure_storage_account_name" {
  description = "Azure Storage Account name"
  type        = string
}

variable "azure_storage_tier" {
  description = "Azure Storage Account tier"
  type        = string
}

variable "enable_azure_identity" {
  description = "Enable Azure Managed Identity"
  type        = bool
}

variable "azure_identity_name" {
  description = "Azure Managed Identity name"
  type        = string
}

variable "enable_azure_postgres" {
  description = "Enable Azure PostgreSQL module"
  type        = bool
}

variable "azure_postgres_name" {
  description = "PostgreSQL server name"
  type        = string
}

variable "azure_pg_admin_login" {
  description = "PostgreSQL admin username"
  type        = string
  sensitive   = true
}

variable "azure_pg_admin_password" {
  description = "PostgreSQL admin password"
  type        = string
  sensitive   = true
}

variable "azure_pg_sku" {
  description = "PostgreSQL SKU"
  type        = string
}

variable "enable_azure_app_service" {
  description = "Enable Azure App Service module"
  type        = bool
}

variable "azure_app_service_name" {
  description = "App Service name"
  type        = string
}

variable "azure_app_service_tier" {
  description = "App Service tier"
  type        = string
}

variable "azure_app_service_runtime" {
  description = "App Service runtime (Linux FX version)"
  type        = string
}
