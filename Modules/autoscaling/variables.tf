variable "vpc_id" {
  description = "ID del VPC (vbc)"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs de las subredes privadas (vpc)"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN del Target Group (lb)"
  type        = string
}

variable "alb_security_group_id" {
  description = "ID del Security Group del ALB (lb)"
  type        = string
}

variable "public_subnet_ids" {
  type = list(string)
  
}

variable "db_endpoint" {
  type        = string
}

variable "db_password" {
  type        = string
}

variable "db_database" {
  type        = string
}

variable "db_user" {
  type        = string
}

variable "git_token" {
  type = string
}
