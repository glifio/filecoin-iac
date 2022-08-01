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

##

################# END BLOCK MAINNET ENV SECRETS LIST #################
