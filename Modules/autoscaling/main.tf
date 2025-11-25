resource "aws_security_group" "asg_sg" {
  name   = "e-commerce-asg-sg"
  vpc_id = var.vpc_id

  # Entrada: Solo permite tráfico en el puerto 80 (App) desde el ALB.
  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    # Referencia al SG del ALB para una restricción precisa
    security_groups = [var.alb_security_group_id]
    description     = "Trafico solo desde el Load Balancer"
  }
ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # CAMBIAR A TU IP PÚBLICA / IP DE BASTION
    description = "SSH solo para administracion"
  }

  # Salida: Permite a las instancias acceder a la DB (si está en la VPC) y a Internet (logs/updates).
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_launch_template" "e-commerce_lt" {
  name_prefix   = "e-commerce-lt"
  image_id      = "ami-0c2b8ca1dad447f8a"
  instance_type = "t3.micro"
  key_name      = "vockey"
  # Script para la instalación de la aplicación
  user_data     = base64encode(
    format(
      "%s %s %s %s %s %s",
      file("${path.module}/e-commerce-install.sh"), 
      var.db_endpoint,
      var.db_user,
      var.db_password,
      var.db_database,
      var.git_token
  )
  )
  vpc_security_group_ids = [aws_security_group.asg_sg.id]
  tags = {
    Name = "e-commerce_Ec2"
  }
}

resource "aws_autoscaling_group" "e-commerce_asg" {
  name                = "e-commerce-asg"
  desired_capacity    = 2 
  max_size            = 6
  min_size            = 2
  # Implementa la tolerancia a fallas al usar subredes en múltiples AZs 
  vpc_zone_identifier = var.public_subnet_ids #cambiar nuevamente a privada, mera razon de testeo
  # Conexión al Target Group del Load Balancer
  target_group_arns   = [var.target_group_arn]

  launch_template {
    id      = aws_launch_template.e-commerce_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "e-commerce-Server"
    propagate_at_launch = true
  }
}
resource "aws_autoscaling_policy" "e-commerce-target_tracking" {
  name                   = "e-commerce-cpu-target"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.e-commerce_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 80  # si sube CPU, escala; si baja, reduce
  }
      
}