resource "helm_release" "fluent_bit" {
  name       = "fluent-bit"
  repository = "oci://${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazonaws.com"
  chart      = "${module.generator.prefix}-chart-fluent-bit"
  namespace  = "logging"

  set {
    name  = "configuration.role_arn"
    value = aws_iam_role.fluent_bit.arn
  }

  set {
    name  = "opensearch.configuration.os_domain"
    value = "kibana.${var.route53_domain}"
  }

  set {
    name  = "opensearch.configuration.aws_region"
    value = var.region
  }
}


resource "aws_iam_role" "fluent_bit" {
  name        = "${terraform.workspace}-fluent-bit"
  description = "${terraform.workspace} fluent-bit role"

  assume_role_policy = templatefile("${path.module}/templates/roles/oidc_aws_fluent_bit.pol.tpl", {
    aws_account_id = data.aws_caller_identity.current.account_id
    oidc           = local.oidc_URL
    aws_region     = var.region
  })

  tags = merge({ "Name" = "${module.generator.prefix}-fluent-bit" }, module.generator.common_tags)
}


resource "aws_iam_policy" "fluent_bit" {
  name        = "${terraform.workspace}-fluent-bit"
  path        = "/"
  description = "Fluent-bit policy that should be assosiated with AWS OpenSearch"

  policy = templatefile("${path.module}/templates/policies/fluent_bit_policy.pol.tpl", {
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region     = var.region
    os_domain_name = "${module.generator.prefix_region}-logging" // it has an association with opesearch service
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "fluent-bit" {
  role       = aws_iam_role.fluent_bit.name
  policy_arn = aws_iam_policy.fluent_bit.arn
}
