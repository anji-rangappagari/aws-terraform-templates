resource "aws_vpc" "my_first_vpc" {
  cidr_block = var.vpc_cidr
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.my_first_vpc.id
  cidr_block = var.public_subnet1_cidr
 availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_first_vpc.id
  cidr_block = var.public_subnet2_cidr
 availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
}