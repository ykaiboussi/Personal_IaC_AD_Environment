data "aws_subnet" "sub1" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_one]
  }
}

data "aws_subnets" "all" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_one, var.subnet_two]
  }
}

data "aws_subnet" "s" {
  for_each = toset(data.aws_subnets.all.ids)
  id       = each.value
}