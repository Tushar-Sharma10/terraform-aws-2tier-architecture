# TARGET GROUP 
resource "aws_lb_target_group" "lb_tg" {
  name             = "${var.project_name}-tg"
  vpc_id           = var.vpc_id
  target_type      = var.target_type
  port             = var.port
  protocol         = var.protocol
  protocol_version = var.protocol_version
  ip_address_type  = var.ip_address_type

  dynamic "health_check" {
    for_each = var.enable_health_check ? [1] : []
    content {
      enabled             = var.enable_health_check
      healthy_threshold   = var.healthy_threshold
      interval            = var.interval
      path                = var.path
      port                = var.port
      protocol            = var.protocol
      timeout             = var.timeout
      unhealthy_threshold = var.unhealthy_threshold
    }
  }

  tags = {
    Name        = "${var.project_name}-tg"
    Environment = var.environment
  }
}


# APPLICATION LOAD BALANCER
resource "aws_lb" "load_balancer" {
  name               = "${var.project_name}-lb"
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  ip_address_type    = var.lb_ip_type
  security_groups    = var.security_group
  subnets            = var.subnets

  dynamic "access_logs" {
    for_each = var.enable_access_logs ? [1] : []
    content {
      bucket  = var.bucket_name
      enabled = var.enable_access_logs
    }
  }

  dynamic "connection_logs" {
    for_each = var.enable_connection_logs ? [1] : []
    content {
      bucket  = var.bucket_name
      enabled = var.enable_connection_logs
    }
  }

  tags = {
    Name        = "${var.project_name}-lb"
    Environment = var.environment
  }
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = var.port
  protocol          = var.protocol

  default_action {
    type             = var.type
    target_group_arn = aws_lb_target_group.lb_tg.arn
  }
}