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
    sid = "AttachVolumes"

    actions = ["ec2:AttachVolume"]
    resources = [
      "arn:aws:ec2:*:*:volume/*",
      "arn:aws:ec2:*:*:instance/*"
    ]
  }
  
  statement {
    sid = "DescribeVolumes"

    actions   = ["ec2:DescribeVolumes"]
    resources = ["*"]
  }
}
