variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_in_days" {
  description = "Log retention period in days (0 = never expire)"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "KMS key ID for log group encryption"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags for the log group"
  type        = map(string)
  default     = {}
}