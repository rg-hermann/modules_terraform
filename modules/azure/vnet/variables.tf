variable "name" {
  description = "Virtual network name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "address_space" {
  description = "Address space for VNet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnets" {
  description = "List of subnets"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))
  default = [
    {
      name             = "default"
      address_prefixes = ["10.0.1.0/24"]
    }
  ]
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}
