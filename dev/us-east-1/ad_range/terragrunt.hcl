include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

dependency "vpc" {
  config_path = "../vpc"
}

dependency "secret_manager" {
  config_path = "../secret_manager"
}

terraform {
  source = "../../../local-modules/ad_range"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
  vpc_cidr_block = dependency.vpc.outputs.vpc_cidr_block
  domain_password = dependency.secret_manager.outputs.ad_password
  subnet_one = dependency.vpc.outputs.subnet_one
  subnet_two = dependency.vpc.outputs.subnet_two
}
