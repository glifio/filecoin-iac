################# START BLOCK DEV ENV SECRETS LIST #################
resource "aws_secretsmanager_secret" "calibrationapi-archive-node-lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-calibrationapi-archive-node-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-archive-node-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_dev_lotus" {
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-api-read-dev-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-dev-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_cache_dev" {
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-api-read-cache-dev"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-cache-dev" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "calibrationapi_0_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-calibrationapi-0-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-0-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "cid_checker_calibration" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-cid-checker-calibration"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-cid-checker-calibration" },
  module.generator.common_tags)
}

################# END BLOCK DEV ENV SECRETS LIST #################


################# START BLOCK MAINNET ENV SECRETS LIST #################

resource "aws_secretsmanager_secret" "api_read_v0_cache" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-api-read-v0-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-v0-cache" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_master_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-api-read-master-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-master-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space07_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space07-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space07-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space07_cache" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space07-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space07-cache" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "fvm_archive" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-fvm-archive-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-fvm-archive-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "cid_checker" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-cid-checker"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-cid-checker" },
  module.generator.common_tags)
}

################# END BLOCK MAINNET ENV SECRETS LIST #################

resource "aws_secretsmanager_secret" "ovh_cloud_credentials" {
  count = local.is_prod_envs

  name = "${module.generator.prefix}/ovh-cloud-credentials"

  tags = merge(
    { "Name" = "${module.generator.prefix}-ovh-cloud-credentials" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "coinfirm" {
  count = local.is_prod_envs

  name = "${module.generator.prefix}-coinfirm-lotus"

  tags = merge(
    { "Name" = "${module.generator.prefix}-coinfirm" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "drpc-external-public-key" {
  count = local.is_prod_envs

  name = "${module.generator.prefix}-drpc-external-public-key"

  tags = merge(
    { "Name" = "${module.generator.prefix}-drpc-external-public-key" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "drpc-provider-private-key" {
  count = local.is_prod_envs

  name = "${module.generator.prefix}-drpc-provider-private-key"

  tags = merge(
    { "Name" = "${module.generator.prefix}-drpc-provider-private-key" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "drpc-private-key" {
  count = local.is_prod_envs

  name = "${module.generator.prefix}-drpc-private-key"

  tags = merge(
    { "Name" = "${module.generator.prefix}-drpc-private-key" },
    module.generator.common_tags
  )
}