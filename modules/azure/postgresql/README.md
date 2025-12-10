# Azure PostgreSQL Module

Flexible PostgreSQL server with databases.

## Inputs
- `server_name` - Server name
- `location`, `resource_group_name`
- `admin_login`, `admin_password`
- `sku_name` - SKU
- `storage_mb` - Storage
- `backup_retention_days`
- `databases` - Database names
- `tags`

## Outputs
- `server_id`
- `fqdn`
- `database_ids`
