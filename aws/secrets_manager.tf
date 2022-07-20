resource "aws_secretsmanager_secret" "calibrationapi-archive-lotus" {
  name                    = "${module.generator.prefix}-calibrationapi-archive-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-archive-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_dev_lotus" {
  name                    = "${module.generator.prefix}-api-read-dev-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-dev-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "api_read_cache_dev" {
  name                    = "${module.generator.prefix}-api-read-cache-dev"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-api-read-cache-dev" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "calibrationapi_lotus" {
  name                    = "${module.generator.prefix}-calibrationapi-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "calibrationapi_jwt_lotus" {
  name                    = "${module.generator.prefix}-calibrationapi-jwt-lotus"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-calibrationapi-jwt-lotus" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "opensearch_user_credentials" {
  name                    = "${module.generator.prefix}-opensearch-user-credentials"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-opensearch-user-credentials" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "monitoring" {
  name                    = "${module.generator.prefix}-monitoring"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-monitoring" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "github_cd_token_secret" {
  name                    = "${module.generator.prefix}/github_cd_token_secret"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-github-cd-token-secret" },
  module.generator.common_tags)
}
