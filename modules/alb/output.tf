output "target_arn" {
  description = "Arn of the target group"
  value       = aws_lb_target_group.lb_tg.arn
}

output "target_group_name" {
  description = "Name of the target group"
  value       = aws_lb_target_group.lb_tg.name
}

output "lb_name" {
  description = "Name of the load balancer"
  value       = aws_lb.load_balancer.name
}

output "load_balancer_arn" {
  description = "Arn of the load balancer"
  value       = aws_lb.load_balancer.arn
}