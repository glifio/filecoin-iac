resource "aws_api_gateway_rest_api" "main" {
  name                     = "${module.generator.prefix}-apigw"
  description              = "API gateway from a ${var.environment} environment"
  minimum_compression_size = 0

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}







# VPC Link is accosiated with EKS Internal ELB dev (testnet) cluaster
resource "aws_api_gateway_vpc_link" "main" {
  name        = "${module.generator.prefix}-vpc-link"
  description = "From ${module.generator.prefix} env to internal lb"
  target_arns = [data.aws_lb.kong_internal.arn]

  tags = merge({ "Name" = "${module.generator.prefix}-vpc-link" }, module.generator.common_tags)


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
  description  = "${module.generator.prefix}-model"
  content_type = "application/json"

  schema = file("${path.module}/configs/api_gateway_models/read_all_and_write_mpool_push.pol.tpl")
}

# Note: https://github.com/hashicorp/terraform-provider-aws/issues/2550#issuecomment-402369701
resource "aws_api_gateway_request_validator" "main" {
  name                        = "${module.generator.prefix}-validate-all-parameters"
  rest_api_id                 = aws_api_gateway_rest_api.main.id
  validate_request_body       = true
  validate_request_parameters = true
}


resource "aws_api_gateway_account" "account_logging_dev" {
  count               = local.is_dev_envs
  cloudwatch_role_arn = aws_iam_role.account_logging_dev[0].arn
}

resource "aws_iam_role" "account_logging_dev" {
  count              = local.is_dev_envs
  name               = "${module.generator.prefix}-apigw-logging"
  assume_role_policy = file("${path.module}/templates/roles/cloudwatch_apigw_logging.pol.tpl")

  tags = module.generator.common_tags
}



resource "aws_iam_policy" "account_logging" {
  name        = "${module.generator.prefix}-apigw-logging"
  description = ""
  policy      = file("${path.module}/templates/policies/cloudwatch_apigw_logging.pol.tpl")

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "account_logging_dev" {
  count      = local.is_dev_envs
  role       = aws_iam_role.account_logging_dev[0].name
  policy_arn = aws_iam_policy.account_logging.arn
}


resource "aws_api_gateway_account" "account_logging_mainnet" {
  count               = local.is_mainnet_envs
  cloudwatch_role_arn = aws_iam_role.account_logging_mainnet[0].arn
}

resource "aws_iam_role" "account_logging_mainnet" {
  count              = local.is_mainnet_envs
  name               = "${module.generator.prefix}-apigw-logging"
  assume_role_policy = file("${path.module}/templates/roles/cloudwatch_apigw_logging.pol.tpl")

  tags = module.generator.common_tags
}

resource "aws_iam_role_policy_attachment" "account_logging_mainnet" {
  count      = local.is_mainnet_envs
  role       = aws_iam_role.account_logging_mainnet[0].name
  policy_arn = aws_iam_policy.account_logging.arn
}
