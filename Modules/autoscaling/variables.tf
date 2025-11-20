variable "vpc_id" {
  description = "ID de la VPC, obtenido del módulo network"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas para el ASG"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN del Target Group (obtenido del módulo loadbalancer)"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del Security Group del ALB (obtenido del módulo loadbalancer)"
  type        = string
}

variable "public_subnet_ids" {
  type = list(string)
  
}
