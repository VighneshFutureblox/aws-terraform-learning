# -------------------------
# VPC 1
# -------------------------
resource "aws_vpc" "vpc1" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-vpc-1"
  }
}

# VPC 1 - Public Subnet
resource "aws_subnet" "vpc1_public_subnet" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "vpc1-public-subnet"
  }
}

# VPC 1 - Private Subnet
resource "aws_subnet" "vpc1_private_subnet" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "vpc1-private-subnet"
  }
}

# VPC 1 - Internet Gateway
resource "aws_internet_gateway" "vpc1_igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-igw"
  }
}

# VPC 1 - Public Route Table
resource "aws_route_table" "vpc1_public_route_table" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc1_igw.id
  }

  tags = {
    Name = "vpc1-public-route-table"
  }
}

# VPC 1 - Private Route Table
resource "aws_route_table" "vpc1_private_route_table" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-private-route-table"
  }
}

# VPC 1 - Public Subnet Association
resource "aws_route_table_association" "vpc1_public_association" {
  subnet_id      = aws_subnet.vpc1_public_subnet.id
  route_table_id = aws_route_table.vpc1_public_route_table.id
}

# VPC 1 - Private Subnet Association
resource "aws_route_table_association" "vpc1_private_association" {
  subnet_id      = aws_subnet.vpc1_private_subnet.id
  route_table_id = aws_route_table.vpc1_private_route_table.id
}

# -------------------------
# VPC 2
# -------------------------
resource "aws_vpc" "vpc2" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-vpc-2"
  }
}

# VPC 2 - Public Subnet
resource "aws_subnet" "vpc2_public_subnet" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "vpc2-public-subnet"
  }
}

# VPC 2 - Private Subnet
resource "aws_subnet" "vpc2_private_subnet" {
  vpc_id     = aws_vpc.vpc2.id
  cidr_block = "10.1.2.0/24"

  tags = {
    Name = "vpc2-private-subnet"
  }
}

# VPC 2 - Internet Gateway
resource "aws_internet_gateway" "vpc2_igw" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "vpc2-igw"
  }
}

# VPC 2 - Public Route Table
resource "aws_route_table" "vpc2_public_route_table" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc2_igw.id
  }

  tags = {
    Name = "vpc2-public-route-table"
  }
}

# VPC 2 - Private Route Table
resource "aws_route_table" "vpc2_private_route_table" {
  vpc_id = aws_vpc.vpc2.id

  tags = {
    Name = "vpc2-private-route-table"
  }
}

# VPC 2 - Public Subnet Association
resource "aws_route_table_association" "vpc2_public_association" {
  subnet_id      = aws_subnet.vpc2_public_subnet.id
  route_table_id = aws_route_table.vpc2_public_route_table.id
}

# VPC 2 - Private Subnet Association
resource "aws_route_table_association" "vpc2_private_association" {
  subnet_id      = aws_subnet.vpc2_private_subnet.id
  route_table_id = aws_route_table.vpc2_private_route_table.id
}

# -------------------------
# Outputs
# -------------------------
output "vpc_ids" {
  description = "IDs of both VPCs"

  value = {
    vpc1 = aws_vpc.vpc1.id
    vpc2 = aws_vpc.vpc2.id
  }
}

output "subnet_ids" {
  description = "IDs of all four subnets"

  value = {
    vpc1_public  = aws_subnet.vpc1_public_subnet.id
    vpc1_private = aws_subnet.vpc1_private_subnet.id
    vpc2_public  = aws_subnet.vpc2_public_subnet.id
    vpc2_private = aws_subnet.vpc2_private_subnet.id
  }
}
