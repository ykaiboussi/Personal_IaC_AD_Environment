output "ad_password" {
    value = aws_secretsmanager_secret_version.pwd_admin.secret_string
    sensitive = true
}