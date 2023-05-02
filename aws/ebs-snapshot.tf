resource "aws_iam_role" "dlm" {
  name               = "${module.generator.prefix}-dlm"
  description        = "${module.generator.prefix} dlm role"
  assume_role_policy = file("${path.module}/templates/roles/dlm_role.pol.tpl")

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-dlm"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_role_policy" "dlm" {
  name = "${terraform.workspace}-dlm"
  role = aws_iam_role.dlm.id

  policy = file("${path.module}/templates/policies/dlm_policy.pol.tpl")
}

resource "aws_dlm_lifecycle_policy" "space00" {
  description        = "Make snapshots of space00 LVM volumes"
  execution_role_arn = aws_iam_role.dlm.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "1 week of daily snapshots"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["02:00"]
      }

      retain_rule {
        count = 7
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = true
    }

    target_tags = {
      Tenant = "space00"
    }
  }
}

resource "aws_dlm_lifecycle_policy" "fvm-archive" {
  description        = "Make snapshots of fvm-archive LVM volumes"
  execution_role_arn = aws_iam_role.dlm.arn
  state              = "ENABLED"

  policy_details {
    resource_types = ["VOLUME"]

    schedule {
      name = "1 week of daily snapshots"

      create_rule {
        interval      = 24
        interval_unit = "HOURS"
        times         = ["02:00"]
      }

      retain_rule {
        count = 7
      }

      tags_to_add = {
        SnapshotCreator = "DLM"
      }

      copy_tags = true
    }

    target_tags = {
      Tenant = "fvm-archive"
    }
  }
}
