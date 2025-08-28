// outputs.tf - Outputs do módulo VNet
output "vnet_id" {
  description = "ID da Virtual Network"
  value       = azurerm_virtual_network.this.id
}

output "public_subnet_id" {
  description = "ID da Subnet Pública"
  value       = azurerm_subnet.public.id
}

output "private_subnet_id" {
  description = "ID da Subnet Privada"
  value       = azurerm_subnet.private.id
}

output "public_subnet_route_table_id" {
  description = "ID da route table da Subnet Pública"
  value       = azurerm_route_table.public_rt.id
}