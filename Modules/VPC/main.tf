resource "aws_vpc" "vpc-e-commerce" {
    cidr_block           = "10.0.0.0/16"
      tags = {
    Name = "vpc-e-commerce"
    }
  
}

resource "aws_internet_gateway" "Geteway" { 
  vpc_id = aws_vpc.vpc-e-commerce.id

  tags = {
    Name = "Gateway"
  }
}

resource "aws_subnet" "public_subnet" { #Subnet para el balanceador 
    vpc_id = aws_vpc.vpc-e-commerce.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "us-east-1a"

  tags = {
    Name = "subnet-publica"
  }
  
}