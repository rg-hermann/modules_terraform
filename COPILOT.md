# Copilot Guide – Contexto, Convenções e Boas Práticas

Este documento serve como memória viva para automações (ex: GitHub Copilot / agentes) entenderem rapidamente o estado do projeto, padrões adotados e como evoluir com segurança.

## 1. Objetivo do Repositório
Infraestrutura modular em Terraform para Azure (rede, segurança, container runtime e observabilidade inicial) visando escalabilidade, segurança e reuso.

## 2. Stack Atual
- Terraform >= 1.5
- Provider AzureRM `~> 4.41.0`
- Módulos internos: `vnet`, `keyvault`, `aks`, `acr`, `log_analytics`
- Estado atualmente local (backend azurerm comentado – pode ser ativado)

## 3. Padrões Gerais
| Tema | Padrão | Observações |
|------|--------|-------------|
| Naming | Entradas definidas via tfvars. Sugere-se padronizar com `prefix` + sufixos | Futuro: local `ns` centralizado |
| Tags | Merge de tags do usuário + base (`managed_by=terraform`, `environment`) | Evitar sobrescrever `managed_by` |
| Sensibilidade | Outputs sensíveis marcados (`kube_config`, keys) | Nunca imprimir conteúdo em logs / pipeline |
| Validações | Regex e limites de comprimento em variáveis críticas | Expandir para novas regiões quando necessário |
| Módulos | Isolados, inputs explícitos, sem dependência circular | Favor manter interface mínima |
| Formatação | `terraform fmt -recursive` obrigatório | Adicionar pre-commit futuramente |
| Versionamento provider | Pinned com `~>` | Atualizar conscientemente após leitura de CHANGELOG |

## 4. Estrutura dos Módulos
Cada módulo segue:
```
modules/<nome>/
  main.tf        # Recursos
  variables.tf   # Entradas com validação
  outputs.tf     # Saídas consumíveis
  README.md      # (quando aplicável) Documentação breve
```

## 5. Visão dos Módulos
| Módulo | Finalidade | Possíveis Extensões |
|--------|------------|---------------------|
| vnet | VNet + subnets + NSGs + route table básica | Private endpoints, NAT, Azure Firewall, DNS Private Zones |
| keyvault | Cofre para segredos com purge protection | RBAC em vez de access policies, private endpoint, policies (soft delete retention > 7) |
| aks | Cluster Kubernetes com identidade gerenciada + OIDC | Node pools separados, autoscaler, private cluster, network policy, Azure CNI |
| acr | Registro de imagens + role `AcrPull` p/ AKS | Private link, content trust, tasks build, lifecycle policies |
| log_analytics | Workspace de logs | Diagnostic settings modulares, alert rules, app insights integração |

## 6. Roadmap Prioritário (Sugestão)
1. Backend remoto definitivo (Storage + versioning + locks + network restrictions)
2. Diagnostic Settings centralizados (módulo próprio ou estender `log_analytics` de forma resiliente)
3. Private Endpoints (Key Vault, ACR, possivelmente Storage backend)
4. ACR hardening (políticas de retenção / exclusão, content trust)
5. AKS enhancements: autoscaling, system/user pools, network policy (Calico/Azure), API server authorized IPs
6. Workload Identity + Federated Credentials (Key Vault / outras APIs)
7. Observabilidade: Container Insights / Prometheus + Alert Rules
8. Pipeline CI (fmt/validate/tflint/tfsec/plan) + aprovação manual para `apply`
9. Política / Governança: Azure Policy (tags obrigatórias, TLS1_2, bloqueio de recursos inseguros)
10. Terratest para smoke tests (RG, VNet, outputs críticos)

## 7. Boas Práticas Concretas
- Evitar interpolação antiga: usar sempre sintaxe moderna (`${}` só quando estritamente necessário dentro de strings).
- Não criar dependências implícitas: usar `explicit inputs > depends_on` somente quando inevitável.
- Minimizar drift: se campos são mutáveis/externos (ex: tags de runtime), considerar `ignore_changes`.
- Módulos opcionais sempre via `count` ou `for_each` com `try()` nos outputs no root.
- Nome de recursos deve permanecer estável (evitar renames que forçam recriação sem necessidade).

## 8. Lint, Qualidade e Segurança (Planejado)
Adicionar no futuro:
- `tflint` com regras Azure
- `tfsec` (ou `checkov`)
- `pre-commit` com hooks (`fmt`, `validate`, `tflint`, `tfsec`)
- GitHub Actions: workflow `pull_request` => plan; workflow `main` => apply (gated)

