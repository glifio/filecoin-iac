resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge({ "Name" = "${module.generator.prefix}-public-rt" }, module.generator.common_tags)

}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge({ "Name" = "${module.generator.prefix}-private-rt" }, module.generator.common_tags)
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private.id
}


resource "aws_route" "igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}
