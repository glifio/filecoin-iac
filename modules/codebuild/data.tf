data "aws_secretsmanager_secret" "git_credentials" {
  name = "${module.generator.prefix}/github_cd_token_secret"
}

data "aws_secretsmanager_secret_version" "git_credentials" {
  secret_id = data.aws_secretsmanager_secret.git_credentials.id
}

data "aws_secretsmanager_secret" "slack_monitoring_channel" {
  count = local.enable_notifications

  name = "${module.generator.prefix}/${local.slack_secret_name}"
}

data "aws_secretsmanager_secret_version" "slack_monitoring_channel" {
  count = local.enable_notifications

  secret_id = data.aws_secretsmanager_secret.slack_monitoring_channel[0].id
}