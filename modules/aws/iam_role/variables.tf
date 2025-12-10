variable "name" {
  description = "IAM role name"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON assume role policy"
  type        = string
  default     = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": { "Service": "ec2.amazonaws.com" }
    }
  ]
}
EOF
}

variable "inline_policy" {
  description = "Optional inline policy JSON"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags map"
  type        = map(string)
  default     = {}
}
# Updated 1765335458
