# Windows Domain join SSM setup
resource "aws_ssm_document" "domainjoin" {
  name          = format("%s-%s-%s-%s", var.instance_code, "ssm", var.env_code, "domainjoin")
  document_type = "Command"
  content = jsonencode(
    {
      "schemaVersion" = "2.2"
      "description"   = "Join instances to domain based on tag"
      "mainSteps" = [
        {
          "action" = "aws:domainJoin",
          "name"   = "domainJoin",
          "inputs" = {
            "directoryId"    = var.domain_id,
            "directoryName"  = var.domain_name,
            "dnsIpAddresses" = var.domain_dns_ip_addresses
          }
        }
      ]
    }
  )

  tags = {
    Name         = format("%s-%s-%s-%s", var.instance_code, "ssm", var.env_code, "domainjoin")
    resourcetype = "identity"
  }
}

resource "aws_ssm_association" "domainjoin" {
  name = aws_ssm_document.domainjoin.name
  targets {
    key    = "tag:domainjoin"
    values = ["mmad"]
  }
}