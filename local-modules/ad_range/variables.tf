variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "domain_password" {
  type      = string
  sensitive = true
}

variable "subnet_one" {
  type = string
}

variable "subnet_two" {
  type = string
}
