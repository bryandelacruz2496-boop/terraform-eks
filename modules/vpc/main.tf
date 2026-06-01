# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-igw"
  })
}

# Public Subnets
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(var.tags, {
    Name                     = "${var.vpc_name}-public-${var.availability_zones[count.index]}"
    "kubernetes.io/role/elb" = "1"
  })
}

# Private Subnets
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(var.tags, {
    Name                              = "${var.vpc_name}-private-${var.availability_zones[count.index]}"
    "kubernetes.io/role/internal-elb" = "1"
  })
}

# Elastic IP for NAT Gateway (disabled)
# resource "aws_eip" "nat" {
#   count  = var.enable_nat_gateway ? 1 : 0
#   domain = "vpc"
#
#   tags = merge(var.tags, {
#     Name = "${var.vpc_name}-nat-eip"
#   })
# }

# NAT Gateway
# resource "aws_nat_gateway" "this" {
#   count         = var.enable_nat_gateway ? 1 : 0
#   allocation_id = aws_eip.nat[0].id
#   subnet_id     = aws_subnet.public[0].id

#   tags = merge(var.tags, {
#     Name = "${var.vpc_name}-nat"
#   })

#   depends_on = [aws_internet_gateway.this]
# }

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-public-rt"
  })
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = merge(var.tags, {
    Name = "${var.vpc_name}-private-rt"
  })
}

# Public Route Table Associations
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table Associations
resource "aws_route_table_association" "private" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
