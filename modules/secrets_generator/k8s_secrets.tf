resource "kubernetes_secret_v1" "default" {
  count = local.k8s_secret_count

  metadata {
    name      = local.k8s_secret_name
    namespace = var.namespace
  }

  data = {
    privatekey = jsondecode(aws_secretsmanager_secret_version.default.secret_string)["private_key"]
    token      = jsondecode(aws_secretsmanager_secret_version.default.secret_string)["jwt_token"]
  }
}
