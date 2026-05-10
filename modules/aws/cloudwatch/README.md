# AWS CloudWatch Log Group Module

This module creates a CloudWatch log group for centralized logging.

## Usage

```hcl
module "cloudwatch" {
  source = "./modules/aws/cloudwatch"

  log_group_name     = "/aws/my-app/logs"
  retention_in_days  = 30
  kms_key_id         = module.kms.key_id

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| log_group_name | Name of the log group | `string` | n/a | yes |
| retention_in_days | Retention period in days | `number` | `30` | no |
| kms_key_id | KMS key ID for encryption | `string` | `null` | no |
| tags | Tags for the log group | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| log_group_name | Name of the log group |
| log_group_arn | ARN of the log group |