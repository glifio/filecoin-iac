data "aws_secretsmanager_secret" "default" {
  count = var.enable_public_access ? 1 : 0
  name  = var.secret_name
}

data "aws_secretsmanager_secret_version" "default" {
  count     = var.enable_public_access ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.default[0].id
}
