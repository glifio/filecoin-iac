locals {
  aws_secret_name = "${module.generator.prefix}-${var.name}"
  k8s_secret_name = "${var.name}${var.k8s_secret_postfix}"

  k8s_secret_count = var.create_k8s_secret ? 1 : 0

  from_secret_condition = length(var.from_secret) > 0
  from_secret_count     = local.from_secret_condition ? 1 : 0
  from_secret_name      = var.from_secret

  # If importing from another secret, get secret_string from there. Otherwise, generate a new one
  secret_string = local.from_secret_condition ? data.aws_secretsmanager_secret_version.from[0].secret_string : jsonencode(data.external.secret.result)
}
