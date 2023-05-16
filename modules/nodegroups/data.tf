data "aws_subnet" "selected" {
  id = local.get_subnet_id
}

data "aws_secretsmanager_secret" "current" {
  depends_on = [aws_secretsmanager_secret.main]
  count      = var.enable_public_access ? 1 : 0
  name       = "${module.generator.prefix}-${var.get_nodegroup_name}"
}

data "aws_secretsmanager_secret_version" "current" {
  depends_on = [aws_secretsmanager_secret.main]
  count      = var.enable_public_access ? 1 : 0
  secret_id  = data.aws_secretsmanager_secret.current[0].id
}

data "external" "secret_generator" {
  program = ["python3", "main.py"]
}

output "private_key" {
  value = data.external.secret_generator.result.private_key
}

output "jwt_token" {
  value = data.external.secret_generator.result.jwt_token
}

output "jwt_token_kong_rw" {
  value = data.external.secret_generator.result.jwt_token_kong_rw
}