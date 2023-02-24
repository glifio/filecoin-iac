#resource "helm_release" "atlantis" {
#  name       = "atlantis"
#  repository = "https://runatlantis.github.io/helm-charts"
#  chart      = "atlantis"
#  version    = "4.10.0"
#
##  values = [
##    templatefile("${path.module}/configs/atlantis/atlantis-values.yaml", {
##      orgAllowlist = "github.com/glifio/*"
##    })
##  ]
#
#  set {
#    name  = "orgAllowlist"
#    value = "github.com/glifio/*"
#  }
#
#  set {
#    name  = "ingress.class"
#    value = "kong-external-lb"
#  }
#
#  set {
#    name  = "github.user"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_user", null)
#  }
#  set {
#    name  = "github.token"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_token", null)
#  }
#  set {
#    name  = "github.secret"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_secret", null)
#  }
#  set {
#    name  = "basicAuth.username"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_username", null)
#  }
#  set {
#    name  = "basicAuth.password"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_password", null)
#  }
#  set {
#    name  = "aws.credentials"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "aws_access_key", null)
#  }
#  set {
#    name  = "aws.credentials"
#    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "aws_secret_key", null)
#  }
#}