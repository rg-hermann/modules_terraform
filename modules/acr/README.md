# Módulo ACR (Azure Container Registry)

Provisiona um Azure Container Registry com tagging consistente e (opcionalmente) atribui a role `AcrPull` para a identidade do AKS.

## Inputs
| Nome | Tipo | Default | Descrição |
|------|------|---------|-----------|
| `acr_name` | string | n/a | Nome global único (minúsculo) do ACR |
| `location` | string | n/a | Região Azure |
| `resource_group_name` | string | n/a | Resource Group alvo |
| `acr_sku` | string | `Basic` | SKU (Basic/Standard/Premium) |
| `tags` | map(string) | `{}` | Tags adicionais |
| `assign_aks_pull` | bool | `true` | Concede AcrPull se `aks_principal_id` definido |
| `aks_principal_id` | string | "" | Principal ID da identity do AKS |

## Outputs
| Nome | Descrição |
|------|-----------|
| `acr_id` | ID do registry |
| `acr_login_server` | Host para push/pull |

## Exemplo de Uso (root)
```hcl
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  acr_sku             = var.acr_sku
  tags                = local.base_tags
  assign_aks_pull     = var.acr_assign_aks_pull
  aks_principal_id    = module.aks.aks_principal_id
}
```

## Notas Futuras
- Habilitar rede privada (Private Endpoint)
- Hardening com políticas de conteúdo/assinatura
- Logs diagnósticos (via Diagnostic Settings)
