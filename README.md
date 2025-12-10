<!-- Status Badges -->
![Terraform CI](https://github.com/rg-hermann/modules_terraform/actions/workflows/terraform-ci.yml/badge.svg)
![PR Quality Guard](https://github.com/rg-hermann/modules_terraform/actions/workflows/pr-quality.yml/badge.svg)

## Visão Geral
- **Infraestrutura modular:** VNet, Key Vault, AKS, ACR, Log Analytics e (opcional) Azure Function App, além de backend para estado Terraform.
- **Segurança:** Uso de Managed Service Identity (MSI), outputs sensíveis marcados e preparo para private endpoints futuros.
 
- **Observabilidade:** Workspace Log Analytics opcional + (agora) Application Insights via módulo de Function.
- **Pronto para produção:** Parametrização via `.tfvars`, módulos desacoplados e padronização de tags.
- **Boas práticas adicionais:** Validações em variáveis, naming consistente via `prefix`, outputs condicionais usando `try()`.
## Módulos Disponíveis
- **VNet:** Rede virtual com subnets públicas e privadas, NSGs e route tables customizadas.
- **Key Vault:** Cofre para segredos com purge protection e validações.
- **AKS:** Cluster Kubernetes com identidade gerenciada e integração Key Vault.
- **ACR (opcional):** Registro de container com role `AcrPull` automática para o AKS.
- **Log Analytics (opcional):** Workspace para logs/metrics (diagnostic settings futuros).
 
- **Azure Function (opcional / novo):** Provisiona Linux Function App com runtime dinâmico, Application Insights e identidade gerenciada.
 
Exemplo de `env/dev.tfvars` (já fornecido) – agora incluindo opções de Function:
 ```hcl
 aks_name           = "aks-demo-rgh01"
## Estrutura do Projeto
```
 modules_terraform/
 ├── modules/
 │   ├── vnet/
 │   ├── keyvault/
 │   ├── aks/
 │   ├── acr/
 │   ├── log_analytics/
 │   └── azure_function/
 
## Próximos Passos / Melhorias Futuras
- Diagnostic Settings centralizados (AKS / Key Vault / Storage / ACR / Function) -> Log Analytics
- Azure CNI / Network Policies avançadas no AKS
- ACR: private link, content trust, lifecycle policies, tasks
- Private Endpoints (Key Vault, Storage, ACR, Function)
- Pipeline Apply manual com aprovação e trava de plano
- Testes (Terratest) para módulos críticos
- Azure Policy / drift detection
- Workload Identity (OIDC federado) para workloads AKS e Functions
- Slots e VNet Integration para Function App
## CI/CD (GitHub Actions)
Workflow de CI (`terraform-ci`) já incluído validando: fmt, validate, tflint, tfsec (soft+strict), plan em PR e comentário automático.
 
### Próximos Passos para o Apply Automatizado
- Criar workflow `terraform-apply.yml` manual.
- Usar `-lock-timeout=5m` e `-input=false`.
- Reutilizar plano armazenado (mesmo commit) para evitar TOCTOU.
 
## Comandos Úteis
```sh
terraform fmt -recursive
terraform validate
terraform plan -var-file=env/dev.tfvars
terraform apply -var-file=env/dev.tfvars
terraform output -json | jq
```
 
### Exemplo de Uso do Módulo Azure Function (isolado)
```hcl
module "azure_function" {
   source                              = "./modules/azure_function"
   function_app_name                   = var.function_app_name
   location                            = var.location
   resource_group_name                 = var.resource_group_name
   runtime_stack                       = var.function_runtime_stack
   runtime_version                     = var.function_runtime_version
   app_service_plan_sku                = var.function_app_service_plan_sku
   enable_application_insights         = var.function_enable_application_insights
   identity_type                       = var.function_identity_type
   user_assigned_identity_ids          = var.function_user_assigned_identity_ids
   storage_account_name                = var.function_storage_account_name
   app_settings                        = var.function_app_settings
   always_on                           = var.function_always_on
   tags                                = local.base_tags
}
```
# Azure Terraform Modules

Este repositório contém módulos Terraform reutilizáveis para provisionamento de infraestrutura no Microsoft Azure, com foco em segurança, modularidade e boas práticas.

## Visão Geral
- **Infraestrutura modular:** VNet, Key Vault, AKS e backend remoto para estado do Terraform.
- **Segurança:** Uso de Managed Service Identity (MSI) e criptografia de secrets com git-crypt.
- **Pronto para produção:** Parametrização via arquivos `.tfvars`, integração entre módulos e outputs organizados.
 - **Boas práticas adicionais:** Validações em variáveis, tagging consistente, outputs sensíveis marcados.

## Módulos Disponíveis
- **VNet:** Criação de rede virtual com subnets públicas e privadas, NSGs e route tables customizadas.
- **Key Vault:** Provisionamento de Azure Key Vault com políticas de acesso seguras.
- **AKS:** Cluster Kubernetes integrado à VNet e Key Vault, com identidade gerenciada.
- **ACR:** Registro de container opcional com concessão automática de `AcrPull` para o AKS.
- **Log Analytics (novo):** Criação de workspace centralizado para observabilidade (diagnostics podem ser adicionados depois).

## Como Usar (Fluxo Local / Backend Local)
1. **Clone o repositório:**
   ```sh
   git clone https://github.com/rg-hermann/modules_terraform.git
   cd modules_terraform
   ```
2. **Configure suas variáveis de ambiente:**
   Edite o arquivo `env/dev.tfvars` com seus valores.
3. **Inicialize o Terraform:**
   ```sh
   terraform init
   ```
4. **Aplique a infraestrutura:**
   ```sh
   terraform apply -var-file=env/dev.tfvars
   ```

## (Opcional) Configurar Backend Remoto no Azure Storage
O código já cria (localmente) um Resource Group + Storage Account + Container para armazenar o estado. Para usar como backend remoto:

1. Execute inicialmente em backend local para criar os recursos:
   ```sh
   terraform init
   terraform apply -var-file=env/dev.tfvars -target=azurerm_resource_group.tfstate -target=azurerm_storage_account.tfstate -target=azurerm_storage_container.tfstate
   ```
2. Edite o bloco `terraform` em `main.tf` descomentando e preenchendo o backend:
   ```hcl
   terraform {
     backend "azurerm" {
       resource_group_name  = "<rg-example>"
       storage_account_name = "<rghstorage01>"
       container_name       = "<tfstate>"
       key                  = "global/terraform.tfstate"
     }
   }
   ```
3. Re-inicialize migrando o estado:
   ```sh
   terraform init -migrate-state
   ```

## Variáveis Principais
Arquivo `variables.tf` contém entradas como:
- `subscription_id`, `resource_group_name`, `location`
- `vnet_*` para rede
- `keyvault_*` para Key Vault
- `aks_*` para cluster Kubernetes
- `tags` (map) para customização de tags. Tags base como `managed_by` são adicionadas automaticamente.

Exemplo de `env/dev.tfvars` (já fornecido):
```hcl
aks_name           = "aks-demo-rgh01"
dns_prefix         = "aksrgh01"
node_count         = 2
vm_size            = "Standard_DS2_v2"
location           = "eastus"
resource_group_name = "rg-example"
vnet_name          = "vnet-example"
vnet_address_space = ["10.1.0.0/16"]
public_subnet_name   = "public-subnet"
public_subnet_prefix = ["10.1.1.0/24"]
private_subnet_name  = "private-subnet"
private_subnet_prefix = ["10.1.2.0/24"]
keyvault_name       = "kv-demo-rgh01"
subscription_id     = "<id>"
tenant_id           = "<tenant>"
object_id           = "<object>"
storage_account_name   = "rghstorage01"
storage_container_name = "tfstate"
acr_name               = "rghacrdev01"
acr_sku                = "Basic"
acr_assign_aks_pull    = true
log_analytics_workspace_name = "law-rgh-dev01"
log_analytics_sku             = "PerGB2018"
log_analytics_retention_days  = 30
enable_diagnostics            = true
```

## Estrutura do Projeto
```
modules_terraform/
├── modules/
│   ├── vnet/
│   ├── keyvault/
│   └── aks/
├── env/
│   └── dev.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

## Segurança
- Secrets e variáveis sensíveis são criptografados com git-crypt.
- Uso de MSI para autenticação segura no Azure.
 - Output `kube_config` marcado como `sensitive` para evitar exposição acidental.
 - `purge_protection_enabled` e `soft_delete` ativados no Key Vault.

## Requisitos
- Terraform >= 1.5
- Azure CLI
- git-crypt (opcional, para criptografia de secrets)

## Próximos Passos / Melhorias Futuras
- Integrar diagnósticos do AKS / Key Vault / Storage ao Log Analytics (Diagnostic Settings).
- Implementar Azure CNI / Network Policies avançadas.
- ACR: habilitar private link / políticas de conteúdo / retenção / tasks automatizadas.
- Adicionar Private Endpoints para Key Vault e Storage.
- Pipeline de Apply manual com aprovação (GitHub Actions) e proteção de branch.
- Testes (Terratest) para módulos críticos.
- Integração de Azure Policy / drift detection.
- Workload Identity (OIDC federado) para workloads no AKS.

## CI/CD (GitHub Actions)
Um workflow de CI (`terraform-ci`) foi adicionado para validar mudanças automaticamente.

### Workflows Disponíveis
1. `terraform-ci` (automático em PR e push):
   - `terraform fmt -check`
   - `terraform validate`
   - `tflint` (com plugin azurerm)
   - `tfsec` (job suave + job estrito separado)
   - `terraform plan` (somente em pull requests) e upload como artefato
   - Comentário no PR com resumo do plano
2. (Planejado) `terraform-apply`:
   - Disparado manualmente via `workflow_dispatch`
   - Reutiliza o plano gerado ou recria em ambiente controlado
   - Exige approvals de revisão

### Requisitos de Secrets (para backend remoto / apply futuro)
Configurar em `Settings > Secrets and variables > Actions`:
- `ARM_CLIENT_ID` (se usar Service Principal - opcional caso use OIDC)
- `ARM_CLIENT_SECRET` (se usar Service Principal)
- `ARM_TENANT_ID`
- `ARM_SUBSCRIPTION_ID`

Caso opte por OIDC (recomendado), será necessário adicionar uma Federated Credential no Entra ID apontando para o repositório (GitHub). O workflow poderá então trocar para um passo de login:
```
- uses: azure/login@v2
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
```

### Lint & Segurança
- `tflint` garante padrões de estilo e potenciais erros de provider.
- `tfsec` roda em dois modos: um permissivo (não falha o pipeline principal) e um estrito (falha se severidade >= MEDIUM). Ajustável via `.tfsec.yml`.
- `Trivy` (novo) realiza varredura IaC (config) e gera SARIF publicado na aba Security (Code scanning). Substitui gradualmente tfsec (mantido por compatibilidade enquanto migração acontece).

#### Rodando Trivy localmente
```sh
# Scan de configuração Terraform (diretório atual)
trivy config . --severity MEDIUM,HIGH,CRITICAL --ignore-unfixed --skip-dirs .terraform

# Gerar relatório SARIF local
trivy config . --format sarif --output trivy-terraform.sarif

# Usar arquivo de ignore (opcional)
trivy config . --ignorefile .trivyignore
```

#### Política de ignores
- Cada regra ignorada deve ter justificativa e data de revisão.
- Evitar crescimento de exceções permanentes.
- Revisar `.trivyignore` periodicamente.

### Como Rodar Localmente (para reproduzir CI)
```sh
terraform fmt -recursive
terraform init
terraform validate
tflint --init && tflint
tfsec .
terraform plan -var-file=env/dev.tfvars
```

### Próximos Passos para o Apply Automatizado
- Criar workflow `terraform-apply.yml` somente manual.
- Usar `-lock-timeout=5m` e `-input=false`.
- Opcional: Armazenar plano como artefato e reutilizar (mesmo commit) para impedir TOCTOU.

---

## Comandos Úteis
```sh
terraform fmt -recursive
terraform validate
terraform plan -var-file=env/dev.tfvars
terraform apply -var-file=env/dev.tfvars
terraform output -json | jq
```

## Contribuição
Pull requests são bem-vindos! Sinta-se à vontade para abrir issues ou sugerir melhorias.

## Licença
Este projeto está sob a licença MIT.
# Re-trigger workflow
# Re-trigger 1765335335
# Re-trigger 1765335342
