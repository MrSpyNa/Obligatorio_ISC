output "asg_sg_id" {
  description = "ID del Security Group del ASG"
  value       = aws_security_group.asg_sg.id
}