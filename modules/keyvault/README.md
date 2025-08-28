# Módulo Terraform: Azure Key Vault

Este módulo cria um Azure Key Vault com:
- Soft delete e purge protection habilitados
- Política de acesso parametrizável
- Outputs do ID e URI do Key Vault

## Variáveis principais
- `keyvault_name`
- `location`
- `resource_group_name`
- `tenant_id`
- `sku_name`
- `object_id`

## Outputs
- `keyvault_id`
- `keyvault_uri`

## Exemplo de uso
```hcl
module "keyvault" {
  source              = "./modules/keyvault"
  keyvault_name       = "kv-demo"
  location            = "eastus"
  resource_group_name = "rg-example"
  tenant_id           = "<tenant_id>"
  object_id           = "<object_id>"
  sku_name            = "standard"
}
```
