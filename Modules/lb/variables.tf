variable "vpc_id" {
  description = "ID del VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "ID de la subred publica"
  type        = list
}