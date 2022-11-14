resource "aws_api_gateway_stage" "wallaby_node_glif_io" {
  count                 = local.is_mainnet_envs
  deployment_id         = aws_api_gateway_deployment.main.id
  rest_api_id           = aws_api_gateway_rest_api.main.id
  stage_name            = "wallaby"
  client_certificate_id = aws_api_gateway_client_certificate.calibration[0].id
  cache_cluster_size    = "0.5"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.calibration[0].arn
    format          = file("${path.module}/configs/api_gateway_templates/cloudwatch_logs_format.pol.tpl")
  }

  variables = {
    "health" = "/wallaby/lotus/debug/metrics"
    "rpc_v0" = "wallaby/lotus/rpc/v0"
    "rpc_v1" = "wallaby/lotus/rpc/v1"
  }

  depends_on = [
    aws_iam_role_policy_attachment.account_logging_dev
  ]
}

resource "aws_api_gateway_client_certificate" "wallaby_node_glif_io" {
  count       = local.is_mainnet_envs
  description = "${module.generator.prefix} certificate for stage ${var.environment}"
  tags        = module.generator.common_tags
}

resource "aws_cloudwatch_log_group" "wallaby_node_glif_io" {
  count             = local.is_mainnet_envs
  name              = "${module.generator.prefix}-${aws_api_gateway_rest_api.main.id}/wallaby"
  retention_in_days = 30

  tags = module.generator.common_tags
}


resource "aws_api_gateway_base_path_mapping" "wallaby_node_glif_io" {
  count       = local.is_mainnet_envs
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.wallaby_node_glif_io[0].stage_name
  domain_name = aws_api_gateway_domain_name.wallaby_node_glif_io[0].domain_name
}

resource "aws_api_gateway_domain_name" "wallaby_node_glif_io" {
  count                    = local.is_mainnet_envs
  regional_certificate_arn = aws_acm_certificate.api_gw_acm_wallaby[0].arn
  domain_name              = "wallaby.node.glif.io"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}


resource "aws_acm_certificate" "api_gw_acm_wallaby" {
  count                     = local.is_mainnet_envs
  domain_name               = "wallaby.node.glif.io"
  subject_alternative_names = ["*.wallaby.node.glif.io"]
  validation_method         = "DNS"

  tags = module.generator.common_tags
}

resource "aws_api_gateway_method_settings" "path_specific_wallaby" {
  count       = local.is_mainnet_envs
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.wallaby_node_glif_io[0].stage_name
  method_path = "dev/POST"

  settings {
    metrics_enabled        = true
    logging_level          = "INFO"
    throttling_rate_limit  = "1000"
    throttling_burst_limit = "5000"
  }
}


