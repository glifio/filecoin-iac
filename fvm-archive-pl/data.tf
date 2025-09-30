data "aws_vpc" "default" {
  tags = var.vpc_tags
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  tags              = var.subnet_tags
  availability_zone = local.az
}
