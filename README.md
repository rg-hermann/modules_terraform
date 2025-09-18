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
- Adicionar Azure Monitor / Log Analytics workspace para o AKS.
- Implementar Azure CNI / Network Policies avançadas.
- Integrar com Azure Container Registry (ACR) e dar permissão à Managed Identity.
- Adicionar Private Endpoints para Key Vault.
- Pipeline CI (GitHub Actions) com `terraform fmt` / `validate` / `plan`.

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
