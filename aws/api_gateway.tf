resource "aws_api_gateway_rest_api" "main" {
  name                     = "${module.generator.prefix}-api-gw"
  description              = "API gateway from a ${var.environment} environment"
  minimum_compression_size = 0

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = module.generator.common_tags
}
