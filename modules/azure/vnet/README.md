# Azure VNet Module

Virtual network with subnets and NSG.

## Inputs
- `name` - VNet name
- `resource_group_name`
- `location`
- `address_space` - CIDR blocks
- `subnets` - List of subnets with name and address_prefixes
- `tags`

## Outputs
- `vnet_id`
- `subnet_ids`
- `nsg_id`
