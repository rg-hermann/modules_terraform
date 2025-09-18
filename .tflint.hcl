plugin "azurerm" {
  enabled = true
  version = "~> 0.34.0"
  source  = "github.com/terraform-linters/tflint-ruleset-azurerm"
}

config {
  call_module_type = true
}

rule "terraform_required_providers" { enabled = true }
rule "terraform_standard_module_structure" { enabled = true }
