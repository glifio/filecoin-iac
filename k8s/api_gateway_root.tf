####### START BLOCK ROOT ########

resource "aws_api_gateway_method" "root_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_rest_api.main.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_rest_api.main.root_resource_id
  http_method             = aws_api_gateway_method.root_get.http_method
  type                    = "HTTP"
  integration_http_method = "GET"
  uri                     = var.http_endpoint_uri
  timeout_milliseconds    = "29000"
}

resource "aws_api_gateway_method_response" "root_get" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_rest_api.main.root_resource_id
  http_method         = aws_api_gateway_method.root_get.http_method
  status_code         = "200"
  response_parameters = { "method.response.header.Content-Type" = true }
}

resource "aws_api_gateway_integration_response" "root_get" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_rest_api.main.root_resource_id
  http_method         = aws_api_gateway_method.root_get.http_method
  status_code         = aws_api_gateway_method_response.root_get.status_code
  response_parameters = { "method.response.header.Content-Type" = "'text/html'" }
}

resource "aws_api_gateway_method" "root_options" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_rest_api.main.root_resource_id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "root_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_options.http_method
  type        = "MOCK"
  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "root_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_options.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "root_options" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_options.http_method
  status_code = aws_api_gateway_method_response.root_get.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method" "root_post" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_rest_api.main.root_resource_id
  http_method   = "POST"
  authorization = "NONE"

  request_parameters = {
    "method.request.header.Content-Type" = true
  }
  request_models = {
    "application/json" = aws_api_gateway_model.ReadAllandWriteMpoolPush.name
  }
  request_validator_id = aws_api_gateway_request_validator.main.id
}



resource "aws_api_gateway_integration" "root_post" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_rest_api.main.root_resource_id
  http_method             = aws_api_gateway_method.root_post.http_method
  integration_http_method = aws_api_gateway_method.root_post.http_method
  passthrough_behavior    = "NEVER"
  type                    = "HTTP"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id
  uri                     = "${local.make_internal_lb_domain_name}/${base64decode("JHtzdGFnZVZhcmlhYmxlcy5ycGNfdjB9")}"
  request_templates = {
    "application/json"               = ""
    "application/json;charset=UTF-8" = ""
    "application/json;charset=utf-8" = ""
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "root_post_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_post.http_method
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "root_post_200" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_post.http_method
  status_code = aws_api_gateway_method_response.root_post_200.status_code
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "root_post_404" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_post.http_method
  status_code = "404"
}

resource "aws_api_gateway_integration_response" "root_post_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_rest_api.main.root_resource_id
  http_method         = aws_api_gateway_method.root_post.http_method
  status_code         = aws_api_gateway_method_response.root_post_404.status_code
  selection_pattern   = "4\\d{2}"
  response_parameters = {}
}

resource "aws_api_gateway_method_response" "root_post_503" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_rest_api.main.root_resource_id
  http_method = aws_api_gateway_method.root_post.http_method
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "root_post_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_rest_api.main.root_resource_id
  http_method         = aws_api_gateway_method.root_post.http_method
  status_code         = aws_api_gateway_method_response.root_post_503.status_code
  selection_pattern   = "5\\d{2}"
  response_parameters = {}
}
####### END BLOCK ROOT ########
