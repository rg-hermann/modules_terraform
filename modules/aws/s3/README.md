# AWS S3 Module

Simple, secure S3 bucket module.

Inputs
- `bucket` (string) - bucket name (required)
- `acl` (string) - default `private`
- `versioning` (bool) - default `true`
- `force_destroy` (bool) - default `false`
- `tags` (map) - optional tags

Outputs
- `bucket_id` - bucket id
- `bucket_arn` - bucket arn

Example
```
module "s3" {
  source = "../modules/aws/s3"
  bucket = "my-app-bucket"
}
```
