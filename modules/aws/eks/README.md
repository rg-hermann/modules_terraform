# AWS EKS Module

EKS cluster with optional node group.

## Inputs
- `cluster_name` - Cluster name
- `cluster_role_arn` - IAM role ARN for cluster
- `subnet_ids` - Subnet IDs
- `node_role_arn` - IAM role ARN for nodes
- `kubernetes_version` - K8s version
- `create_node_group` - Create default node group
- `desired_size`, `min_size`, `max_size`, `instance_types`
- `tags`

## Outputs
- `cluster_name`
- `cluster_arn`
- `cluster_endpoint`
- `cluster_ca_certificate`
