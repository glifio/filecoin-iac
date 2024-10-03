resource "aws_route53_record" "ipfs" {
  zone_id         = data.aws_route53_zone.default.zone_id
  name            = "ipfs.${var.domain_zone}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.default.dns_name]
}

resource "aws_route53_record" "index" {
  zone_id         = data.aws_route53_zone.default.zone_id
  name            = "index.${var.domain_zone}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.default.dns_name]
}

resource "aws_route53_record" "query" {
  zone_id         = data.aws_route53_zone.default.zone_id
  name            = "query.${var.domain_zone}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.default.dns_name]
}
