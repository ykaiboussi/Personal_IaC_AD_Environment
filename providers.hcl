locals {
  region_var = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  account_var = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
    terraform {
      required_providers {
        aws = {
          source  = "hashicorp/aws"
          version = "~> 5.0"
        }
      }
      backend "local" {
        path = "dev/terraform.tfstate"
      }
    }
    provider "aws" {
      region = "${local.region_var.locals.region_name}"
      profile = "dev-mfa"
    }
  EOF
}