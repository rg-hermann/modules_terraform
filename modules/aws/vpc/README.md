# AWS VPC Module

Creates a simple VPC with public subnets, internet gateway and route table.

Inputs
- `cidr_block` (string) - VPC CIDR
- `public_subnets` (list) - list of public subnet CIDRs
- `availability_zones` (list) - AZs for subnets
- `tags` (map) - tags

Outputs
- `vpc_id`
- `public_subnet_ids`
# Test workflow re-trigger
