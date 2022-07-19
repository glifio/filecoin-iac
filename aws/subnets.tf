resource "aws_subnet" "public" {
  count                   = var.azs_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name"                                                 = "${module.generator.prefix}-public-${count.index}"
      "kubernetes.io/cluster/${module.generator.prefix}-eks" = "shared"
      "kubernetes.io/role/elb"                               = "1"
    },
    module.generator.common_tags
  )
}

resource "aws_subnet" "private" {
  count                   = var.azs_count
  vpc_id                  = aws_vpc.main.id
  availability_zone       = data.aws_availability_zones.main.names[count.index]
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 3, count.index + 3)
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name"                                                 = "${module.generator.prefix}-private-${count.index}"
      "kubernetes.io/cluster/${module.generator.prefix}-eks" = "shared"
      "kubernetes.io/role/internal-elb"                      = "1"

    },
    module.generator.common_tags
  )
}
