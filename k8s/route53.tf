resource "aws_route53_record" "dev_nlb_ingress_external" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = var.route53_domain
  allow_overwrite = true
  type            = "A"
  alias {
    evaluate_target_health = true
    name                   = data.aws_lb.kong_external.dns_name
    zone_id                = data.aws_lb.kong_external.zone_id
  }
}

## Route53 record from calibration.node.glif.io
#resource "aws_route53_record" "nlb_ingress_external_calibration" {
#  count           = local.is_dev_envs
#  zone_id         = data.aws_route53_zone.node_glif_io.zone_id
#  name            = "api.calibration.node.glif.io"
#  allow_overwrite = true
#  type            = "CNAME"
#  ttl             = "60"
#  records         = [data.aws_lb.kong_external.dns_name]
#}

resource "aws_route53_record" "dev_nlb_ingress_internal" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "${var.environment}-internal.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_internal.dns_name]
}


resource "aws_route53_record" "monitoring" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "monitoring.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_external.dns_name]
}
