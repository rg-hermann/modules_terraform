# Módulo Terraform: Azure AKS

Este módulo cria um cluster AKS integrado à VNet e ao Key Vault.

## Variáveis principais
- `aks_name`
- `location`
- `resource_group_name`
- `dns_prefix`
- `node_count`
- `vm_size`
- `subnet_id`
- `keyvault_id`
- `kubernetes_version`

## Outputs
- `aks_id`
- `kube_config`

## Exemplo de uso
```hcl
module "aks" {
  source              = "./modules/aks"
  aks_name            = "aks-demo"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "aksdemo"
  node_count          = 2
  vm_size             = "Standard_DS2_v2"
  subnet_id           = module.vnet.public_subnet_id
  keyvault_id         = module.keyvault.keyvault_id
  kubernetes_version  = "1.28.3"
}
```
