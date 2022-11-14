resource "aws_s3_bucket" "main" {
  bucket        = var.bucket_name
  force_destroy = true

  tags = merge(module.generator.common_tags, { Description = "Bucket to store s3-${var.bucket_name} files" })
}

resource "aws_iam_role" "main" {
  name        = "${terraform.workspace}-cronjob-${var.bucket_name}"
  description = "${terraform.workspace} allow cronjob-${var.bucket_name} access to s3 bucket."
  assume_role_policy = templatefile("${path.module}/templates/roles/iodc_sync_marketdeals.pol.tpl", {
    aws_account_id  = data.aws_caller_identity.current.account_id
    oidc            = local.oidc_URL
    namespace       = var.get_sa_namespace
    sa_market_deals = "cid-checker-${var.bucket_name}-sync-s3-sa"
  })

  tags = merge({ "Name" = "${module.generator.prefix}-cronjob-marketdeals" }, module.generator.common_tags
  )
}

resource "aws_iam_policy" "main" {
  name        = "${module.generator.prefix}-cronjob-${var.bucket_name}"
  description = "Allow cronjob-${var.bucket_name} access to s3 bucket."
  policy = templatefile("${path.module}/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.main.id
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.main.name
  policy_arn = aws_iam_policy.main.arn
}

resource "kubernetes_service_account_v1" "main" {
  metadata {
    name      = "cid-checker-${var.bucket_name}-sync-s3-sa"
    namespace = var.get_sa_namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.main.arn
    }
  }
}
