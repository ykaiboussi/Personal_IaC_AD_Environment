include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

locals {
  account_var = read_terragrunt_config(find_in_parent_folders("account.hcl"))
}


dependency "managed_ad" {
  config_path = "../ad_range"
}

dependency "vpc" {
  config_path = "../vpc"
}


terraform {
  source = "../../../local-modules/ec2_launch_template"
}

inputs = {
  instance_code = "demo"
  env_code = "01"
  domain_name = dependency.managed_ad.outputs.domain_name
  domain_id = dependency.managed_ad.outputs.domain_id
  domain_dns_ip_addresses = dependency.managed_ad.outputs.domain_dns_ips
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_cidr_block = dependency.vpc.outputs.vpc_cidr_block
  subnet_id = dependency.vpc.outputs.subnet_one
  account_number = local.account_var.locals.account_number
}