## 9. Política de Versionamento / Atualizações
- Atualizar provider somente após executar `terraform plan` em ambiente isolado.
- Taggear releases de infraestrutura (ex: `v0.1.0`, `v0.2.0`).
- Manter CHANGELOG se começar a versionar módulos independentemente.

## 10. Padrão para Novos Módulos
Checklist rápido:
1. Nome descritivo simples (`dns`, `app_gateway`, `redis` etc.)
2. `variables.tf` com:
   - Validações
   - Defaults razoáveis
   - Campos sensíveis evitados (preferir data sources / Key Vault)
3. `main.tf` limpo, sem lógica condicional redundante
4. `outputs.tf` só o necessário (IDs, endpoints, segregar outputs sensíveis)
5. README com: Descrição, Inputs, Outputs, Exemplo
6. Testar com `terraform validate` e plan em exemplo de root

## 11. Estratégia de Diagnósticos (Planejado)
Quando reintroduzir diagnostic settings criar módulo `diagnostics`:
- Inputs: lista de objetos `{ resource_id, categories (optional), metrics (bool) }`
- Internamente: fazer discovery de categorias via `data` (se suportado) ou set baseline segura
- Evitar falha se categoria não existir (ignorar com `can()` / length checks)

## 12. Segurança / Hardening Futuro
| Item | Ação Futuras |
|------|--------------|
| Storage backend | Versioning + Immutability (container) + `allow_blob_public_access = false` |
| Key Vault | Private Endpoint + RBAC + Retention > 7 dias |
| AKS | Network Policy + Private Cluster + API IPs restritos |
| ACR | Private Link + Desabilitar acesso anônimo + Task automation integrada |
| Logging | Centralizar em LA + export opcional para Event Hub / Archive |

## 13. Convenção de Saída (Outputs) no Root
- Usar `try(module.x[0].y, null)` para módulos opcionais com `count`
- Marcar `sensitive = true` sempre que for credencial, kubeconfig ou chave

## 14. Uso de Workspaces vs Múltiplos Diretórios
Atualmente um único root. Estratégias futuras:
- Workspaces Terraform (dev/stage/prod) – simples, mas pode gerar acoplamento
- Diretórios por ambiente (`envs/dev`, `envs/prod`) – maior isolamento e granularidade de state
- Recomendação: separar “foundation” (rede + keyvault + storage state) de “platform” (aks + acr + monitor)

## 15. Scripts e Automação (Futuros)
Criar diretório `scripts/` com utilitários:
- `plan.sh` (padroniza var-file + workspace)
- `validate.sh` (fmt + validate + lint)
- `release.sh` (gera tag após plan/apply bem-sucedido)

## 16. Erros Comuns a Evitar
| Cenário | Mitigação |
|---------|-----------|
| Nomes alterados causando recriação | Definir naming derivado de prefix + módulo + sufixos estáveis |
| Adição de módulo sem outputs condicionais | Sempre envolver outputs com `try()` |
| Vazamento de kubeconfig em pipelines | Nunca ecoar output sensível; usar `terraform output -raw` direto para arquivo protegido |
| Falta de tags obrigatórias corporativas | Centralizar merge em `local.base_tags` |

## 17. Próximas Ações Recomendadas (Automação)
- Criar workflow `.github/workflows/ci.yml` com: fmt -> validate -> tflint -> tfsec -> plan
- Adicionar badge de status no README
- Incluir exemplo de consumo de ACR com workload identity (quando habilitado)

## 18. Como um Agente Deve Prosseguir em Futuras Tarefas
1. Ler `variables.tf` para confirmar interface antes de editar
2. Executar `terraform fmt` + `validate`
3. Adicionar mudanças mínimas (não refatorar em massa sem necessidade)
4. Se criar módulo novo: seguir seção 10
5. Atualizar README + COPILOT.md se alterar comportamento externo
6. Rodar plan informativo (sem aplicar automaticamente, a menos que instruído)

## 19. Glossário Rápido
| Termo | Definição |
|-------|-----------|
| MSI | Managed Service Identity (User Assigned no AKS) |
| OIDC | Issuer habilitado para Workload Identity (futuro) |
| Diagnostic Settings | Encaminhamento de logs/metrics para workspace LA |

## 20. Contato / Ownership
- `managed_by=terraform` nas tags indica controle IaC
- Adicionar futura tag `owner` para identificar responsável de cada ambiente

---
Se um agente precisar expandir segurança/observabilidade, deve começar pelas seções 6, 11 e 12.
