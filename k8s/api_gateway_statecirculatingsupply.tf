

####### START BLOCK statecirculatingsupply ########

resource "aws_api_gateway_resource" "statecirculatingsupply" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_rest_api.main.root_resource_id
  path_part   = "statecirculatingsupply"
}

resource "aws_api_gateway_method" "statecirculatingsupply_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.statecirculatingsupply.id
  http_method   = "GET"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "statecirculatingsupply_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.statecirculatingsupply.id
  http_method             = aws_api_gateway_method.statecirculatingsupply_get.http_method
  integration_http_method = "POST"
  type                    = "HTTP"
  passthrough_behavior    = "WHEN_NO_MATCH"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.main.id
  uri                     = "${local.make_internal_lb_domain_name}/${base64decode("JHtzdGFnZVZhcmlhYmxlcy5ycGNfdjB9")}"
  request_templates = {
    "application/json" = file("${path.module}/configs/api_gateway_templates/statecirculatingsupply_request.pol.tpl")
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code         = "200"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_get_200.status_code
  response_parameters = {}
  response_templates = {
    "application/json" = file("${path.module}/configs/api_gateway_templates/statecirculatingsupply_get_responce.pol.tpl")
  }
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_get_404" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.statecirculatingsupply.id
  http_method = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code = "404"
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_get_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_get_404.status_code
  selection_pattern   = "4\\d{2}"
  response_parameters = {}
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_get_503" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.statecirculatingsupply.id
  http_method = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_get_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_get_503.status_code
  selection_pattern   = "5\\d{2}"
  response_parameters = {}
}

resource "aws_api_gateway_resource" "statecirculatingsupply_fil" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.statecirculatingsupply.id
  path_part   = "fil"
}

resource "aws_api_gateway_method" "statecirculatingsupply_fil_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "statecirculatingsupply_fil_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method             = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  integration_http_method = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  type                    = "HTTP"
  uri                     = "https://circulatingsupply-prod.s3.amazonaws.com/index.html"
  request_templates = {
    "application/json" = ""
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_fil_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code         = "200"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_fil_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_fil_get_200.status_code
  response_parameters = {}
  response_templates = {
    "application/json" = ""
  }
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_fil_get_404" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code = "404"
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_fil_get_404" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_fil_get_404.status_code
  selection_pattern   = "4\\d{2}"
  response_parameters = {}
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_fil_get_503" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  resource_id = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code = "503"
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_fil_get_503" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_fil_get_503.status_code
  selection_pattern   = "5\\d{2}"
  response_parameters = {}
}



resource "aws_api_gateway_resource" "statecirculatingsupply_fil_v2" {
  rest_api_id = aws_api_gateway_rest_api.main.id
  parent_id   = aws_api_gateway_resource.statecirculatingsupply_fil.id
  path_part   = "v2"
}


resource "aws_api_gateway_method" "statecirculatingsupply_fil_v2_get" {
  rest_api_id   = aws_api_gateway_rest_api.main.id
  resource_id   = aws_api_gateway_resource.statecirculatingsupply_fil_v2.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "statecirculatingsupply_fil_v2_get" {
  rest_api_id             = aws_api_gateway_rest_api.main.id
  resource_id             = aws_api_gateway_resource.statecirculatingsupply_fil_v2.id
  http_method             = aws_api_gateway_method.statecirculatingsupply_fil_v2_get.http_method
  integration_http_method = aws_api_gateway_method.statecirculatingsupply_fil_v2_get.http_method
  passthrough_behavior    = "WHEN_NO_MATCH"
  type                    = "HTTP"
  uri                     = "https://circulatingsupply-staging.s3.amazonaws.com/index.html"
  request_templates = {
    "application/json" = ""
  }
  timeout_milliseconds = "29000"
}

resource "aws_api_gateway_method_response" "statecirculatingsupply_fil_v2_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil_v2.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_v2_get.http_method
  status_code         = "200"
  response_parameters = {}
}

resource "aws_api_gateway_integration_response" "statecirculatingsupply_fil_v2_get_200" {
  rest_api_id         = aws_api_gateway_rest_api.main.id
  resource_id         = aws_api_gateway_resource.statecirculatingsupply_fil_v2.id
  http_method         = aws_api_gateway_method.statecirculatingsupply_fil_v2_get.http_method
  status_code         = aws_api_gateway_method_response.statecirculatingsupply_fil_v2_get_200.status_code
  response_parameters = {}
  response_templates = {
    "application/json" = ""
  }
}

####### END BLOCK statecirculatingsupply ########
