####### START BLOCK vmcirculatingsupply ########

resource "aws_api_gateway_resource" "vmcirculatingsupply" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "vmcirculatingsupply"
}

resource "aws_api_gateway_method" "vmcirculatingsupply_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "vmcirculatingsupply_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method             = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id
  uri                     = "${local.make_internal_lb_domain_name}/${var.uri_service_endpoint_rpc_v0}"
  request_templates = {
    "application/json" = file("${path.module}/configs/api_gateway_templates/vmcirculatingsupply_get_request.pol.tpl")
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "vmcirculatingsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method         = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code         = "200"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "vmcirculatingsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method         = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.vmcirculatingsupply_get_200.status_code
  response_parameters = {}
  response_templates = {
    "application/json" = file("${path.module}/configs/api_gateway_templates/vmcirculatingsupply_get_200_responce.pol.tpl")
  }
}

resource "aws_api_gateway_method_response" "vmcirculatingsupply_get_404" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code = "404"
}

resource "aws_api_gateway_integration_response" "vmcirculatingsupply_get_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method         = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.vmcirculatingsupply_get_404.status_code
  selection_pattern   = "4\\d{2}"
  response_parameters = {}
}

resource "aws_api_gateway_method_response" "vmcirculatingsupply_get_503" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "vmcirculatingsupply_get_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.vmcirculatingsupply.id
  http_method         = aws_api_gateway_method.vmcirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.vmcirculatingsupply_get_503.status_code
  selection_pattern   = "5\\d{2}"
  response_parameters = {}
}
####### END BLOCK vmcirculatingsupply ########
