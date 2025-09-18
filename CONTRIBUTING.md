# Guia de Contribuição

Obrigado por contribuir! Este repositório mantém módulos Terraform para Azure com foco em reuso, segurança e qualidade.

## Fluxo Geral
1. Crie uma issue (bug/feature) descrevendo o objetivo.
2. Crie uma branch a partir de `main`:
   - `feature/<slug>` para features
   - `fix/<slug>` para correções
   - `chore/<slug>` para tarefas internas
3. Implemente a mudança incremental (evite PRs gigantes).
4. Rode localmente (quando possível):
   ```sh
   terraform fmt -recursive
   terraform validate
   terraform plan -var-file=env/dev.tfvars
   ```
5. Abra o Pull Request usando o template.
6. Aguarde CI e revisões.
7. Após aprovação + merge, confirme se não há drift (`terraform plan`).

## Convenção de Commits (recomendada)
Formato sugerido:
```
<tipo>(<escopo>): descrição curta em minúsculas
```
Tipos comuns: `feat`, `fix`, `refactor`, `docs`, `ci`, `chore`.
Exemplos:
```
feat(azure_function): adiciona módulo opcional com runtime stack
fix(keyvault): normaliza sku para minúsculas
ci(tflint): ajusta versão de plugin
```

## Padrões de Código Terraform
| Tema | Diretriz |
|------|----------|
| Formatação | `terraform fmt` sempre antes do commit |
| Validação | `terraform validate` deve passar |
| Lint | CI executa `tflint` e `tfsec`; corrija avisos relevantes |
| Módulos Opcionais | Controlados via `count` e outputs com `try()` |
| Sensíveis | Marcar outputs sensíveis explicitamente |
| Tags | Centralizar em `local.base_tags` |
| Nomes | Evitar renomear recursos sem necessidade (recriação) |
| Variáveis | Usar validação (`validation {}`) onde fizer sentido |

## Adicionando um Novo Módulo
Checklist rápido:
- `modules/<nome>/main.tf` com recursos
- `variables.tf` com descrições e validação
- `outputs.tf` só o essencial (IDs, endpoints)
- `README.md` com: descrição, inputs, outputs, exemplo, melhorias futuras
- Atualizar `README.md` root + `COPILOT.md` se público
- Rodar `terraform validate` em cenário de teste

## Segurança
- Nunca colocar secrets em plaintext
- Preferir Key Vault para segredos críticos
- Não expor kubeconfig em logs
- Revisar alerta de severidade ALTA no `tfsec`

## CI/CD
- Workflow `terraform-ci` valida cada PR
- Futuro: workflow `terraform-apply` manual com aprovação

## Revisão de PR
Revisores verificam:
- Diffs minimizados
- Sem mudanças incidentais de formatação massiva
- Nomes estáveis
- Outputs sensíveis marcados
- Documentação atualizada

## Labels Sugeridas
| Label | Uso |
|-------|-----|
| `bug` | Correção de defeito |
| `enhancement` | Nova capacidade |
| `security` | Hardening / vulnerabilidade |
| `ci` | Pipeline / automação |
| `docs` | Documentação |
| `breaking-change` | Exige atenção na aplicação |

## Política de Merge
- Squash merge recomendado (histórico limpo)
- Commit final deve refletir escopo principal do PR

## Versionamento (Futuro)
Quando estabilizar: tags semânticas (`v0.x.y`).

## Suporte
Use Discussions para dúvidas gerais antes de abrir issue.

---
Contribua incrementalmente. Pequenos PRs = revisão rápida = menos regressões.
