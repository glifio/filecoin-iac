resource "helm_release" "atlantis_main" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "4.10.0"


  set {
    name  = "orgAllowlist"
    value = var.atlantis_repo_allowlist
  }

  set {
    name  = "ingress.enabled"
    value = "true"
  }

  set {
    name  = "ingress..metadata.annotations"
    value = "kubernetes.io/ingress.class: kong-external-lb"
  }

  set {
    name  = "github.user"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_user", null)
  }

  set {
    name  = "github.token"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_token", null)
  }

  set {
    name  = "github.secret"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_secret", null)
  }

  set {
    name  = "basicAuth.username"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_username", null)
  }

  set {
    name  = "basicAuth.password"
    value = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "basic_auth_password", null)
  }

  set {
    name  = "awsSecretName"
    value = "aws-atlantis"
  }

  set {
    name  = "Values.environment"
    value = "TF_PLUGIN_CACHE_DIR: /atlantis-data/.terraform.d/plugin-cache"
  }
}

#resource "github_repository" "repo" {
#  name         = var.atlantis_repo_allowlist
#  description  = "Terraform acceptance tests"
#  homepage_url = "https://github.com/glifio/filecoin-iac"
#
#  visibility   = "public"
#}

#resource "github_repository_webhook" "main" {
#  count = var.create_github_repository_webhook ? length(var.atlantis_repo_allowlist) : 0
#
#  repository = var.atlantis_repo_allowlist
#
#  configuration {
#    url          = "atlantis.${var.route53_domain}/event"
#    content_type = "application/json"
#    insecure_ssl = false
#    secret       = lookup(jsondecode(data.aws_secretsmanager_secret_version.atlantis.secret_string), "gh_secret", null)
#  }
#
#  events = [
#    "issue_comment",
#    "pull_request",
#    "pull_request_review",
#    "pull_request_review_comment",
#  ]
#}