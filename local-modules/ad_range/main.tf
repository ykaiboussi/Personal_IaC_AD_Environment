resource "aws_directory_service_directory" "ad" {
  name     = "ad_range.corp.com"
  password = var.domain_password
  short_name = "corp"
  edition  = "Standard"
  type     = "MicrosoftAD"

  vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = local.subnet_ids
  }
}

# Set VPC DHCP options for domain members
resource "aws_vpc_dhcp_options" "mmad01" {
  domain_name         = aws_directory_service_directory.ad.name
  domain_name_servers = local.ad_adds
}

resource "aws_vpc_dhcp_options_association" "mmad01" {
  vpc_id          = var.vpc_id
  dhcp_options_id = aws_vpc_dhcp_options.mmad01.id
}
