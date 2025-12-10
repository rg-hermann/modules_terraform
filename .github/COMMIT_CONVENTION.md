# Commit Convention

Este repositório segue a especificação de **Conventional Commits**.

## Formato

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Types

- **feat**: Nova feature ou módulo
- **fix**: Correção de bug
- **docs**: Alterações em documentação
- **style**: Formatação, semicolons, etc (sem mudança de lógica)
- **refactor**: Refatoração de código (sem mudança de comportamento)
- **perf**: Melhorias de performance
- **test**: Adição ou alteração de testes
- **chore**: Tarefas de build, dependências, tooling
- **ci**: Alterações em CI/CD

## Scope (Opcional)

- `aws-vpc`: Módulo AWS VPC
- `aws-security-group`: Módulo AWS Security Group
- `aws-elb`: Módulo AWS Load Balancer
- `aws-rds`: Módulo AWS RDS
- `aws-s3`: Módulo AWS S3
- `aws-iam-role`: Módulo AWS IAM Role
- `aws-eks`: Módulo AWS EKS
- `azure-vnet`: Módulo Azure VNet
- `azure-storage`: Módulo Azure Storage
- `azure-postgres`: Módulo Azure PostgreSQL
- `azure-managed-identity`: Módulo Azure Managed Identity
- `azure-app-service`: Módulo Azure App Service
- `root`: Arquivos raiz (main.tf, variables.tf, outputs.tf)
- `ci-cd`: Workflows e CI/CD
- `docs`: Documentação geral

## Exemplos

### Feature nova
```
feat(aws-vpc): adiciona suporte a custom DHCP options
```

### Bug fix
```
fix(azure-storage): corrige validação de tier em ambiente sandbox
```

### Documentação
```
docs(aws-rds): adiciona exemplo de snapshot automático
```

### CI/CD
```
ci(terraform-ci): melhora performance de validation cache
```

### Refatoração
```
refactor(root): unifica local tags em main.tf
```

## Subject (Primera linha)

- Use imperativo: "adiciona" em vez de "adicionado" ou "adiciona"
- Não comece com maiúscula
- Não termine com ponto
- Máximo 50 caracteres
- Seja descritivo e conciso

## Body (Opcional)

- Explique o **quê** e o **por quê**, não o **como**
- Separe da linha de subject com linha em branco
- Quebra de linha a cada 72 caracteres
- Use quando a mudança é complexa ou precisa contexto

## Footer (Opcional)

Use para referencias:
```
Closes #123
Fixes #456
Related-to #789
```

## Checklist de Commit

Antes de fazer commit:
- [ ] Tipo está correto?
- [ ] Scope (se usado) está correto?
- [ ] Subject descreve a mudança?
- [ ] Sem maiúscula no início?
- [ ] Sem ponto no final?
- [ ] Máximo 50 caracteres na primeira linha?

## Automação

Este repositório utiliza **Dependabot** e **PR Quality Checks** que automaticamente validam commits.

### GitHub Actions
- Commits em PRs são validados automaticamente
- Labels são aplicadas baseadas em arquivos alterados
- Merges automáticas de dependências são feitas para patch/minor

## Referências

- [Conventional Commits](https://www.conventionalcommits.org/)
- [7 Rules of Great Git Commit Messages](https://cbea.ms/git-commit/)
