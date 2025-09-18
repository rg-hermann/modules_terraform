# Pull Request Title

> Resumo curto e claro do que este PR faz. (Ex: "Adiciona módulo Azure Function e integra variáveis opcionais").

## 🧩 Tipo de Mudança
Selecione (marque com `x`):
- [ ] Feature nova
- [ ] Correção de bug
- [ ] Refatoração (sem mudança de comportamento)
- [ ] Infra / CI / DevEx
- [ ] Documentação
- [ ] Segurança / Hardening
- [ ] Outra (descrever)

## 📑 Descrição Detalhada
Explique o contexto, motivação e design adotado.
- Problema que motivou
- O que foi feito (alto nível)
- Decisões de design relevantes
- Alternativas consideradas (se houver)

## 🧪 Evidências / Testes
Descreva como validou:
- Comandos executados (`terraform validate`, `terraform plan`)
- Saída relevante (resumida)
- Logs ou prints (se necessário)

## 🔐 Impacto em Segurança / Compliance
- [ ] Não afeta
- Se afeta: descreva controles adicionados (ex: tags, encryption, TLS, roles)

## 🧷 Backwards Compatibility
- [ ] Não quebra compatibilidade
- Se potencialmente breaking: detalhe impacto e plano de migração

## 🧵 Módulos / Áreas Afetadas
Liste diretórios ou módulos tocados:
```
modules/azure_function
variables.tf
main.tf
```

## ✅ Checklist Geral
- [ ] `terraform fmt` sem diffs
- [ ] `terraform validate` OK
- [ ] CI passou (fmt / validate / tflint / tfsec / plan)
- [ ] Variáveis novas documentadas (`README.md` / `COPILOT.md`)
- [ ] Outputs sensíveis marcados (se aplicável)
- [ ] Nomes estáveis (evita recriação desnecessária)
- [ ] Tags consistentes aplicadas
- [ ] Comentários adicionados onde necessário
- [ ] Sem secrets em plain text

## 🧭 Observabilidade (se aplicável)
- [ ] Logs / métricas integrados (Log Analytics / App Insights)
- [ ] Futuros diagnostic settings planejados

## 🔄 Passos para Revisores
1. Ler descrição
2. Conferir diff de módulos alterados
3. Rodar local (opcional) `terraform plan -var-file=env/dev.tfvars`
4. Validar naming / tags
5. Aprovar / pedir ajustes

## 📌 Notas Adicionais
(Use para pendências, TODOs, follow-ups que não entram neste PR)

---
> Dica: Use commits pequenos e mensagens claras. Se este PR ficar grande, considere dividir.
