# AWS EC2 Instance Module

This module creates an EC2 instance with customizable configuration.

## Usage

```hcl
module "ec2" {
  source = "./modules/aws/ec2"

  instance_name       = "my-instance"
  ami_id              = "ami-12345678"
  instance_type       = "t2.micro"
  subnet_id           = module.vpc.public_subnet_ids[0]
  security_groups     = [module.security_group.security_group_id]
  key_name            = "my-key"
  associate_public_ip = true

  root_block_device = {
    volume_size = 20
    volume_type = "gp3"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y httpd
    systemctl start httpd
    systemctl enable httpd
    echo "<h1>Hello World</h1>" > /var/www/html/index.html
  EOF

  tags = {
    Environment = "dev"
    Project     = "demo"
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| instance_name | Name of the EC2 instance | `string` | n/a | yes |
| ami_id | AMI ID for the instance | `string` | n/a | yes |
| instance_type | Instance type | `string` | `"t2.micro"` | no |
| subnet_id | Subnet ID | `string` | n/a | yes |
| security_groups | List of security group IDs | `list(string)` | `[]` | no |
| key_name | SSH key pair name | `string` | `null` | no |
| associate_public_ip | Associate public IP | `bool` | `false` | no |
| user_data | User data script | `string` | `null` | no |
| root_block_device | Root block device config | `object` | `{}` | no |
| tags | Tags for the instance | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance_id | ID of the EC2 instance |
| instance_arn | ARN of the EC2 instance |
| instance_public_ip | Public IP address |
| instance_private_ip | Private IP address |
| instance_public_dns | Public DNS name |