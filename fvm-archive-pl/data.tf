data "aws_vpc" "default" {
  tags = var.vpc_tags
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  tags              = var.subnet_tags
  availability_zone = local.az
}

data "aws_ami" "arm64" {
  filter {
    name   = "image-id"
    values = ["ami-0d90380c7d491eff6"] # Ubuntu 22.04 ARM 64
  }
}

data "aws_ami" "amd64" {
  filter {
    name   = "image-id"
    values = ["ami-0162fe8bfebb6ea16"] # Ubuntu 22.04 AMD 64
  }
}
