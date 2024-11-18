resource "aws_ebs_volume" "space07_1" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size       = 13312
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

  size       = 13312
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

  size       = 13312
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

  size       = 13312
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

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-01dab0f9e3f71f76b"

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

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-05436ba43515c93b4"

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

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0c704cb019bd938a4"

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

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0d70e1b27c01a53c7"

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-fvm-archive-4",
      "Tenant"     = "fvm-archive",
      "PartNumber" = 4
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "thegraph_1" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-054ed7a7c722f6e8d"

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-thegraph-1",
      "Tenant"     = "thegraph",
      "PartNumber" = 1
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "thegraph_2" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-07511020d2bb9f77a"

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-thegraph-2",
      "Tenant"     = "thegraph",
      "PartNumber" = 2
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "thegraph_3" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0dbb77e03853ce875"

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-thegraph-3",
      "Tenant"     = "thegraph",
      "PartNumber" = 3
    },
    module.generator.common_tags
  )
}

resource "aws_ebs_volume" "thegraph_4" {
  count = local.is_prod_envs

  availability_zone = join("", [var.region, "a"])

  size       = 4096
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0980c8953bf11f3b2"

  tags = merge(
    {
      "Name"       = "${module.generator.prefix}-thegraph-4",
      "Tenant"     = "thegraph",
      "PartNumber" = 4
    },
    module.generator.common_tags
  )
}
