# CREATE VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name        = var.project_name
    Environment = var.environment
  }
}

# PUBLIC SUBNET
resource "aws_subnet" "publicsubnet" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_cidr[count.index]
  availability_zone       = var.availability_zone[count.index % length(var.availability_zone)]
  map_public_ip_on_launch = true
  tags = {
    Name        = "${var.project_name}-public-${count.index + 1}"
    Environment = var.environment
  }
}

# PRIVATE SUBNET
resource "aws_subnet" "privatesubnet" {
  count                   = length(var.private_cidr)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_cidr[count.index]
  availability_zone       = var.availability_zone[count.index % length(var.availability_zone)]
  map_public_ip_on_launch = false
  tags = {
    Name        = "${var.project_name}-private-${count.index + 1}"
    Environment = var.environment
  }
}

# INTERNET GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Internet_gateway-${var.project_name}"
  }
}

# ELASTIC IP FOR NAT GATEWAY
resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.project_name}-eip"
  }
}

# NAT GATEWAY
resource "aws_nat_gateway" "natgw" {
  subnet_id         = aws_subnet.publicsubnet[0].id
  allocation_id     = aws_eip.nat_eip.id
  connectivity_type = "public"
  depends_on        = [aws_eip.nat_eip]
  tags = {
    Name = "${var.project_name}-ngw"
  }
}

# PUBLIC ROUTE TABLE
resource "aws_route_table" "public_route" {
  vpc_id     = aws_vpc.this.id
  depends_on = [aws_internet_gateway.igw]

  route {
    gateway_id = aws_internet_gateway.igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Public_route_table"
  }
}

# PRIVATE ROUTE TABLE
resource "aws_route_table" "private_route" {
  vpc_id     = aws_vpc.this.id
  depends_on = [aws_nat_gateway.natgw]
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
  tags = {
    "Name" = "Private_route_table"
  }
}

# PULBIC SUBNET ASSOCIATION
resource "aws_route_table_association" "public_association" {
  count          = length(aws_subnet.publicsubnet)
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.publicsubnet[count.index].id
}

# PRIVATE SUBNET ASSOCIATION
resource "aws_route_table_association" "private_association" {
  count          = length(aws_subnet.privatesubnet)
  route_table_id = aws_route_table.private_route.id
  subnet_id      = aws_subnet.privatesubnet[count.index].id
}

