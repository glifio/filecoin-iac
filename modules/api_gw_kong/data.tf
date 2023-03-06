data "aws_secretsmanager_secret" "current" {
  name = "${module.generator.prefix}-${var.upstream_service}"
}

data "aws_secretsmanager_secret_version" "current" {
  secret_id = data.aws_secretsmanager_secret.current.id
}

data "aws_secretsmanager_secret" "daemon" {
  name = "${module.generator.prefix}-${local.daemon_service_secret}"
}

data "aws_secretsmanager_secret_version" "daemon" {
  secret_id = data.aws_secretsmanager_secret.current.id
}