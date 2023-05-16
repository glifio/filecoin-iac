
resource "aws_secretsmanager_secret" "main" {

  name                    = "${module.generator.prefix}-${var.get_nodegroup_name}"
  recovery_window_in_days = 30

  tags = merge({ "Name" = "${module.generator.prefix}-${var.get_nodegroup_name}" },
  module.generator.common_tags)
}

resource "aws_secretsmanager_secret_version" "main" {
  secret_id     = aws_secretsmanager_secret.main.id
  secret_string = jsonencode(local.secret_string)

#  lifecycle {
#    ignore_changes = [secret_string]
#  }
}


resource "kubernetes_secret_v1" "main" {
  depends_on = [aws_secretsmanager_secret_version.main]
  metadata {
    name      = "${var.get_nodegroup_name}-lotus-secret"
    namespace = var.get_namespace
  }
  data = {
    "privatekey" = lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "private_key", null)
    "token"      = lookup(jsondecode(aws_secretsmanager_secret_version.main.secret_string), "jwt_token", null)
  }
}

