// admin secret 
resource "random_string" "rand_admin" {
  length = 20
  special = false
  override_special = "/@£$?"
}

resource "aws_secretsmanager_secret" "admin" {
  name = "MadAdminSecret"
  description = "Admin Password for AWS Managed Microsoft AD "
}

resource "aws_secretsmanager_secret_version" "pwd_admin" {
  secret_id     = aws_secretsmanager_secret.admin.id
  secret_string = random_string.rand_admin.result
}