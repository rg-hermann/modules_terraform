# AWS IAM Role Module

Creates an IAM role with optional inline policy.

Inputs
- `name` (string) - role name
- `assume_role_policy` (string) - JSON assume policy
- `inline_policy` (string) - optional inline policy JSON
- `tags` (map)

Outputs
- `role_id`
- `role_arn`
