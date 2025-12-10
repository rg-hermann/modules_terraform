# 📋 Contributing Guidelines

Bem-vindo! Este documento descreve os padrões e processos para contribuir a este repositório.

## 📚 Índice

- [Padrões de Repositório](#padrões-de-repositório)
- [Módulos Terraform](#módulos-terraform)
- [Pull Requests](#pull-requests)
- [Commits](#commits)
- [Code Review](#code-review)
- [CI/CD](#cicd)

## 🏗️ Padrões de Repositório

### Estrutura de Diretórios

```
modules_terraform/
├── modules/
│   ├── aws/
│   │   ├── vpc/
│   │   ├── security_group/
│   │   ├── elb/
│   │   ├── rds/
│   │   ├── s3/
│   │   ├── iam_role/
│   │   └── eks/
│   └── azure/
│       ├── vnet/
│       ├── storage_account/
│       ├── postgresql/
│       ├── managed_identity/
│       └── app_service/
├── env/
│   └── dev.tfvars
├── main.tf
├── variables.tf
├── outputs.tf
├── .github/
│   ├── workflows/
│   ├── ISSUE_TEMPLATE/
│   └── COMMIT_CONVENTION.md
└── README.md
```

### Convenções de Nomenclatura

**Variáveis:**
```terraform
# AWS
enable_aws_vpc           # Boolean para habilitar
aws_region              # String simples
aws_vpc_cidr            # Valores específicos

# Azure
enable_azure            # Boolean para habilitar
azure_location          # String simples
azure_vnet_address_space # Valores específicos
```

**Outputs:**
```terraform
output "aws_vpc_id" {
  description = "Descrição clara"
  value       = try(module.aws_vpc[0].vpc_id, null)
}
```

**Locals:**
```terraform
locals {
  base_tags = merge({
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project_name
  }, var.tags)
}
```

## 🧩 Módulos Terraform

### Estrutura de um Módulo

Cada módulo deve ter a seguinte estrutura:

```
modules/[cloud]/[service]/
├── main.tf          # Recursos principais
├── variables.tf     # Declaração de variáveis
├── outputs.tf       # Saídas do módulo
├── versions.tf      # Versões de providers
├── README.md        # Documentação
└── (terraform.tfvars) # Valores de teste (opcional)
```

### Checklist de Módulo

- [ ] `main.tf`: Recurso(s) principal(is) bem documentado(s)
- [ ] `variables.tf`: Todas variáveis com descrição
- [ ] `outputs.tf`: Outputs relevantes para composição
- [ ] `versions.tf`: Provider e Terraform pinados
- [ ] `README.md`: Exemplo de uso, variáveis, outputs
- [ ] `terraform validate`: Passou ✓
- [ ] `terraform fmt`: Sem diffs
- [ ] Tags aplicadas em recursos suportados
- [ ] Sem secrets em plain text

### Exemplo: AWS VPC

```terraform
# main.tf
resource "aws_vpc" "main" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.tags, {
    Name = "${var.name}-vpc"
  })
}

resource "aws_subnet" "public" {
  for_each                = var.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name = "${var.name}-public-${each.key}"
  })
}
```

## 📤 Pull Requests

### Antes de Abrir um PR

1. **Crie uma branch** com padrão `feat/`, `fix/`, `docs/`:
   ```bash
   git checkout -b feat/aws-vpc-module
   ```

2. **Valide localmente**:
   ```bash
   terraform fmt -recursive modules/
   terraform validate
   ```

3. **Commit com padrão Conventional Commits**:
   ```bash
   git commit -m "feat(aws-vpc): adiciona módulo VPC com subnets públicas/privadas"
   ```

### Abrindo um PR

1. **Preencha o template** (veja `.github/pull_request_template.md`)
2. **Checklist**:
   - [ ] Tipo de mudança selecionado
   - [ ] Descrição clara do objetivo
   - [ ] Validação executada
   - [ ] Módulos afetados listados
   - [ ] CI passed

### Padrão de PR

```markdown
# 📦 Module: AWS VPC

**Type:** Feature

## 🎯 Objetivo
Adiciona módulo VPC com suporte a subnets públicas e privadas.

## ✅ Checklist
- [x] `terraform validate` passou
- [x] CI/CD passou
- [x] README.md atualizado
- [x] Tags aplicadas
```

## 🔤 Commits

Siga [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>
```

**Types:**
- `feat`: Nova feature
- `fix`: Correção de bug
- `docs`: Documentação
- `refactor`: Refatoração
- `test`: Testes
- `chore`: Build, deps, etc.
- `ci`: CI/CD

**Scopes:**
- `aws-vpc`, `aws-rds`, `azure-vnet`, etc.
- `root` (main.tf, variables.tf)
- `ci-cd` (workflows)

**Exemplos:**
```bash
git commit -m "feat(aws-vpc): adiciona módulo com subnets"
git commit -m "fix(azure-postgres): corrige validação de sku"
git commit -m "docs(root): adiciona exemplos de composição"
git commit -m "ci(pr-quality): melhora cache de validation"
```

## 👥 Code Review

### Para Reviewers

1. **Valide estrutura**: Siga o checklist de módulo
2. **Teste localmente** (opcional):
   ```bash
   git fetch origin
   git checkout origin/feat/branch-name
   terraform plan -var-file=env/dev.tfvars
   ```
3. **Aprove ou peça ajustes**
4. **Merge** quando CI passar

### Padrão de Review

- ✅ Estrutura correta
- ✅ Variáveis bem nomeadas
- ✅ Outputs relevantes
- ✅ Tags aplicadas
- ✅ CI passed
- ✅ Documentação clara

## 🤖 CI/CD

### Workflows

1. **`terraform-ci.yml`**: Validation, lint, security scan (all commits)
2. **`module-validate.yml`**: Dynamic module discovery e validation
3. **`pr-quality.yml`**: Full quality gate para PRs
4. **`dependabot-auto-merge.yml`**: Auto-merge de dependências

### Validações Automáticas

```bash
✓ terraform fmt
✓ terraform validate (root + modules)
✓ tflint (Terraform linter)
✓ tfsec (Security scanner)
✓ trivy (Vulnerability scanner)
```

### Status Checks

All checks devem passar antes de merge:
- ✅ GitHub Actions (terraform-ci)
- ✅ PR Quality Check
- ✅ Code Review (recomendado)

## 📝 Labels

Labels aplicadas automaticamente baseadas em arquivos alterados:

- `aws`: Mudanças em módulos AWS
- `azure`: Mudanças em módulos Azure
- `ci`: Mudanças em workflows
- `documentation`: Mudanças em `.md`
- `dependencies`: Dependabot updates

## 🚀 Merge Strategy

- **Squash + merge** para features (limpa história)
- **Rebase + merge** para bugfixes e docs
- **Create a merge commit** para releases

## 📞 Suporte

- **Issues**: Use templates em `.github/ISSUE_TEMPLATE/`
- **Discussions**: Dúvidas gerais em GitHub Discussions
- **Security**: Reporte em maintainers direto

---

**Obrigado por contribuir!** 🎉
