# AWS Security Group Module

Flexible security group with dynamic ingress/egress rules.

## Inputs
- `name` (string) - SG name
- `description` (string) - SG description
- `vpc_id` (string) - VPC ID (required)
- `ingress_rules` (list) - Ingress rules with from_port, to_port, protocol, cidr_blocks
- `egress_rules` (list) - Egress rules (default: allow all)
- `tags` (map)

## Outputs
- `security_group_id`
- `security_group_arn`

## Example
```hcl
module "sg" {
  source = "../modules/aws/security_group"
  name   = "app-sg"
  vpc_id = "vpc-12345"
  ingress_rules = [
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
}
```
