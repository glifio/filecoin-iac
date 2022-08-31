resource "aws_route53_record" "api_dev_node_glif_io" {
  count           = local.is_dev_envs
  name            = "api.dev.node.glif.io"
  type            = "A"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.selected.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api_dev_node_glif_io[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_dev_node_glif_io[0].regional_zone_id
  }
}

resource "aws_route53_record" "dev_nlb_ingress_internal" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "${var.environment}-internal.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_internal.dns_name]
}

# Route53 record from calibration.node.glif.io to external nlb
resource "aws_route53_record" "nlb_ingress_external_calibration" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.node_glif_io.zone_id
  name            = "calibration.node.glif.io"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_external.dns_name]
}

resource "aws_route53_record" "api_calibration_node_glif_io" {
  count           = local.is_dev_envs
  name            = "api.calibration.node.glif.io"
  type            = "A"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.node_glif_io.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.api_calibration_node_glif_io[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.api_calibration_node_glif_io[0].regional_zone_id
  }
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

# Route53 record from wallaby.node.glif.io to external nlb
resource "aws_route53_record" "nlb_ingress_external_wallaby" {
  count           = local.is_dev_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "wallaby.dev.node.glif.io"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_external.dns_name]
}

############### mainnet env ###################
resource "aws_route53_record" "api-internal_node_glif_io" {
  count           = local.is_mainnet_envs
  name            = "api.node.glif.io"
  type            = "A"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.selected.zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.node_glif_io[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.node_glif_io[0].regional_zone_id
  }
}

resource "aws_route53_record" "mainnet_nlb_external" {
  count           = local.is_mainnet_envs
  name            = var.route53_domain
  type            = "A"
  allow_overwrite = true
  zone_id         = data.aws_route53_zone.selected.zone_id

  alias {
    evaluate_target_health = true
    name                   = data.aws_lb.kong_external.dns_name
    zone_id                = "Z31USIVHYNEOWT"
  }

}


resource "aws_route53_record" "mainnet_nlb_ingress_internal" {
  count           = local.is_mainnet_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "${var.environment}-internal.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_internal.dns_name]
}

resource "aws_route53_record" "monitoring_mainnet" {
  count           = local.is_mainnet_envs
  zone_id         = data.aws_route53_zone.selected.zone_id
  name            = "monitoring.${var.route53_domain}"
  allow_overwrite = true
  type            = "CNAME"
  ttl             = "60"
  records         = [data.aws_lb.kong_external.dns_name]
}
