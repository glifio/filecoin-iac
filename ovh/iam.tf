resource "aws_iam_user" "external_dns" {
  name = local.external_dns.name
  path = "/system/"

  tags = merge(
    { "Name" = "${module.generator.prefix}-${local.external_dns.name}" },
    module.generator.common_tags
  )
}

resource "aws_iam_access_key" "external_dns" {
  user = aws_iam_user.external_dns.name
}

data "aws_iam_policy_document" "dns_management" {
  statement {
    sid    = "ListHostedZonesAndRecordSets"
    effect = "Allow"
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "ChangeResourceRecordSets"
    effect = "Allow"
    actions = [
      "route53:ChangeResourceRecordSets"
    ]
    resources = [
      "arn:aws:route53:::hostedzone/*"
    ]
  }
}

resource "aws_iam_user_policy" "dns_management" {
  name   = "${module.generator.prefix}-${local.external_dns.name}"
  user   = aws_iam_user.external_dns.name
  policy = data.aws_iam_policy_document.dns_management.json
}
