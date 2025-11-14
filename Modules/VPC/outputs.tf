output "vpc_id" {
  description = "ID del VPC"
  value       = aws_vpc.vpc-e-commerce.id
}

output "public_subnet_ids" {
  description = "ID de la subred pública"
  value       = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  description = "Lista de IDs de las subredes privadas"
  value       = aws_subnet.private_subnet[*].id
}