output "function_app_id" {
  description = "ID da Function App"
  value       = azurerm_linux_function_app.this.id
}

output "function_app_name" {
  description = "Nome da Function App"
  value       = azurerm_linux_function_app.this.name
}

output "default_hostname" {
  description = "Host default (ex: nome.azurewebsites.net)"
  value       = azurerm_linux_function_app.this.default_hostname
}

output "principal_id" {
  description = "Principal ID da identidade gerenciada (system)"
  value       = azurerm_linux_function_app.this.identity[0].principal_id
  sensitive   = false
}

output "app_insights_connection_string" {
  description = "Connection string do Application Insights (se criado)"
  value       = try(azurerm_application_insights.fa[0].connection_string, null)
  sensitive   = true
}

output "app_insights_instrumentation_key" {
  description = "Instrumentation Key (se criado)"
  value       = try(azurerm_application_insights.fa[0].instrumentation_key, null)
  sensitive   = true
}
