resource "aws_route53_record" "monitoring" {
  zone_id         = data.aws_route53_zone.default.zone_id
  name            = "monitoring.${data.aws_route53_zone.default.name}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.default.dns_name]
}
