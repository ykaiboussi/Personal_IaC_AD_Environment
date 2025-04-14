# Personal IaC Cloud Active Directory Environment

The POC implements Managed Microsoft Active Directory in the `us-east-1` region, utilizing a ec2 launch template to deploy instances which they join the custom domain via AWS Systems State Manager.

## Tools
Terragrunt `v0.73.8`

OpenTofu `v1.9.0` 