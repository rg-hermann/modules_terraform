# Módulo Terraform: Azure VNet

Este módulo cria uma Virtual Network no Azure com:
- 1 subnet pública (com rota para internet)
- 1 subnet privada
- Network Security Groups para cada subnet
- Route Table para a subnet pública

## Variáveis principais
- `vnet_name`
- `vnet_address_space`
- `location`
- `resource_group_name`
- `public_subnet_name`
- `public_subnet_prefix`
- `private_subnet_name`
- `private_subnet_prefix`

## Outputs
- `vnet_id`
- `public_subnet_id`
- `private_subnet_id`

## Exemplo de uso
```hcl
module "vnet" {
  source                = "./modules/vnet"
  vnet_name             = "my-vnet"
  vnet_address_space    = ["10.0.0.0/16"]
  location              = "eastus"
  resource_group_name   = "my-rg"
  public_subnet_name    = "public-subnet"
  public_subnet_prefix  = ["10.0.1.0/24"]
  private_subnet_name   = "private-subnet"
  private_subnet_prefix = ["10.0.2.0/24"]
}
```
