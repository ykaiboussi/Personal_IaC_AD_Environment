output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr_block" {
  value = aws_vpc.main.cidr_block
}

output "subnet_one" {
  value = aws_subnet.sub1.tags["Name"]
}

output "subnet_two" {
  value = aws_subnet.sub2.tags["Name"]
}
