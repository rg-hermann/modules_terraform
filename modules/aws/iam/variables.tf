variable "role_name" {
  description = "Name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "Assume role policy document"
  type        = string
}

variable "managed_policy_arns" {
  description = "List of managed policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Map of inline policies (name => policy document)"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags for the IAM role"
  type        = map(string)
  default     = {}
}