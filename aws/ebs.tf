resource "aws_ebs_volume" "space07_1" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_1[0].id

  size       = 12288
  type       = "gp3"
  iops       = 3000
  throughput = 167

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-space07-1",
      "Tenant"     = "space07",
      "PartNumber" = 1
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space07_2" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_2[0].id

  size       = 12288
  type       = "gp3"
  iops       = 3000
  throughput = 167

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-space07-2",
      "Tenant"     = "space07",
      "PartNumber" = 2
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space07_3" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_3[0].id

  size       = 12288
  type       = "gp3"
  iops       = 3000
  throughput = 167

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-space07-3",
      "Tenant"     = "space07",
      "PartNumber" = 3
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "space07_4" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_4[0].id

  size       = 12288
  type       = "gp3"
  iops       = 3000
  throughput = 167

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-space07-4",
      "Tenant"     = "space07",
      "PartNumber" = 4
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "fvm_archive_1" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_4[0].id

  size       = 2048
  type       = "gp3"
  iops       = 3000
  throughput = 125

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-fvm-archive-1",
      "Tenant"     = "fvm-archive",
      "PartNumber" = 1
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "fvm_archive_2" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_4[0].id

  size       = 2048
  type       = "gp3"
  iops       = 3000
  throughput = 125

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-fvm-archive-2",
      "Tenant"     = "fvm-archive",
      "PartNumber" = 2
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "fvm_archive_3" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_4[0].id

  size       = 2048
  type       = "gp3"
  iops       = 3000
  throughput = 125

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-fvm-archive-3",
      "Tenant"     = "fvm-archive",
      "PartNumber" = 3
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "fvm_archive_4" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  #snapshot_id = data.aws_ebs_snapshot.space00_4[0].id

  size       = 2048
  type       = "gp3"
  iops       = 3000
  throughput = 125

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-fvm-archive-4",
      "Tenant"     = "fvm-archive",
      "PartNumber" = 4
    },
    module.generator.common_tags
  )
}
