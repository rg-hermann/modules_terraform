locals {
  aks_tags = merge({ module = "aks" }, var.tags)
}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "${var.aks_name}-identity"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.aks_tags
}
resource "azurerm_kubernetes_cluster" "this" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  tags                = local.aks_tags

  default_node_pool {
    name                 = "default"
    node_count           = var.node_count
    vm_size              = var.vm_size
    vnet_subnet_id       = var.subnet_id
    orchestrator_version = var.kubernetes_version
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  kubernetes_version = var.kubernetes_version

  oidc_issuer_enabled               = true
  role_based_access_control_enabled = true
}
resource "azurerm_role_assignment" "aks_route_table_network_contributor" {
  scope                = var.public_subnet_route_table_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}
