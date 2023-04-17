data "aws_secretsmanager_secret_version" "default" {
  secret_id = aws_secretsmanager_secret.default.id
}

data "aws_route53_zone" "default" {
  name         = local.route53_hosted_zone
  private_zone = false
}
