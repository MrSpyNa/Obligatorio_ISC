output "db_endpoint" {
  description = "e-commerce-RDS"
  value       = aws_db_instance.e-commerce_db.address
}

output "db_sg_id" {
  description = "e-commerce-sg-RDS"
  value       = aws_security_group.e-commerce_db_sg.id
}

output "db_user" {
  description = " Db_User_e-commerce"
  value = aws_db_instance.e-commerce_db.username
}

output "db_password" {
  description = " Db_password_e-commerce"
  value = aws_db_instance.e-commerce_db.password
}

output "db_name" {
  description = " Db_name_e-commerce"
  value = aws_db_instance.e-commerce_db.db_name
}