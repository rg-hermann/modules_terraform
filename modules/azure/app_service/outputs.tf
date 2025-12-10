output "app_service_id" {
  value = azurerm_app_service.this.id
}

output "app_service_default_site_hostname" {
  value = azurerm_app_service.this.default_site_hostname
}

output "app_service_outbound_ip_addresses" {
  value = azurerm_app_service.this.outbound_ip_addresses
}
