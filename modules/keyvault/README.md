# Módulo Terraform: Azure Key Vault

Este módulo cria um Azure Key Vault com:

## Variáveis principais

## Outputs

## Requisitos
- Terraform >= 1.3.0
- Provider AzureRM >= 3.0.0

## Variáveis
| Nome           | Tipo      | Default    | Descrição                                      |
|----------------|-----------|------------|-------------------------------------------------|
| keyvault_name  | string    | -          | Nome do Key Vault                               |
| location       | string    | -          | Localização do recurso Azure                    |
| resource_group_name | string | -         | Nome do Resource Group                          |
| tenant_id      | string    | -          | ID do tenant Azure                              |
| sku_name       | string    | standard   | SKU do Key Vault (Standard ou Premium)          |
| object_id      | string    | -          | Object ID do usuário/aplicação para acesso      |

## Outputs
| Nome         | Descrição                |
|--------------|--------------------------|
| keyvault_id  | ID do Key Vault criado   |
| keyvault_uri | URI do Key Vault         |

## Providers
```hcl
provider "azurerm" {
  features {}
}
```

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
