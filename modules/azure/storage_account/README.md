# Azure Storage Account Module

Minimal Azure Storage Account module.

Inputs
- `name` (string) - storage account name (required)
- `resource_group_name` (string) - required
- `location` (string) - required
- `account_tier` (string) - default `Standard`
- `account_replication_type` (string) - default `LRS`
- `access_tier` (string) - default `Hot`
- `allow_blob_public_access` (bool) - default `false`

Outputs
- `storage_account_id`
- `primary_blob_endpoint`

Example
```
module "sa" {
  source = "../modules/azure/storage_account"
  name   = "examplestorage01"
}
```
