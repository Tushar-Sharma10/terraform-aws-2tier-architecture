data "aws_ami" "ubuntu_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "Ec2-key"
  public_key = file(var.public_key_path)
}

resource "aws_launch_template" "launch_template" {
  name                   = "${var.project_name}-lt"
  description            = var.description
  instance_type          = var.instance_type
  key_name               = aws_key_pair.ec2_key.key_name
  ebs_optimized          = true
  image_id               = data.aws_ami.ubuntu_ami.id
  user_data              = var.user_data != null ? filebase64(var.user_data) : null
  vpc_security_group_ids = var.security_group_ids

  monitoring {
    enabled = var.enabled_monitoring
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project_name}-instance"
      Environment = var.environment
    }
  }

    tag_specifications {
    resource_type = "volume"
    tags = {
      Name        = "${var.project_name}-volume"
      Environment = var.environment
    }
  }

}
