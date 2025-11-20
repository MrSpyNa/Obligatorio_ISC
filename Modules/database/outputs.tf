output "db_endpoint" {
  description = "e-commerce-RDS"
  value       = aws_db_instance.e-commerce_db.address
}

output "db_sg_id" {
  description = "e-commerce-sg-RDS"
  value       = aws_security_group.e-commerce_db_sg.id
}