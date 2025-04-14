locals {
  subnet_ids = [for s in data.aws_subnet.s : s.id]
  ad_adds = tolist(aws_directory_service_directory.ad.dns_ip_addresses)
}