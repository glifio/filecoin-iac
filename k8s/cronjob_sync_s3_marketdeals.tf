#### MARKETDEALS MAINNET

resource "aws_s3_bucket" "cid_checker_marketdeals_bucket_mainnet" {
  count         = local.is_mainnet_envs
  bucket        = "marketdeals"
  force_destroy = true

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Bucket to store s3-market deals files"
    }
  )
}

resource "aws_iam_role" "cid_checker_sync_marketdeals_mainnet" {
  count       = local.is_mainnet_envs
  name        = "${terraform.workspace}-cronjob-marketdeals-mainnet"
  description = "${terraform.workspace} allow cronjob-marketdeals access to s3 bucket on mainnet"

  assume_role_policy = templatefile("${path.module}/templates/roles/iodc_sync_marketdeals.pol.tpl", {
    aws_account_id  = data.aws_caller_identity.current.account_id
    oidc            = local.oidc_URL
    namespace       = "default" 
    sa_market_deals = "cid-checker-mainnet-sync-s3-sa" 
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-cronjob-marketdeals"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "cid_checker_sync_marketdeals_mainnet" {
  count       = local.is_mainnet_envs
  name        = "${module.generator.prefix}-cronjob-marketdeals-mainnet"
  description = "Allow cronjob-marketdeals access to s3 bucket on mainnet"
  policy = templatefile("${path.module}/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.cid_checker_marketdeals_bucket_mainnet[0].id
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "cid_checker_sync_marketdeals_mainnet" {
  count      = local.is_mainnet_envs
  role       = aws_iam_role.cid_checker_sync_marketdeals_mainnet[0].name
  policy_arn = aws_iam_policy.cid_checker_sync_marketdeals_mainnet[0].arn
}

resource "kubernetes_service_account_v1" "cid_checker_sync_marketdeals_mainnet" {
  count = local.is_mainnet_envs
  metadata {
    name      = "cid-checker-mainnet-sync-s3-sa"
    namespace = "default" 

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cid_checker_sync_marketdeals_mainnet[0].arn
    }

    # TODO: add some meaningful label like created by tf
    # labels = {
    # }
  }
}

#### MARKETDEALS CALIBRATION

resource "aws_s3_bucket" "cid_checker_marketdeals_bucket_calibration" {
  count         = local.is_dev_envs
  bucket        = "marketdeals-calibration"
  force_destroy = true

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Bucket to store s3-market deals calibration files"
    }
  )
}

resource "aws_iam_role" "cid_checker_sync_marketdeals_calibration" {
  count       = local.is_dev_envs
  name        = "${terraform.workspace}-cronjob-marketdeals-calibration"
  description = "${terraform.workspace} allow cronjob-marketdeals access to s3 bucket on calibration"

  assume_role_policy = templatefile("${path.module}/templates/roles/iodc_sync_marketdeals.pol.tpl", {
    aws_account_id  = data.aws_caller_identity.current.account_id
    oidc            = local.oidc_URL
    namespace       = "default" 
    sa_market_deals = "cid-checker-calibration-sync-s3-sa" 
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-cronjob-marketdeals"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "cid_checker_sync_marketdeals_calibration" {
  count       = local.is_dev_envs
  name        = "${module.generator.prefix}-cronjob-marketdeals-calibration"
  description = "Allow cronjob-marketdeals access to s3 bucket on calibration"
  policy = templatefile("${path.module}/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.cid_checker_marketdeals_bucket_calibration[0].id
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "cid_checker_sync_marketdeals_calibration" {
  count      = local.is_dev_envs
  role       = aws_iam_role.cid_checker_sync_marketdeals_calibration[0].name
  policy_arn = aws_iam_policy.cid_checker_sync_marketdeals_calibration[0].arn
}

resource "kubernetes_service_account_v1" "cid_checker_sync_marketdeals_calibration" {
  count = local.is_dev_envs
  metadata {
    name      = "cid-checker-calibration-sync-s3-sa"
    namespace = "default"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cid_checker_sync_marketdeals_calibration[0].arn
    }

    # TODO: add some meaningful label like created by tf
    # labels = {
    # }
  }
}

#### MARKETDEALS WALLABY

resource "aws_s3_bucket" "cid_checker_marketdeals_bucket_wallaby" {
  count         = local.is_dev_envs
  bucket        = "marketdeals-wallaby"
  force_destroy = true

  tags = merge(
    module.generator.common_tags,
    {
      Description = "Bucket to store s3-market deals wallaby files"
    }
  )
}

resource "aws_iam_role" "cid_checker_sync_marketdeals_wallaby" {
  count       = local.is_dev_envs
  name        = "${terraform.workspace}-cronjob-marketdeals-wallaby"
  description = "${terraform.workspace} allow cronjob-marketdeals access to s3 bucket on wallaby"

  assume_role_policy = templatefile("${path.module}/templates/roles/iodc_sync_marketdeals.pol.tpl", {
    aws_account_id  = data.aws_caller_identity.current.account_id
    oidc            = local.oidc_URL
    namespace       = "default" 
    sa_market_deals = "cid-checker-wallaby-sync-s3-sa" 
  })

  tags = merge(
    {
      "Name" = "${module.generator.prefix}-cronjob-marketdeals"
    },
    module.generator.common_tags
  )
}

resource "aws_iam_policy" "cid_checker_sync_marketdeals_wallaby" {
  count       = local.is_dev_envs
  name        = "${module.generator.prefix}-cronjob-marketdeals-wallaby"
  description = "Allow cronjob-marketdeals access to s3 bucket on wallaby"
  policy = templatefile("${path.module}/templates/policies/sync_marketdeals_policy.pol.tpl", {
    sync_marketdeals_s3_bucket = aws_s3_bucket.cid_checker_marketdeals_bucket_wallaby[0].id
  })

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "cid_checker_sync_marketdeals_wallaby" {
  count      = local.is_dev_envs
  role       = aws_iam_role.cid_checker_sync_marketdeals_wallaby[0].name
  policy_arn = aws_iam_policy.cid_checker_sync_marketdeals_wallaby[0].arn
}

resource "kubernetes_service_account_v1" "cid_checker_sync_marketdeals_wallaby" {
  count = local.is_dev_envs
  metadata {
    name      = "cid-checker-wallaby-sync-s3-sa"
    namespace = "default"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.cid_checker_sync_marketdeals_wallaby[0].arn
    }

    # TODO: add some meaningful label like created by tf
    # labels = {
    # }
  }
}
