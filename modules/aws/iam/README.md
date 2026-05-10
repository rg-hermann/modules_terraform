# AWS IAM Role Module

This module creates an IAM role with managed and inline policies.

## Usage

```hcl
module "iam_role" {
  source = "./modules/aws/iam"

  role_name = "my-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]

  inline_policies = {
    "s3-access" = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["s3:GetObject", "s3:PutObject"]
          Effect   = "Allow"
          Resource = ["arn:aws:s3:::my-bucket/*"]
        }
      ]
    })
  }

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| role_name | Name of the IAM role | `string` | n/a | yes |
| assume_role_policy | Assume role policy document | `string` | n/a | yes |
| managed_policy_arns | List of managed policy ARNs | `list(string)` | `[]` | no |
| inline_policies | Map of inline policies | `map(string)` | `{}` | no |
| tags | Tags for the role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| role_name | Name of the IAM role |
| role_arn | ARN of the IAM role |
| role_id | ID of the IAM role |