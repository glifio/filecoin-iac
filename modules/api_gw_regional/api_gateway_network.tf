resource "aws_api_gateway_domain_name" "main" {
  regional_certificate_arn = aws_acm_certificate_validation.acm.certificate_arn
  domain_name              = var.api_gateway_domain_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}

resource "aws_api_gateway_base_path_mapping" "main" {
  api_id      = aws_api_gateway_rest_api.main.id
  stage_name  = aws_api_gateway_stage.main.stage_name
  domain_name = aws_api_gateway_domain_name.main.domain_name
}

resource "aws_api_gateway_client_certificate" "main" {
  description = "${module.generator.prefix} certificate for stage ${var.get_stage_name}"
  tags        = module.generator.common_tags
}

resource "aws_api_gateway_vpc_link" "main" {
  name        = "${module.generator.prefix}-${var.get_stage_name}-vpc-link"
  description = "From ${module.generator.prefix} env to internal lb"
  target_arns = var.get_vpc_link_arns

  tags = merge({ "Name" = "${module.generator.prefix}-${var.get_stage_name}-vpc-link" }, module.generator.common_tags)


}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.main.id

  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_integration.root_get,
      aws_api_gateway_integration.root_options,
      aws_api_gateway_integration.root_post,
      aws_api_gateway_integration.dilutedsupply_get,
      aws_api_gateway_integration.rpc_v0_get,
      aws_api_gateway_integration.rpc_v0_options,
      aws_api_gateway_integration.rpc_v0_post,
      aws_api_gateway_integration.rpc_v1_get,
      aws_api_gateway_integration.rpc_v1_options,
      aws_api_gateway_integration.rpc_v1_post,
      aws_api_gateway_integration.statecirculatingsupply_get,
      aws_api_gateway_integration.statecirculatingsupply_fil_get,
      aws_api_gateway_method.root_get,
      aws_api_gateway_method.root_options,
      aws_api_gateway_method.root_post,
      aws_api_gateway_method.dilutedsupply_get,
      aws_api_gateway_method.rpc_v0_get,
      aws_api_gateway_method.rpc_v0_options,
      aws_api_gateway_method.rpc_v0_post,
      aws_api_gateway_method.rpc_v1_get,
      aws_api_gateway_method.rpc_v1_options,
      aws_api_gateway_method.rpc_v1_post,
      aws_api_gateway_method.statecirculatingsupply_get,
      aws_api_gateway_method.statecirculatingsupply_fil_get
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_model" "ReadAllandWriteMpoolPush" {
  rest_api_id  = aws_api_gateway_rest_api.main.id
  name         = "ReadAllandWriteMpoolPush"
  description  = "${module.generator.prefix}-${var.get_stage_name}-model"
  content_type = "application/json"

  schema = file("${path.module}/configs/api_gateway_models/read_all_and_write_mpool_push.pol.tpl")
}

# Note: https://github.com/hashicorp/terraform-provider-aws/issues/2550#issuecomment-402369701
resource "aws_api_gateway_request_validator" "main" {
  name                        = "${module.generator.prefix}-${var.get_stage_name}-validate-all-parameters"
  rest_api_id                 = aws_api_gateway_rest_api.main.id
  validate_request_body       = true
  validate_request_parameters = true
}


resource "aws_api_gateway_stage" "main" {
  deployment_id         = aws_api_gateway_deployment.main.id
  rest_api_id           = aws_api_gateway_rest_api.main.id
  stage_name            = var.get_stage_name
  client_certificate_id = aws_api_gateway_client_certificate.main.id

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.main.arn
    format          = file("${path.module}/configs/api_gateway_templates/cloudwatch_logs_format.pol.tpl")
  }

  variables = {
    "health" = "/api-read-dev/lotus/debug/metrics"
  }

  depends_on = [
    aws_iam_role_policy_attachment.account_logging
  ]
}

resource "aws_cloudwatch_log_group" "main" {
  name              = "${module.generator.prefix}-${aws_api_gateway_rest_api.main.id}/${var.get_stage_name}"
  retention_in_days = 30

  tags = module.generator.common_tags
}


resource "aws_api_gateway_account" "account_logging" {
  cloudwatch_role_arn = aws_iam_role.account_logging.arn
}

resource "aws_iam_role" "account_logging" {
  name               = "${module.generator.prefix}-${var.get_stage_name}-apigw-logging"
  assume_role_policy = file("${path.module}/templates/roles/cloudwatch_apigw_logging.pol.tpl")

  tags = module.generator.common_tags
}



resource "aws_iam_policy" "account_logging" {
  name        = "${module.generator.prefix}-${var.get_stage_name}-apigw-logging"
  description = ""
  policy      = file("${path.module}/templates/policies/cloudwatch_apigw_logging.pol.tpl")

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "account_logging" {
  role       = aws_iam_role.account_logging.name
  policy_arn = aws_iam_policy.account_logging.arn
}
