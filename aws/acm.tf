resource "aws_acm_certificate" "opensearch_acm" {
  domain_name = "kibana.${var.route53_domain}"
  subject_alternative_names = [
    "*.kibana.${var.route53_domain}"
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}

resource "aws_route53_record" "opensearch_acm" {
  for_each = {
    for dvo in aws_acm_certificate.opensearch_acm.domain_validation_options : dvo.domain_name => {
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

resource "aws_acm_certificate_validation" "opensearch" {
  certificate_arn         = aws_acm_certificate.opensearch_acm.arn
  validation_record_fqdns = [for record in aws_route53_record.opensearch_acm : record.fqdn]
}
