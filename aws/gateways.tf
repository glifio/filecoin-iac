resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = merge({ "Name" = "${module.generator.prefix}-igw" },
    module.generator.common_tags
  )
}

resource "aws_eip" "ngw" {

  tags = merge({ "Name" = "${module.generator.prefix}-eip-ngw" },
    module.generator.common_tags
  )
}

resource "aws_nat_gateway" "main" {
  subnet_id     = element(aws_subnet.public.*.id, 0)
  allocation_id = aws_eip.ngw.id

  tags = merge({ "Name" = "${module.generator.prefix}-ngw" },
    module.generator.common_tags
  )
}
