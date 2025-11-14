output "alb_dns_name" {
  description = "DNS del Application Load Balancer"
  value       = aws_lb.e-commerce_alb.dns_name
}

output "target_group_arn" {
  description = "ARN del Target Group "
  value       = aws_lb_target_group.e-commerce_tg.arn
}

output "alb_security_group_id" {
  description = "ID del SG del ALB"
  value       = aws_security_group.alb_sg.id
}