resource "helm_release" "atlantis_main" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "4.10.0"


  values = [
    templatefile("${path.root}/configs/atlantis/atlantis-values.yaml", {
      orgAllowlist           = "github.com/glifio/*"
      github_user            = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_user", null)
      github_token           = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_token", null)
      github_webhook_secret  = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_secret", null)
      YOUR_ACCESS_KEY_ID     = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "aws_access_key", null)
      YOUR_SECRET_ACCESS_KEY = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "aws_secret_key", null)
      region                 = "ap-northeast-1"
      basicAuth_username     = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_username", null)
      basicAuth_password     = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_password", null)
    })
  ]
}