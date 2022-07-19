data "aws_caller_identity" "current" {}
data "aws_availability_zones" "main" {
  state = "available"
}

data "tls_certificate" "this" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

data "aws_secretsmanager_secret_version" "opensearch_user_credentials" {
  secret_id = aws_secretsmanager_secret.opensearch_user_credentials.id
}

data "aws_route53_zone" "selected" {
  name         = var.route53_domain
  private_zone = false
}
