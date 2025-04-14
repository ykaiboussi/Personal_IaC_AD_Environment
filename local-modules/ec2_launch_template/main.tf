# IAM policy configuration
resource "aws_iam_role_policy_attachment" "ssm-mmad" {
  role       = aws_iam_role.srv.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess"
}

# AMI IDs for use with Amazon EC2
data "aws_ami" "windows2022" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

# LaunchTemplate
resource "aws_launch_template" "srv" {
  name                   = format("%s-%s-%s-%s", var.instance_code, "ltp", var.env_code, "srv01")
  description            = "Windows Server"
  image_id               = data.aws_ami.windows2022.image_id
  instance_type          = "t3.medium"
  key_name               = aws_key_pair.ec2_keypair_01.key_name
  ebs_optimized          = true

  user_data = base64encode(templatefile("user_data.ps1",
    {
      S3Bucket = "s3://${aws_s3_bucket.srv.bucket}/serverfiles/"
    }
    )
  )

  metadata_options {
    http_tokens = "required"
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      delete_on_termination = true
      volume_size           = 50
      volume_type           = "gp3"
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.srv.id
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    security_groups = [aws_security_group.domain_member_sg.id]
    subnet_id = var.subnet_id
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name         = format("%s-%s-%s-%s", var.instance_code, "ec2", var.env_code, "srvasg")
      domainjoin   = "mmad"
      resourcetype = "compute"
    }
  }
}