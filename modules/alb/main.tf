# TARGET GROUP 
resource "aws_lb_target_group" "alb_tg" {
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