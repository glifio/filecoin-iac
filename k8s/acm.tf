resource "aws_acm_certificate" "external_lb" {
  domain_name = var.route53_domain
  subject_alternative_names = [
    "*.${var.route53_domain}",
    "calibration.node.glif.io",
    "*.calibration.node.glif.io"
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}



resource "aws_acm_certificate" "internal_lb" {
  domain_name = "dev-internal.dev.node.glif.io"
  subject_alternative_names = [
    "*.dev-internal.dev.node.glif.io",
    "*.api.dev.node.glif.io",
    "api.dev.node.glif.io"
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}
