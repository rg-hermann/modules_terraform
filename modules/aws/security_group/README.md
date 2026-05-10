# AWS Security Group Module

This module creates a security group with customizable ingress and egress rules.

## Usage

```hcl
module "security_group" {
  source = "./modules/aws/security_group"

  name        = "my-sg"
  description = "Security group for web servers"
  vpc_id      = module.vpc.vpc_id

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| name | Name of the security group | `string` | n/a | yes |
| description | Description of the security group | `string` | `""` | no |
| vpc_id | ID of the VPC | `string` | n/a | yes |
| ingress_rules | List of ingress rules | `list(object)` | `[]` | no |
| egress_rules | List of egress rules | `list(object)` | `[]` | no |
| tags | Tags for the security group | `map(string)` | `{}` | no |

## Rule Object Structure

Each rule in `ingress_rules` and `egress_rules` should have:
- `from_port`: Start port
- `to_port`: End port
- `protocol`: Protocol (tcp, udp, icmp, -1)
- `cidr_blocks`: List of CIDR blocks (optional)
- `self`: Allow traffic from self (optional, default false)

## Outputs

| Name | Description |
|------|-------------|
| security_group_id | ID of the security group |
| security_group_arn | ARN of the security group |
| security_group_name | Name of the security group |