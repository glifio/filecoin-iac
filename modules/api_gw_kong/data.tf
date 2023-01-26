data "aws_secretsmanager_secret" "current" {
  name  = "${module.generator.prefix}-${var.upstream_service}"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.current
}
