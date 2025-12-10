# ============================================================================
# AWS OUTPUTS (uncomment after merging AWS module PRs)
# ============================================================================

# output "aws_vpc_id" {
#   description = "AWS VPC ID"
#   value       = try(module.aws_vpc[0].vpc_id, null)
# }

# output "aws_security_group_id" {
#   description = "AWS Security Group ID"
#   value       = try(module.aws_security_group[0].security_group_id, null)
# }

# output "aws_alb_dns_name" {
#   description = "AWS ALB DNS name"
#   value       = try(module.aws_load_balancer[0].alb_dns_name, null)
# }

# output "aws_s3_bucket_id" {
#   description = "AWS S3 bucket ID"
#   value       = try(module.aws_s3[0].bucket_id, null)
# }

# output "aws_rds_endpoint" {
#   description = "AWS RDS endpoint"
#   value       = try(module.aws_rds[0].db_instance_endpoint, null)
# }

# ============================================================================
# AZURE OUTPUTS (uncomment after merging Azure module PRs)
# ============================================================================

# output "azure_vnet_id" {
#   description = "Azure VNet ID"
#   value       = try(module.azure_vnet[0].vnet_id, null)
# }

# output "azure_storage_account_id" {
#   description = "Azure Storage Account ID"
#   value       = try(module.azure_storage[0].storage_account_id, null)
# }

# output "azure_managed_identity_id" {
#   description = "Azure Managed Identity ID"
#   value       = try(module.azure_identity[0].id, null)
# }

# output "azure_postgres_fqdn" {
#   description = "Azure PostgreSQL FQDN"
#   value       = try(module.azure_postgres[0].server_fqdn, null)
# }

# output "azure_app_service_hostname" {
#   description = "Azure App Service hostname"
#   value       = try(module.azure_app_service[0].default_site_hostname, null)
# }
