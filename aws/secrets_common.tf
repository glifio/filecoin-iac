

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

resource "aws_secretsmanager_secret" "dockerhub_glifio" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-dockerhub-glifio"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-dockerhub-glifio" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "codebuild_user" {
  count                   = local.is_dev_envs
  name                    = "${module.generator.prefix}-codebuild-user"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-codebuild-user" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "codebuild_wallaby_user" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}-codebuild-wallaby-user"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-codebuild-wallaby-user" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "github_ssh_gist_updater" {
  count                   = local.is_prod_envs
  name                    = "${module.generator.prefix}/github_ssh_gist_updater"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-github-ssh-gist-updater" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "credentials_atlantis" {
  name                    = "${module.generator.prefix}/credentials-atlantis"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-credentials-atlantis" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "credentials_grafana_users" {
  name                    = "${module.generator.prefix}/credentials-grafana-users"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-credentials-grafana-users" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret" "slack_monitoring_channel" {
  name = "${module.generator.prefix}/slack-monitoring-channel"

  tags = merge(
    { "Name" = "${module.generator.prefix}-slack-monitoring-channel" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "budget_alarm_slack" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-budget-alarm-slack"

  tags = merge(
    { "Name" = "${module.generator.prefix}-budget-alarm-slack" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "monitoring_google_oauth" {
  name = "${module.generator.prefix}-monitoring-google-oauth"

  tags = merge(
    { "Name" = "${module.generator.prefix}-monitoring-google-oauth" },
    module.generator.common_tags
  )
}

resource "aws_secretsmanager_secret" "auth" {
  name = "${module.generator.prefix}-auth"

  tags = merge(
    { "Name" = "${module.generator.prefix}-auth" },
    module.generator.common_tags
  )
}
