resource "aws_security_group" "alb_sg" {
  name   = "e-commerce-alb-sg"
  vpc_id = var.vpc_id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir HTTP desde Internet"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.2.0/24", "10.0.3.0/24"]
  }
}

resource "aws_lb" "e-commerce_alb" {
  name               = "e-commerce-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.public_subnet_id
  tags = {
    Name = "e-commerce-alb"
  }
}
resource "aws_lb_target_group" "e-commerce_tg" {
  name     = "e-commerce-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

 # health_check {
    #path                = "/" # Usa la ruta raíz o un endpoint específico de tu app
    #port                = "traffic-port"
    #protocol            = "HTTP"
    #interval            = 30
    #timeout             = 5
    #healthy_threshold   = 2
    #unhealthy_threshold = 2
  #}
  tags = {
    Name = "e-commerce-tg"
  }
}

resource "aws_lb_listener" "e-commmerce_listener" {
  load_balancer_arn = aws_lb.e-commerce_alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.e-commerce_tg.arn
  }
}