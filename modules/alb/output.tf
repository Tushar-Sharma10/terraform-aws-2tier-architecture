output "target_arn" {
  description = "Arn of the target group"
  value       = aws_lb_target_group.alb_tg.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.alb_tg.name
}