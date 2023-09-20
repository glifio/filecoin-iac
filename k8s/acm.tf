resource "aws_acm_certificate" "external_lb" {
  domain_name               = var.route53_domain
  subject_alternative_names = local.external_lb_certificates
  validation_method         = "DNS"

  tags = module.generator.common_tags
}
