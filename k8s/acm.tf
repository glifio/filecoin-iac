resource "aws_acm_certificate" "api_gw" {
  domain_name = "api.${var.env_specific_subdomain_name}.${var.route53_domain}"
  subject_alternative_names = [
    "api.${var.env_specific_subdomain_name}.${var.route53_domain}",
    "${var.env_specific_subdomain_name}.${var.route53_domain}",
    "*.${var.env_specific_subdomain_name}.${var.route53_domain}",
    "${var.env_specific_subdomain_name}-internal.${var.route53_domain}",
    "*.${var.env_specific_subdomain_name}-internal.${var.route53_domain}"
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}

resource "aws_route53_record" "main" {
  for_each = {
    for dvo in aws_acm_certificate.api_gw.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.selected.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "api_gw" {
  certificate_arn         = aws_acm_certificate.api_gw.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}


resource "aws_acm_certificate" "external_lb" {
  domain_name = "${var.env_specific_subdomain_name}.${var.route53_domain}"
  subject_alternative_names = [
    "*.${var.env_specific_subdomain_name}.${var.route53_domain}",
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}

resource "aws_route53_record" "external_lb" {
  for_each = {
    for dvo in aws_acm_certificate.external_lb.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.selected.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "external_lb" {
  certificate_arn         = aws_acm_certificate.external_lb.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}


resource "aws_acm_certificate" "internal_lb" {
  domain_name = "${var.env_specific_subdomain_name}-internal.${var.route53_domain}"
  subject_alternative_names = [
    "*.${var.env_specific_subdomain_name}-internal.${var.route53_domain}",
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}

resource "aws_route53_record" "internal_lb" {
  for_each = {
    for dvo in aws_acm_certificate.internal_lb.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      record  = dvo.resource_record_value
      type    = dvo.resource_record_type
      zone_id = data.aws_route53_zone.selected.zone_id
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = each.value.zone_id
}

resource "aws_acm_certificate_validation" "internal_lb" {
  certificate_arn         = aws_acm_certificate.internal_lb.arn
  validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}
