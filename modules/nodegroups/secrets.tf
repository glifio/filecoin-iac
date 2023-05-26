resource "aws_secretsmanager_secret" "main" {
  count = var.create_aws_secret ? 1 : 0

  name                    = local.aws_secret_name
  recovery_window_in_days = 0

  tags = merge(module.generator.common_tags, {
    "Name" = local.aws_secret_name
  })
}

resource "aws_secretsmanager_secret_version" "main" {
  count = var.create_aws_secret ? 1 : 0

  secret_id     = aws_secretsmanager_secret.main[0].id
  secret_string = local.secret_string

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}


resource "kubernetes_secret_v1" "main" {
  count = var.create_k8s_secret ? 1 : 0

  metadata {
    name      = local.k8s_secret_name
    namespace = var.get_namespace
  }

  data = {
    privatekey = jsondecode(aws_secretsmanager_secret_version.main[0].secret_string)["private_key"]
    token      = jsondecode(aws_secretsmanager_secret_version.main[0].secret_string)["jwt_token"]
  }
}



