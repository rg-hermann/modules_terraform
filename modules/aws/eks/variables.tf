variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_arn" {
  description = "IAM role ARN for EKS cluster"
  type        = string
}

variable "kubernetes_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.27"
}

variable "subnet_ids" {
  description = "Subnet IDs for cluster"
  type        = list(string)
}

variable "endpoint_private_access" {
  description = "Enable private API endpoint"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public API endpoint"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs allowed for public API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "create_node_group" {
  description = "Create default node group"
  type        = bool
  default     = true
}

variable "node_group_name" {
  description = "Node group name"
  type        = string
  default     = "default"
}

variable "node_role_arn" {
  description = "IAM role ARN for nodes"
  type        = string
  default     = ""
}

variable "desired_size" {
  description = "Desired node group size"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum node group size"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum node group size"
  type        = number
  default     = 5
}

variable "instance_types" {
  description = "EC2 instance types for nodes"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
