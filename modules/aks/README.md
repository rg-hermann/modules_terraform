# Módulo Terraform: Azure AKS

Este módulo cria um cluster AKS integrado à VNet e ao Key Vault.

## Variáveis principais

## Outputs

## Requisitos
- Terraform >= 1.3.0
- Provider AzureRM >= 3.0.0

## Variáveis
| Nome                 | Tipo      | Default           | Descrição                                 |
|----------------------|-----------|-------------------|--------------------------------------------|
| aks_name             | string    | -                 | Nome do cluster AKS                        |
| location             | string    | -                 | Localização do recurso Azure               |
| resource_group_name  | string    | -                 | Nome do Resource Group                     |
| dns_prefix           | string    | -                 | Prefixo DNS para o AKS                     |
| node_count           | number    | 1                 | Quantidade de nós do cluster               |
| vm_size              | string    | Standard_DS2_v2   | Tamanho da VM dos nós                      |
| subnet_id            | string    | -                 | ID da subnet da VNet para o AKS            |
| keyvault_id          | string    | -                 | ID do Key Vault para secrets               |
| kubernetes_version   | string    | 1.28.3            | Versão do Kubernetes                       |
| public_subnet_route_table_id | string | -             | ID da route table da subnet pública        |
| api_server_authorized_ip_ranges | list(string) | []  | IPs/CIDRs permitidos no API Server (restrinja em prod) |
| enable_private_cluster | bool | false | Habilita private cluster (API interna) |
| network_plugin        | string | azure | Plugin de rede (azure|kubenet) |
| network_policy        | string | azure | Network policy provider (azure|calico) |
| log_analytics_workspace_id | string | null | ID de workspace existente para logging (OMS) |

## Outputs
| Nome         | Descrição                                      |
|--------------|------------------------------------------------|
| aks_id       | ID do cluster AKS                              |
| kube_config  | Configuração do kubeconfig para acesso ao AKS  |
| aks_principal_id | Principal ID da Managed Identity do AKS     |
| aks_tenant_id    | Tenant ID da Managed Identity do AKS        |
| aks_identity_ids | Lista de User Assigned Managed Identity IDs |

## Providers
```hcl
provider "azurerm" {
  features {}
}
```

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
  api_server_authorized_ip_ranges = ["177.10.10.10/32"]
  network_policy                  = "azure"
  network_plugin                  = "azure"
}
```

## Notas de Segurança
- Defina `api_server_authorized_ip_ranges` para restringir acesso ao control plane.
- Considere `enable_private_cluster = true` em ambientes sensíveis.
- Use `network_policy` (azure ou calico) para aplicar isolamento de tráfego.
- Forneça `log_analytics_workspace_id` para habilitar logging de cluster.
 - Se usar o módulo `log_analytics` no root, o ID dele é automaticamente detectado (fallback via `effective_log_analytics_workspace_id`).
