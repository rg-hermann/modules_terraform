# Azure App Service Module

App Service Plan + App Service.

## Inputs
- `app_service_name`, `app_service_plan_name`
- `location`, `resource_group_name`
- `kind` - Linux/Windows
- `sku_tier`, `sku_size`
- `linux_fx_version` or `dotnet_framework_version`
- `tags`

## Outputs
- `app_service_id`
- `app_service_default_site_hostname`
- `app_service_outbound_ip_addresses`
