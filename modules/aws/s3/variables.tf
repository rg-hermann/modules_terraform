variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "versioning" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = false
}

variable "encryption" {
  description = "Enable server-side encryption"
  type        = bool
  default     = true
}

variable "public_access" {
  description = "Block all public access"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags for the bucket"
  type        = map(string)
  default     = {}
}