variable "vpc_id" {
  description = "ID de la VPC, obtenido del módulo network"
  type        = string
}

variable "private_subnet_ids" {
  description = "Lista de IDs de subredes privadas para el RDS Subnet Group"
  type        = list(string)
}

variable "asg_sg_id"{
  description = "Id del sg del asg"
  type = string

}

variable "db_password" {
  description = "value"
  type = string
}
// ¡ADVERTENCIA! No es seguro dejar contraseñas en código duro. 
// Usar Secret Manager o variables de entorno para producción.
//variable "db_password" {
  //description = "Contraseña maestra de la base de datos"
  
  //type        = string
  //sensitive   = true # Marca esta variable como sensible
//}