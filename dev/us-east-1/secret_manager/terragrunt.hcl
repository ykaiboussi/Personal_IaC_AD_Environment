include "providers" {
  path = find_in_parent_folders("providers.hcl")
}

terraform {
  source = "../../../local-modules/secret_manager"
}