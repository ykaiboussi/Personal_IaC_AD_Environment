# Create IAM roles
resource "aws_iam_role" "srv" {
  name        = format("%s-%s-%s-%s", var.instance_code, "iar", var.env_code, "srv")
  description = "IAM role for MS Server to access S3 hosted files"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    name         = format("%s-%s-%s-%s", var.instance_code, "iar", var.env_code, "srv")
    resourcetype = "identity"
  }
}

resource "aws_iam_role_policy" "srvs3" {
  name = format("%s-%s-%s-%s", var.instance_code, "irp", var.env_code, "srvs3")
  role = aws_iam_role.srv.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_s3_bucket.srv.arn}",
          "${aws_s3_bucket.srv.arn}/*",
        ]
        Condition = {
          "StringEquals" = {
            "aws:PrincipalAccount" = var.account_number
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "srvs3ec2describe" {
  name = format("%s-%s-%s-%s", var.instance_code, "irp", var.env_code, "srvs3ec2describe")
  role = aws_iam_role.srv.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          "StringEquals" = {
            "aws:PrincipalAccount" = var.account_number
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "srvs3secrets" {
  name = format("%s-%s-%s-%s", var.instance_code, "irp", var.env_code, "srvs3secrets")
  role = aws_iam_role.srv.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:::secret:/${var.instance_code}*"
        Condition = {
          "StringEquals" = {
            "aws:PrincipalAccount" = var.account_number
          }
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "srvssm" {
  role       = aws_iam_role.srv.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "srvmmad" {
  role       = aws_iam_role.srv.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

resource "aws_iam_instance_profile" "srv" {
  name = format("%s-%s-%s-%s", var.instance_code, "ip", var.env_code, "srv")
  role = aws_iam_role.srv.name

  tags = {
    Name         = format("%s-%s-%s-%s", var.instance_code, "ip", var.env_code, "srv")
    resourcetype = "identity"
  }
}
