resource "aws_s3_bucket" "marketdeals_bucket" {
  count = local.is_mainnet_envs
  # marketdeals
  bucket = "${terraform.workspace}-cronjob-sync-marketdeals"

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Bucket to store s3-market deals files"
    }
  )
}

resource "aws_iam_role" "sync_marketdeals" {
  count       = local.is_mainnet_envs
  name        = "${terraform.workspace}-cronjob-sync-marketdeals"
  description = "${terraform.workspace} allow cronjob-sync-marketdeals access to s3 bucket"

  assume_role_policy = templatefile("${path.module}/templates/roles/iodc_sync_marketdeals.pol.tpl", {
    aws_account_id = data.aws_caller_identity.current.account_id
    oidc           = local.oidc_URL
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-cronjob-sync-marketdeals"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "sync_marketdeals" {
  count       = local.is_mainnet_envs
  name        = "${module.generator.prefix}-cronjob-sync-marketdeals"
  description = "Allow cronjob-sync-marketdeals access to s3 bucket"
  policy = templatefile("${path.module}/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.marketdeals_bucket[0].id
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "sync_marketdeals" {
  count      = local.is_mainnet_envs
  role       = aws_iam_role.sync_marketdeals[0].name
  policy_arn = aws_iam_policy.sync_marketdeals[0].arn
}


resource "kubernetes_service_account_v1" "sync_marketdeals" {
  count = local.is_mainnet_envs
  metadata {
    name      = "sync-marketdeals"
    namespace = kubernetes_namespace_v1.network.metadata[0].name

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.sync_marketdeals[0].arn
    }

    # TODO: add some meaningful label like created by tf
    # labels = {
    # }
  }
}


resource "kubernetes_cron_job_v1" "sync_marketdeals" {
  count = local.is_mainnet_envs
  metadata {
    name      = "sync-marketdeals"
    namespace = kubernetes_namespace_v1.network.metadata[0].name
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 1
    schedule                      = "*/10 * * * *"
    successful_jobs_history_limit = 1
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            service_account_name = kubernetes_service_account_v1.sync_marketdeals[0].metadata[0].name
            container {
              name  = "sync-marketdeals"
              image = "glif/sync-s3-marketdeals:0.0.1"
              command = ["sh", "-c", templatefile("${path.module}/configs/sync_s3_marketdeals/sync_s3_marketdeals.sh", {
                set_s3_bucket_name = aws_s3_bucket.marketdeals_bucket[0].id
                set_endpoint_s3    = "http://space00-lotus-service:1234/rpc/v0"
                })
              ]
            }
          }
        }
      }
    }
  }
}
