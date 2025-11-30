#Creacion VPC
resource "aws_vpc" "vpc-e-commerce" {
    cidr_block           = "10.0.0.0/16"
      tags = {
    Name = "vpc-e-commerce"
    } 
}

#Creacion gateway.
resource "aws_internet_gateway" "Geteway" { 
  vpc_id = aws_vpc.vpc-e-commerce.id
  tags = {
    Name = "Gateway"
  }
}

#Creacion subnet publica.
resource "aws_subnet" "public_subnet" { #Subnets para el balanceador 
    count = 2 
    vpc_id = aws_vpc.vpc-e-commerce.id
    cidr_block = cidrsubnet("10.0.0.0/16", 8, count.index + 1) #cidrsubnet: Funcion para calcular las direcciones de subnet.
    map_public_ip_on_launch = true
    availability_zone       = element(["us-east-1a", "us-east-1b"], count.index) #element: Funcion que devuelve el elemento de una lista segun su indice.
  tags = {
    Name = "subnet-publica-${count.index + 1}"
  } 
}

#Creacion subnets privadas.
resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc-e-commerce.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + 3) #cidrsubnet: Funcion para calcular las direcciones de subnet.
  map_public_ip_on_launch = false
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index) #element: Funcion que devuelve el elemento de una lista segun su indice.
  tags = {
    Name = "subnet-privada-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet_rds" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc-e-commerce.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + 5) #cidrsubnet: Funcion para calcular las direcciones de subnet.
  map_public_ip_on_launch = false
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index) #element: Funcion que devuelve el elemento de una lista segun su indice.
  tags = {
    Name = "subnet-privada-RDS-${count.index + 1}"
  }
}

#Creacion route table.
resource "aws_route_table" "RT_ecommerce" {
  vpc_id = aws_vpc.vpc-e-commerce.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Geteway.id
  }
}

#Asosiacion route table con subnet publica.
resource "aws_route_table_association" "public" { 
  count          = 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.RT_ecommerce.id
}

# 1. Elastic IP para el NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  tags = {
    Name = "e-commerce-eip"
  }
}

# 2. NAT Gateway
resource "aws_nat_gateway" "main" {
  # Se despliega en la primera subred pública creada
  subnet_id     = aws_subnet.public_subnet[0].id 
  allocation_id = aws_eip.nat_gateway_eip.id 
  tags = {
    Name = "e-commerce-nat-gateway"
  }
}

# Tablas de Rutas Privadas (para cada subred privada)
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.vpc-e-commerce.id
  tags = {
    Name = "e-commerce-private-rt-${count.index}"
  }
}

# Asociaciones (Private Subnet -> Private Route Table)
resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}

# Ruta al NAT Gateway para el tráfico 0.0.0.0/0
resource "aws_route" "private_nat_route" {
  count                    = length(aws_route_table.private)
  route_table_id           = aws_route_table.private[count.index].id
  destination_cidr_block   = "0.0.0.0/0"
  nat_gateway_id           = aws_nat_gateway.main.id
}