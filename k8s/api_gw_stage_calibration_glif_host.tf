resource "aws_api_gateway_client_certificate" "calibration_glif_host" {
  count       = local.is_prod_envs
  description = "${module.generator.prefix} certificate for stage ${var.environment}"
  tags        = module.generator.common_tags
}

resource "aws_api_gateway_base_path_mapping" "calibration_glif_host" {
  count       = local.is_prod_envs
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.calibration[0].stage_name
  domain_name = "calibrationnet.glif.host"
}

resource "aws_api_gateway_domain_name" "calibration_glif_host" {
  count                    = local.is_prod_envs
  regional_certificate_arn = aws_acm_certificate.api_gw_acm_calibratio_glif_host[0].arn
  domain_name              = "calibrationnet.glif.host"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}

resource "aws_acm_certificate" "api_gw_acm_calibratio_glif_host" {
  count                     = local.is_prod_envs
  domain_name               = "calibrationnet.glif.host"
  subject_alternative_names = ["*.calibrationnet.glif.host"]
  validation_method         = "DNS"

  tags = module.generator.common_tags
}

