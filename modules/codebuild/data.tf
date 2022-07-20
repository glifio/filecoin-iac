data "aws_secretsmanager_secret" "git_credentials" {
  name = "${module.generator.prefix}/github_cd_token_secret"
}

data "aws_secretsmanager_secret_version" "git_credentials" {
  secret_id = data.aws_secretsmanager_secret.git_credentials.id
}
