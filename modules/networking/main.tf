resource "aws_vpc" "this" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = { Name = "ThreeTier-VPC" }
}

resource "aws_subnet" "web_public_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.web_public_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = true

  tags = { Name = "Web-Public-A" }
}

resource "aws_subnet" "web_public_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.web_public_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = true

  tags = { Name = "Web-Public-B" }
}

resource "aws_subnet" "app_private_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.app_private_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false

  tags = { Name = "App-Private-A" }
}

resource "aws_subnet" "app_private_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.app_private_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = { Name = "App-Private-B" }
}

resource "aws_subnet" "db_private_a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.db_private_a_cidr
  availability_zone       = var.az_a
  map_public_ip_on_launch = false

  tags = { Name = "DB-Private-A" }
}

resource "aws_subnet" "db_private_b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.db_private_b_cidr
  availability_zone       = var.az_b
  map_public_ip_on_launch = false

  tags = { Name = "DB-Private-B" }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = { Name = "ThreeTier-IGW" }
}

resource "aws_eip" "nat_a" {
  domain = "vpc"
}

resource "aws_eip" "nat_b" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat_a.id
  subnet_id     = aws_subnet.web_public_a.id

  tags = { Name = "ThreeTier-NATGW" }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = { Name = "Public-RT" }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = { Name = "Private-RT" }
}

resource "aws_route_table_association" "web_public_a" {
  subnet_id      = aws_subnet.web_public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "web_public_b" {
  subnet_id      = aws_subnet.web_public_b.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "app_private_a" {
  subnet_id      = aws_subnet.app_private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "app_private_b" {
  subnet_id      = aws_subnet.app_private_b.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_private_a" {
  subnet_id      = aws_subnet.db_private_a.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "db_private_b" {
  subnet_id      = aws_subnet.db_private_b.id
  route_table_id = aws_route_table.private.id
}
