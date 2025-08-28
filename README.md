# Azure Terraform Modules

Este repositório contém módulos Terraform reutilizáveis para provisionamento de infraestrutura no Microsoft Azure, com foco em segurança, modularidade e boas práticas.

## Visão Geral
- **Infraestrutura modular:** VNet, Key Vault, AKS e backend remoto para estado do Terraform.
- **Segurança:** Uso de Managed Service Identity (MSI) e criptografia de secrets com git-crypt.
- **Pronto para produção:** Parametrização via arquivos `.tfvars`, integração entre módulos e outputs organizados.

## Módulos Disponíveis
- **VNet:** Criação de rede virtual com subnets públicas e privadas, NSGs e route tables customizadas.
- **Key Vault:** Provisionamento de Azure Key Vault com políticas de acesso seguras.
- **AKS:** Cluster Kubernetes integrado à VNet e Key Vault, com identidade gerenciada.

## Como Usar
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

## Requisitos
- Terraform >= 1.5
- Azure CLI
- git-crypt (opcional, para criptografia de secrets)

## Contribuição
Pull requests são bem-vindos! Sinta-se à vontade para abrir issues ou sugerir melhorias.

## Licença
Este projeto está sob a licença MIT.
