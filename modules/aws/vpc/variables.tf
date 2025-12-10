variable "cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "availability_zones" {
  description = "List of AZs for subnets"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
# Updated 1765335454
