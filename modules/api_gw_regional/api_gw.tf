resource "aws_api_gateway_rest_api" "main" {
  name                     = "${module.generator.prefix}-${var.get_stage_name}"
  description              = "API gateway from a ${local.get_environment} environment"
  minimum_compression_size = 0

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}
