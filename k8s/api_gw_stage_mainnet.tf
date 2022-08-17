resource "aws_api_gateway_stage" "mainnet" {
  count                 = local.is_mainnet_envs
  deployment_id         = aws_api_gateway_deployment.main.id
  rest_api_id           = aws_api_gateway_rest_api.main.id
  stage_name            = "mainnet"
  client_certificate_id = aws_api_gateway_client_certificate.mainnet[0].id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.mainnet[0].arn
    format          = file("${path.module}/configs/api_gateway_templates/cloudwatch_logs_format.pol.tpl")
  }

  variables = {
    "health" = "/api-read-master/lotus/debug/metrics"
    "rpc_v0" = "api-read/cache/rpc/v0"
    "rpc_v1" = "api-read/cache/rpc/v1"
  }

  depends_on = [
    aws_iam_role_policy_attachment.account_logging_mainnet
  ]
}

resource "aws_cloudwatch_log_group" "mainnet" {
  count             = local.is_mainnet_envs
  name              = "${module.generator.prefix}-${aws_api_gateway_rest_api.main.id}/mainnet"
  retention_in_days = 30

  tags = module.generator.common_tags
}

resource "aws_api_gateway_base_path_mapping" "mainnet" {
  count       = local.is_mainnet_envs
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.mainnet[0].stage_name
  domain_name = aws_api_gateway_domain_name.node_glif_io[0].domain_name
}

resource "aws_api_gateway_domain_name" "node_glif_io" {
  count                    = local.is_mainnet_envs
  regional_certificate_arn = aws_acm_certificate.api_gw_acm_mainnet[0].arn
  domain_name              = "api-internal.node.glif.io"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}

resource "aws_acm_certificate" "api_gw_acm_mainnet" {
  count       = local.is_mainnet_envs
  domain_name = "api-internal.node.glif.io"
  subject_alternative_names = [
    "api.node.glif.io",
    "*.node.glif.io"
  ]
  validation_method = "DNS"

  tags = module.generator.common_tags
}
resource "aws_api_gateway_client_certificate" "mainnet" {
  count       = local.is_mainnet_envs
  description = "${module.generator.prefix} certificate for stage ${var.environment}"
  tags        = module.generator.common_tags
}

resource "aws_api_gateway_method_settings" "path_specific_mainnet" {
  count       = local.is_mainnet_envs
  rest_api_id = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.mainnet[0].stage_name
  method_path = "dev/POST"

  settings {
    metrics_enabled        = true
    logging_level          = "INFO"
    throttling_rate_limit  = "1000"
    throttling_burst_limit = "5000"
  }
}
