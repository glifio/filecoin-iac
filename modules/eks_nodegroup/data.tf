data "aws_subnet" "selected" {
  id = local.subnet_id
}

data "aws_iam_policy_document" "nodegroup_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "nodegroup_ebs_management_policy" {
  statement {
    sid = "ManageEbsVolumes"

    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume",
      "ec2:DescribeInstances",
      "ec2:DescribeVolumes"
    ]
    resources = ["*"]
  }
}
