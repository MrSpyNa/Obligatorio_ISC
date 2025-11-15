output "vpc_id" {
  description = "ID del VPC"
  value       = aws_vpc.vpc-e-commerce.id
}

output "public_subnet_ids" {
  description = "ID de las subredes públicas"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs de las subredes privadas"
  value       = aws_subnet.private_subnet[*].id
}