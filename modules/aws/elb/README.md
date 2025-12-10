# AWS ELB (Elastic Load Balancer) Module

ALB/NLB with target group and listener.

## Inputs
- `name` - LB name
- `subnets` - Subnet IDs
- `vpc_id` - VPC ID
- `target_group_name` - Target group name
- `type` - ALB or NLB (default: application)
- `protocol` - HTTP/TCP (default: HTTP)
- `tags`

## Outputs
- `lb_arn`
- `lb_dns_name`
- `target_group_arn`
