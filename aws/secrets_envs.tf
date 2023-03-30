################# START BLOCK DEV ENV SECRETS LIST #################

resource "aws_secretsmanager_secret" "calibrationapi-archive-lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-calibrationapi-archive-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-archive-lotus" },
  module.generator.common_tags)
}

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

resource "aws_secretsmanager_secret" "calibrationapi_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-calibrationapi-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "calibrationapi_jwt_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-calibrationapi-jwt-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-jwt-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "wallaby_archive_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-wallaby-archive-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-wallaby-archive-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "hyperspace_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-hyperspace-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-hyperspace-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "hyperspace_mirror_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-hyperspace-mirror-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-hyperspace-mirror-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "hyperspace_mirrored_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-hyperspace-mirrored-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-hyperspace-mirrored-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "hyperspace_private_0_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-hyperspace-private-0-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-hyperspace-private-0-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "wallaby_archive_private_0_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-wallaby-archive-private-0-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-wallaby-archive-private-0-lotus" },
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

resource "aws_secretsmanager_secret" "api_read_mirror_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-api-read-mirror-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-mirror-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_master_mirrored_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-api-read-master-mirrored-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-master-mirrored-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_master_canary_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-api-read-master-canary-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-master-canary-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space00_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space00-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space00-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space06-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06_cache" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space06-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-cache" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06-1_lotus" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-space06-1-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-1-lotus" },
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

resource "aws_secretsmanager_secret" "cid_checker" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-cid-checker"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-cid-checker" },
  module.generator.common_tags)
}

################# END BLOCK MAINNET ENV SECRETS LIST #################
