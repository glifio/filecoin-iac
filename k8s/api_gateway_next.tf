####### START BLOCK vmcirculatingsupply ########

resource "aws_api_gateway_resource" "next" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "{_next+}"
}

resource "aws_api_gateway_method" "next_any" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.next.id
  http_method   = "ANY"
  authorization = "NONE"

  request_parameters = {
    "method.request.path._next" = true
  }
}

resource "aws_api_gateway_integration" "next_any" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.next.id
  http_method             = aws_api_gateway_method.next_any.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "https://node.glif.link/{_next}"
  request_parameters = {
    "integration.request.path._next" = "method.request.path._next"
  }

  cache_key_parameters = [
    "method.request.path._next",
  ]

  timeout_milliseconds = "29000"
}
