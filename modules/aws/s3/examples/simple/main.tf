provider "aws" {
  region = "us-east-1"
}

module "bucket" {
  source = ".."
  bucket = "example-bucket-terraform-module"
}
