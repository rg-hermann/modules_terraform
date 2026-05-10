# AWS RDS Module

This module creates an RDS database instance with optional subnet group and security groups.

## Usage

```hcl
module "rds" {
  source = "./modules/aws/rds"

  identifier         = "my-database"
  engine             = "postgres"
  engine_version     = "13.7"
  instance_class     = "db.t3.micro"
  allocated_storage  = 20
  username           = "admin"
  password           = "ChangeMe123!"
  db_name            = "mydb"
  subnet_ids         = module.vpc.private_subnet_ids
  security_groups    = [module.security_group.security_group_id]
  publicly_accessible = false
  multi_az           = false
  backup_retention_period = 7

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| identifier | DB instance identifier | `string` | n/a | yes |
| engine | Database engine | `string` | n/a | yes |
| engine_version | Engine version | `string` | n/a | yes |
| instance_class | Instance class | `string` | n/a | yes |
| allocated_storage | Storage in GB | `number` | n/a | yes |
| username | Master username | `string` | n/a | yes |
| password | Master password | `string` | n/a | yes |
| db_name | Database name | `string` | n/a | yes |
| subnet_ids | Subnet IDs for subnet group | `list(string)` | `[]` | no |
| security_groups | Security group IDs | `list(string)` | `[]` | no |
| publicly_accessible | Public accessibility | `bool` | `false` | no |
| multi_az | Multi-AZ deployment | `bool` | `false` | no |
| backup_retention_period | Backup retention days | `number` | `7` | no |
| tags | Tags for resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| db_instance_id | DB instance identifier |
| db_instance_arn | DB instance ARN |
| endpoint | DB endpoint |
| port | DB port |
| db_name | Database name |
| username | Master username |