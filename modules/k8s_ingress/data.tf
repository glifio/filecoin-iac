data "aws_secretsmanager_secret" "current" {
  count = var.is_kong_auth_header_enabled ? 1 : 0
  name  = "${module.generator.prefix}-${var.get_ingress_backend_service_name}"
}

data "aws_secretsmanager_secret_version" "current" {
  count     = var.is_kong_auth_header_enabled ? 1 : 0
  secret_id = data.aws_secretsmanager_secret.current[0].id
}
