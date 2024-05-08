resource "aws_eip" "natgw_eip_1" {
  vpc = true
  tags = {
    Name = "natgw-eip-1"
  }
}

resource "aws_eip" "natgw_eip_2" {
  vpc = true
  tags = {
    Name = "natgw-eip-2"
  }
}

resource "aws_nat_gateway" "nat_gw_1" {
  allocation_id = aws_eip.natgw_eip_1.id
  subnet_id     = var.public_subnet_1_id
  tags = {
    Name = "nat_gateway_1"
  }
  depends_on = [var.internet_gateway_id]
}

resource "aws_nat_gateway" "nat_gw_2" {
  allocation_id = aws_eip.natgw_eip_2.id
  subnet_id     = var.public_subnet_2_id
  tags = {
    Name = "nat_gateway_2"
  }
  depends_on = [var.internet_gateway_id]
}

resource "aws_route_table" "private_route_table_1" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_1.id
  }

  tags = {
    Name = "private-route-table-1"
  }
}

resource "aws_route_table" "private_route_table_2" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_2.id
  }

  tags = {
    Name = "private-route-table-2"
  }
}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = var.private_subnet_1_id
  route_table_id = aws_route_table.private_route_table_1.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = var.private_subnet_2_id
  route_table_id = aws_route_table.private_route_table_2.id
}