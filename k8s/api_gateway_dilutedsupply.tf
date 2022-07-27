####### START BLOCK dilutedsupply ########
resource "aws_api_gateway_resource" "dilutedsupply" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "dilutedsupply"
}

resource "aws_api_gateway_method" "dilutedsupply_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.dilutedsupply.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "dilutedsupply_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.dilutedsupply.id
  http_method             = aws_api_gateway_method.dilutedsupply_get.http_method
  type                    = "HTTP"
  integration_http_method = "GET"
  uri                     = var.http_endpoint_uri
  timeout_milliseconds    = "29000"
}

resource "aws_api_gateway_method_response" "dilutedsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = "200"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "dilutedsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = aws_api_gateway_method_response.dilutedsupply_get_200.status_code
  response_parameters = {}
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "dilutedsupply_get_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = "404"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "dilutedsupply_get_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = aws_api_gateway_method_response.dilutedsupply_get_404.status_code
  response_parameters = {}
  selection_pattern   = "4\\d{2}"
}

resource "aws_api_gateway_method_response" "dilutedsupply_get_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = "503"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "dilutedsupply_get_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.dilutedsupply.id
  http_method         = aws_api_gateway_method.dilutedsupply_get.http_method
  status_code         = aws_api_gateway_method_response.dilutedsupply_get_503.status_code
  response_parameters = {}
  selection_pattern   = "5\\d{2}"
}
####### END BLOCK dilutedsupply ########
