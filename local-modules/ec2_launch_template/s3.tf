resource "aws_s3_bucket" "srv" {
  bucket_prefix = format("%s%s%s%s", var.instance_code, "sss", var.env_code, "srv")
  force_destroy = true

  tags = {
    name         = format("%s%s%s%s", var.instance_code, "sss", var.env_code, "srv"),
    resourcetype = "storage"
  }
}

resource "aws_s3_bucket_public_access_block" "srv" {
  bucket                  = aws_s3_bucket.srv.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.srv.id
  key    = "ec2_user_data"
  source = "user_data.ps1"
}