variable "account_number" {
  type = string
}
variable "instance_code" {
  type = string
}

variable "env_code" {
  type = string
}

variable "domain_name" {
  type = string
}

variable "domain_id" {
  type = string
}

variable "domain_dns_ip_addresses" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_id" {
  type = string
}

# variable "personal_ip" {
#   type = string
# }