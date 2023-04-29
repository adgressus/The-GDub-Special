resource "aws_vpc" "myvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = var.default_tags
}

resource "aws_internet_gateway" "mygw" {
  vpc_id = aws_vpc.myvpc.id

  tags = var.default_tags

  depends_on = [aws_vpc.myvpc]
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

  tags = var.default_tags

  depends_on = [aws_vpc.myvpc]
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"

  tags = var.default_tags

  depends_on = [aws_vpc.myvpc]
}

resource "aws_eip" "myeip" {
  vpc = true
}

resource "aws_nat_gateway" "mynatgw" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.public.id

  tags = var.default_tags

  depends_on = [aws_eip.myeip, aws_subnet.public]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.mynatgw.id
  }

  tags = var.default_tags

  depends_on = [aws_nat_gateway.mynatgw]
}

resource "aws_route_table_association" "private-to-internet" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id

  depends_on = [aws_subnet.private, aws_route_table.private]
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mygw.id
  }

  tags = var.default_tags
}

resource "aws_route_table_association" "public-to-internet" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}