# 📦 Module: [Nome do Módulo]

**Type:** Feature | Bug Fix | Enhancement | Documentation

## 🎯 Objetivo
Descreva brevemente o que este PR faz.

## 📝 Alterações Principais
- [ ] Novo módulo `modules/[cloud]/[service]`
- [ ] Adicionadas variáveis em `variables.tf`
- [ ] Adicionados outputs em `outputs.tf`
- [ ] Atualizado `README.md` do módulo
- [ ] Atualizado `COPILOT.md`

## 🧪 Validação
Confirme que executou:
```bash
terraform fmt -recursive modules/
terraform validate
terraform plan -var-file=env/dev.tfvars
```

## ✅ Checklist
- [ ] `terraform validate` passou ✓
- [ ] CI/CD passou (tflint, tfsec, trivy)
- [ ] `README.md` atualizado com exemplos de uso
- [ ] Variáveis documentadas
- [ ] Outputs sensíveis marcados (se necessário)
- [ ] Tags aplicadas corretamente
- [ ] Sem secrets em plain text

## 📋 Módulo Afetado
```
modules/[cloud]/[service]/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

## 🔗 Links Relacionados
- Closes #
- Related to #
