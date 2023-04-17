resource "aws_acm_certificate" "default" {
  domain_name       = "uptimerobot.${local.route53_hosted_zone}"
  validation_method = "DNS"

  tags = module.generator.common_tags
}
