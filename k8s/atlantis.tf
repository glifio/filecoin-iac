resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "4.10.0"

  set {
    name  = "github.user"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "user", null)
  }
  set {
    name  = "github.token"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "token", null)
  }
  set {
    name  = "github.secret"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "secret", null)
  }
  set {
    name  = "orgWhitelist"
    value = "github.com/glifio/*"
  }
 # https://github.com/glifio/
}