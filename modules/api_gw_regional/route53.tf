resource "aws_route53_record" "api_gw" {
  name    = aws_api_gateway_domain_name.main.domain_name
  type    = "A"
  allow_overwrite = true
  zone_id = var.get_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.main.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.main.regional_zone_id
  }
}
