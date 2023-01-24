resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "4.10.0"

  values = [
    templatefile("${path.module}/configs/atlantis/atlantis-values.yaml", {
      orgWhitelist  = "github.com/glifio/*"
      github_user   = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "user", null)
      github_token  = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "token", null)
      github_secret = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis_github_token.secret_string), "secret", null)
    })
  ]
}
