output "domain_name" {
  value = aws_directory_service_directory.ad.name
}

output "domain_id" {
  value = aws_directory_service_directory.ad.id
}

output "MadDcIP01" {
  value = local.ad_adds[0]
}

output "MadDcIP02" {
  value = local.ad_adds[1]
}

output "domain_dns_ips" {
  value = local.ad_adds
}
