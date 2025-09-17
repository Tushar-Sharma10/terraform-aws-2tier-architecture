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

## AUTO SCALING GROUP
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.project_name}-asg"
  max_size                  = var.max_size
  min_size                  = var.min_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = var.subnets
  default_cooldown          = var.default_cooldown
  default_instance_warmup   = var.default_instance_warmup
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = var.force_delete
  target_group_arns         = var.target_group_arns

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }
  instance_refresh {
    strategy = var.strategy
    preferences {
      instance_warmup        = var.default_instance_warmup
      max_healthy_percentage = var.max_healthy_percentage
      min_healthy_percentage = var.min_healthy_percentage
      skip_matching          = false
    }
    triggers = ["launch_template"]
  }

  instance_maintenance_policy {
    min_healthy_percentage = var.min_healthy_percentage
    max_healthy_percentage = var.max_healthy_percentage
  }
  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asg_policy" {
  autoscaling_group_name    = aws_autoscaling_group.asg.name
  name                      = "${var.project_name}-policy"
  estimated_instance_warmup = 30
  enabled                   = var.enable_scaling
  policy_type               = var.enable_scaling ? var.policy_type : null

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    disable_scale_in = false
    target_value     = var.target_value
  }
}