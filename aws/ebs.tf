resource "aws_ebs_volume" "space00_1" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size = 8192
  type = "gp3"
  iops = 3000

  tags = merge(
    {
      "Tenant" = "space00"
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space00_2" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size = 8192
  type = "gp3"
  iops = 3000

  tags = merge(
    {
      "Tenant" = "space00"
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space00_3" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size = 8192
  type = "gp3"
  iops = 3000

  tags = merge(
    {
      "Tenant" = "space00"
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space00_4" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size = 8192
  type = "gp3"
  iops = 3000

  tags = merge(
    {
      "Tenant" = "space00"
    },
    module.generator.common_tags
  )
}
