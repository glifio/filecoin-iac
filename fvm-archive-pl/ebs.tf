resource "aws_ebs_volume" "fvm_archive_pl_1" {
  availability_zone = local.az

  size       = 4352
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-034fa4291648f59d3"

  tags = merge(var.common_tags,
    {
      "Name"       = "${var.resource_prefix}-fvm-archive-pl-1",
      "Tenant"     = "fvm-archive-pl",
      "PartNumber" = 1
    }
  )
}

resource "aws_ebs_volume" "fvm_archive_pl_2" {
  availability_zone = local.az

  size       = 4352
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0cf5c823acd02cd7d"

  tags = merge(var.common_tags,
    {
      "Name"       = "${var.resource_prefix}-fvm-archive-pl-2",
      "Tenant"     = "fvm-archive-pl",
      "PartNumber" = 2
    }
  )
}

resource "aws_ebs_volume" "fvm_archive_pl_3" {
  availability_zone = local.az

  size       = 4352
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-0d75c2b7910eb04ca"

  tags = merge(var.common_tags,
    {
      "Name"       = "${var.resource_prefix}-fvm-archive-pl-3",
      "Tenant"     = "fvm-archive-pl",
      "PartNumber" = 3
    }
  )
}

resource "aws_ebs_volume" "fvm_archive_pl_4" {
  availability_zone = local.az

  size       = 4352
  type       = "gp3"
  iops       = 3000
  throughput = 125

  snapshot_id = "snap-04fa9f4a436cd1377"

  tags = merge(var.common_tags,
    {
      "Name"       = "${var.resource_prefix}-fvm-archive-pl-4",
      "Tenant"     = "fvm-archive-pl",
      "PartNumber" = 4
    }
  )
}
