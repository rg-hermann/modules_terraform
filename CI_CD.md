# CI/CD Pipeline

## Overview
Automated validation, linting, security scanning, and dependency management.

## Workflows

### 1. **terraform-ci.yml** (Main Pipeline)
Runs on every PR and push to main/master.

**Jobs:**
- `terraform` - Validates, lints, and plans all modules
  - Terraform init (backend=false)
  - Format check (`terraform fmt -check`)
  - Validate all modules in parallel
  - TFLint analysis
  - tfsec security scan
  - Terraform plan (PR only)
  
- `security` - Strict tfsec checks (MEDIUM+ severity)
  
- `trivy` - IaC vulnerability scanning
  - SARIF output to GitHub Security tab
  - Comments on PR with summary
  
- `check-status` - Aggregates all checks

**Outputs:** Comments on PR with plan summary, Trivy findings, and validation status.

---

### 2. **module-validate.yml** (Parallel Module Validation)
Runs only when `modules/` paths change.

**Jobs:**
- `discover` - Dynamically finds all modules
- `validate` (parallel) - Validates each module independently
  - `terraform init -backend=false`
  - `terraform validate`
  - `terraform fmt -check`

**Benefit:** Faster feedback (parallel validation).

---

### 3. **dependabot-auto-merge.yml** (Auto-Merge Dependencies)
Automatically merges Dependabot PRs for patch/minor updates.

**Rules:**
- ✅ Auto-merge patch updates
- ✅ Auto-merge minor updates
- ⚠️ Comments on major updates (manual review required)

---

### 4. **cost-estimate.yml** (Cost Awareness)
Comments on PRs mentioning this is a module library with variable costs.

---

## Dependabot Configuration

**Updates:**
1. **GitHub Actions** - Monthly
   - Groups minor/patch updates
   - Open PR limit: 5
   
2. **Terraform Providers** - Weekly
   - Auto-merge patch/minor
   - Open PR limit: 3

---

## Features

✅ **All modules validated in parallel** (fast feedback)  
✅ **Terraform format checking** across all modules  
✅ **TFLint linting** for best practices  
✅ **tfsec security scan** (MEDIUM+ severity blocks merge)  
✅ **Trivy IaC scanning** with SARIF upload  
✅ **Dependabot** for automated dependency updates  
✅ **Auto-merge** for safe dependency updates  
✅ **PR comments** with validation status and findings  
✅ **Branch protection** ready (requires `check-status` to pass)  

---

## GitHub Copilot (Optional)

Copilot code review is commented out in `terraform-ci.yml`.
To enable (requires org/enterprise license):
```yaml
  # Uncomment copilot-review job in terraform-ci.yml
```

---

## Minimum Token Usage

This CI/CD setup is **optimized for token efficiency**:
- Reuses caches (Terraform plugins, TFLint plugins, Trivy cache)
- Parallel module validation reduces overall time
- Minimal GitHub API calls via smart grouping
- Dependabot auto-merge reduces manual PRs
- Skip unnecessary steps (soft-fail where appropriate)

---

## Next Steps

1. **Branch Protection Rule** (GitHub UI):
   - Require `check-status` to pass
   - Require PR reviews
   - Dismiss stale PR approvals

2. **Test the Workflows** by:
   - Creating a test PR in one of the feature branches
   - Watch the workflows run
   - Verify comments appear on PR

3. **Merge Feature Branches** when ready
