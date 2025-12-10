variable "bucket" {
  description = "S3 bucket name"
  type        = string
}

variable "acl" {
  description = "ACL for the bucket"
  type        = string
  default     = "private"
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Allow bucket deletion with objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default     = {}
}
# Updated 1765335462
