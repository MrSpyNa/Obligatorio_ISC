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
resource "aws_subnet" "public_subnet" { #Subnet para el balanceador 
    vpc_id = aws_vpc.vpc-e-commerce.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1a"
  tags = {
    Name = "subnet-publica"
  } 
}

#Creacion subnets privadas.
resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc-e-commerce.id
  cidr_block              = cidrsubnet("10.0.0.0/16", 8, count.index + 2) #cidrsubnet: Funcion para calcular las direcciones de subnet.
  map_public_ip_on_launch = false
  availability_zone       = element(["us-east-1a", "us-east-1b"], count.index) #element: Funcion que devuelve el elemento de una lista segun su indice.
  tags = {
    Name = "subnet-privada-${count.index + 1}"
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
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.RT_ecommerce.id
}