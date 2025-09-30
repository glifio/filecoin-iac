resource "aws_route53_record" "proxy" {
  zone_id         = data.aws_route53_zone.default.zone_id
  name            = "proxy.${local.domain_zone}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.default.dns_name]
}