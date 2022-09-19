

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

resource "aws_secretsmanager_secret" "cid_checker" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-cid-checker"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-cid-checker" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "dockerhub_glifio" {
  count                   = local.is_mainnet_envs
  name                    = "${module.generator.prefix}-dockerhub-glifio"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-dockerhub-glifio" },
  module.generator.common_tags)
}
