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
| public_network_access_enabled | bool | false | Se true permite acesso público amplo (não recomendado) |
| network_acls_allowed_ips | list(string) | [] | IPs/CIDRs explicitamente permitidos            |
| network_acls_virtual_network_subnet_ids | list(string) | [] | Subnets autorizadas                 |
| network_acls_bypass | string | AzureServices | Serviços a bypass (AzureServices|None) |

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

## Notas de Segurança
- Com `public_network_access_enabled = false`, um bloco `network_acls` com `default_action = Deny` é aplicado.
- Adicione IPs confiáveis em `network_acls_allowed_ips` ou subnets privadas em `network_acls_virtual_network_subnet_ids`.
- Ajuste `network_acls_bypass = None` para postura mais restritiva.

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
