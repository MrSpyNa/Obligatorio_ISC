resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "e-commerce-db-subnet-group"
  subnet_ids = var.private_subnet_rds_ids # RDS debe ir en subredes privadas
  tags = {
    Name = "e-commerce-db-subnet-group"
  }
}

resource "aws_security_group" "e-commerce_db_sg" {
  name   = "e-commerce-db-sg"
  vpc_id = var.vpc_id

  # Entrada: Solo permite tráfico de MySQL (3306) proveniente del SG de las instancias
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [var.asg_sg_id]
    description     = "Acceso MySQL solo desde el Frontend ASG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_db_instance" "e-commerce_db" {
  identifier           = "e-commerce-db-instance"
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7.44-rds.20250818" # Se requiere una version 5.7.x
  instance_class       = "db.t3.micro"
  db_name              = "ecommerce"
  username             = "db_user"
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.e-commerce_db_sg.id]
  skip_final_snapshot  = true
  # Configuración para alta disponibilidad (Tolerancia a Fallas)

  multi_az             = false # Esta conf en TRUE seria la ideal para la tolerancia a fallos
  publicly_accessible  = false

  tags = {
    Name = "e-commerce-DB"
  }
} 
