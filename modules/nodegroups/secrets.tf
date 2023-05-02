resource "random_password" "private_key" {
  count            = local.create_secret
  length           = 34
  special          = true
  override_special = "_%@"
}

resource "random_password" "token" {
  count            = local.create_secret
  length           = 64
  special          = true
  override_special = "_%@"
}


resource "aws_secretsmanager_secret" "main" {

  name                    = "${module.generator.prefix}-${var.get_nodegroup_name}"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-${var.get_nodegroup_name}" },
    module.generator.common_tags)
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(local.secret_string)
}


resource "kubernetes_secret_v1" "main" {
  metadata {
    name      = "${var.get_nodegroup_name}-lotus-secret"
    namespace = var.namespace_secret
  }
  data = {
    "private_key" = var.create_new_secret == true ?  lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "private_key", null) : lookup(jsondecode(var.exist_secret[0].secret_string), "private_key", null),
    "token"       = var.create_new_secret == true ? lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "jwt_token", null) : lookup(jsondecode(var.exist_secret[0].secret_string), "jwt_token", null)
  }
}

