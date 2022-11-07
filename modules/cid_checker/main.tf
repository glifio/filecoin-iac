data "aws_caller_identity" "current" {}

#### AWS s3 bucket for market deals. ####

resource "aws_s3_bucket" "cid_checker_market_deals" {
  bucket        = "marketdeals-${var.bucket_name}"
  force_destroy = var.force_destroy

  tags = merge(
    var.tags,
    {
      Description = "Bucket to store s3-market deals ${var.bucket_name} files"
    }
  )
}

#### AWS IAM role for market deals. ####

resource "aws_iam_role" "cid_checker_sync_market_deals" {
  name        = "${terraform.workspace}-cronjob-marketdeals-${var.bucket_name}"
  description = "${terraform.workspace} allow cronjob-marketdeals access to s3 bucket on ${var.bucket_name} "

  assume_role_policy = templatefile("../modules/../k8s/templates/roles/iodc_sync_marketdeals.pol.tpl",{
    aws_account_id  = data.aws_caller_identity.current.account_id
    oidc            = var.oidc
    namespace       = "default"
    sa_market_deals = "cid-checker-${var.bucket_name}-sync-s3-sa"
  })

  tags = merge(
    {
      "Name" = "${var.name_prefix}-cronjob-marketdeals"
    },
    var.tags
  )
}

#### AWS IAM  policy  for market deals. #####

resource "aws_iam_policy" "cid_checker_sync_market_deals" {
  name        = "${var.name_prefix}-cronjob-marketdeals-${var.bucket_name}"
  description = "Allow cronjob-marketdeals access to s3 bucket on ${var.bucket_name}"
  policy = templatefile("../modules/../k8s/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.cid_checker_market_deals.id
  })

  tags = var.tags
}

#### AWS IAM  policy attachment for market deals. #####

resource "aws_iam_role_policy_attachment" "cid_checker_sync_market_deals" {
  role       = aws_iam_role.cid_checker_sync_market_deals.name
  policy_arn = aws_iam_policy.cid_checker_sync_market_deals.arn
}

#### Kubernetes service account for market deals. #####

resource "kubernetes_service_account_v1" "cid_checker_sync_market_deals" {
  metadata {
    name      = "cid-checker-${var.bucket_name}-sync-s3-sa"
    namespace = var.kubernetes_service_account.namespace

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cid_checker_sync_market_deals.arn
    }

    # TODO: add some meaningful label like created by tf
    # labels = {
    # }
  }
}