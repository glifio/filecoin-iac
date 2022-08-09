################# START BLOCK DEV ENV SECRETS LIST #################

resource "aws_secretsmanager_secret" "calibrationapi-archive-lotus" {
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-calibrationapi-archive-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-archive-lotus" },
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
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-calibrationapi-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "calibrationapi_jwt_lotus" {
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-calibrationapi-jwt-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-jwt-lotus" },
  module.generator.common_tags)
}

################# END BLOCK DEV ENV SECRETS LIST #################


################# START BLOCK MAINNET ENV SECRETS LIST #################

resource "aws_secretsmanager_secret" "api_read_cache" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-api-read-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-cache" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_lotus" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-api-read-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-lotus" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space00_lotus" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space00-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space00-lotus" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06_lotus" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space06-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-lotus" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06_cache" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space06-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-cache" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space06-1_lotus" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space06-1-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space06-1-lotus" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space07_lotus" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space07-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space07-lotus" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "space07_cache" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-space07-cache"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-space07-cache" },
    module.generator.common_tags)
}
################# END BLOCK MAINNET ENV SECRETS LIST #################
