# AWS S3 Bucket Module

This module creates an S3 bucket with optional versioning, encryption, and public access blocking.

## Usage

```hcl
module "s3_bucket" {
  source = "./modules/aws/s3"

  bucket_name   = "my-bucket"
  versioning    = true
  encryption    = true
  public_access = true

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| bucket_name | Name of the S3 bucket | `string` | n/a | yes |
| versioning | Enable versioning on the bucket | `bool` | `false` | no |
| encryption | Enable server-side encryption | `bool` | `true` | no |
| public_access | Block all public access | `bool` | `true` | no |
| tags | Tags for the bucket | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket_name | Name of the S3 bucket |
| bucket_arn | ARN of the S3 bucket |
| bucket_id | ID of the S3 bucket |