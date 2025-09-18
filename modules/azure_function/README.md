# Módulo Azure Function App

Provisiona uma Azure Function (Linux) com opções de:
- Plano (Consumption Y1, Premium EP*, Dedicated B*/S*)
- Storage Account (reutilizado ou criado automaticamente)
- Application Insights opcional
- Identity (SystemAssigned / UserAssigned)
- Runtime dinâmico (python, node, dotnet, java, powershell)

## Entradas Principais
| Nome | Tipo | Descrição | Default |
|------|------|-----------|---------|
| function_app_name | string | Nome único da Function App | n/a |
| runtime_stack | string | python|node|dotnet|java|powershell | python |
| runtime_version | string | Versão runtime (ex: 3.11, 18, v8.0) | 3.11 |
| app_service_plan_sku | string | Y1/EP1/EP2/EP3/B1/B2/B3/S1/S2/S3 | Y1 |
| enable_application_insights | bool | Cria Application Insights | true |
| storage_account_name | string | Reutiliza storage existente (null cria) | null |
| always_on | bool | Força Always On (não para Y1) | false |
| identity_type | string | SystemAssigned|UserAssigned|SystemAssigned,UserAssigned | SystemAssigned |
| user_assigned_identity_ids | list(string) | IDs de identidades UA | [] |
| app_settings | map(string) | App settings extras | {} |
| tags | map(string) | Tags adicionais | {} |

## Saídas
| Nome | Descrição |
|------|-----------|
| function_app_id | ID do recurso |
| function_app_name | Nome da function |
| default_hostname | Host público |
| principal_id | Principal ID (system) |
| app_insights_connection_string | Connection string (sensível) |
| app_insights_instrumentation_key | Instrumentation Key (sensível) |

## Exemplo de Uso
```hcl
module "azure_function" {
  source               = "./modules/azure_function"
  function_app_name    = "fn-demo-rgh01"
  location             = var.location
  resource_group_name  = var.resource_group_name
  runtime_stack        = "python"
  runtime_version      = "3.11"
  app_service_plan_sku = "Y1"
  enable_application_insights = true
  tags = local.base_tags
}
```

## Notas
- `WEBSITE_RUN_FROM_PACKAGE=1` incluído para deployments via zip.
- `ignore_changes` em `app_settings` previne drift por deploy process.
- Para Premium/Dedicado considere `always_on=true`.
- Armazenamento: se reutilizar um existente assegure que tenha as configurações padrão (TLS1_2, LRS, etc.).

## Próximas Melhorias
- Slots de deployment opcionais
- Integração VNet (Regional VNet Integration)
- Azure Key Vault reference para secrets
- Private Endpoints
