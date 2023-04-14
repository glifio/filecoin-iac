resource "aws_route53_record" "default" {
  name            = "uptimerobot.${local.route53_hosted_zone}"
  type            = "A"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.default.zone_id

  alias {
    evaluate_target_health = false
    name                   = aws_cloudfront_distribution.default.domain_name
    zone_id                = aws_cloudfront_distribution.default.hosted_zone_id
  }
}
