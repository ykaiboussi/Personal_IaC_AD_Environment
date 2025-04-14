resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "gw" {}

resource "aws_internet_gateway_attachment" "name" {
  internet_gateway_id = aws_internet_gateway.gw.id
  vpc_id              = aws_vpc.main.id
}

resource "aws_subnet" "sub1" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1a"
  cidr_block              = "10.0.0.0/26"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_one
  }
}

resource "aws_route_table" "rsb1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.subnet_one
  }
}

resource "aws_route_table_association" "rsb_ass_sb1" {
  route_table_id = aws_route_table.rsb1.id
  subnet_id      = aws_subnet.sub1.id
}

resource "aws_subnet" "sub2" {
  vpc_id                  = aws_vpc.main.id
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.0.64/26"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_two
  }
}

resource "aws_route_table" "rsb2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.subnet_two
  }
}

resource "aws_route_table_association" "rsb_ass_sb2" {
  route_table_id = aws_route_table.rsb1.id
  subnet_id      = aws_subnet.sub2.id
}
