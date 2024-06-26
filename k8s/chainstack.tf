
# lambda function  resources #

resource "aws_iam_role" "role_for_lambda" {
  count              = local.is_prod_envs
  name               = "role_for_lambda_check_status_code_mainnet"
  assume_role_policy = file("${path.module}/templates/roles/role_for_lambda.pol.tpl")
}

resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRole" {
  count      = local.is_prod_envs
  role       = aws_iam_role.role_for_lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


data "archive_file" "index" {
  count       = local.is_prod_envs
  type        = "zip"
  source_file = "${path.module}/configs/lambda-failover/chainstack.js"
  output_path = "${path.module}/configs/lambda-failover/chainstack.zip"
}

resource "aws_lambda_function" "check_health_code" {
  count            = local.is_prod_envs
  function_name    = "check_status_code_mainnet_chainstack"
  role             = aws_iam_role.role_for_lambda[0].arn
  handler          = "chainstack.handler"
  filename         = "${path.module}/configs/lambda-failover/chainstack.zip"
  runtime          = "nodejs14.x"
  timeout          = 300
  source_code_hash = data.archive_file.index[0].output_base64sha256
}

# cloudwatch metric/alarm resources #

resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  count = local.is_prod_envs

  metric_transformation {
    name          = "Health_check_for_mainnet_status_code_200"
    namespace     = "check_health_code"
    value         = "1"
    default_value = "0"
  }

  name           = "Health_check_for_mainnet_status_code_200"
  pattern        = "{ $.statusCode =\"200\"}"
  log_group_name = "/aws/lambda/${aws_lambda_function.check_health_code[0].function_name}"
}

resource "aws_cloudwatch_metric_alarm" "main" {
  count               = local.is_prod_envs
  alarm_name          = "Health check for mainnet statusCode = 200"
  alarm_description   = "HTTPS POST request is successful. Status: ok, status code: 200"
  comparison_operator = "LessThanThreshold"
  metric_name         = "Health_check_for_mainnet_status_code_200"
  namespace           = "check_health_code"
  period              = 120
  statistic           = "Sum"
  evaluation_periods  = 1
  threshold           = 1
  treat_missing_data  = "breaching"
  datapoints_to_alarm = 1

}

# cloudwatch rule resources #
resource "aws_cloudwatch_event_rule" "main" {
  count               = local.is_prod_envs
  name                = "check_status_code_mainnet_chainstack"
  event_bus_name      = "default"
  schedule_expression = "rate(2 minutes)"
}

resource "aws_cloudwatch_event_target" "main" {
  count = local.is_prod_envs
  arn   = aws_lambda_function.check_health_code[0].arn
  rule  = aws_cloudwatch_event_rule.main[0].name
  input = "{\"commands\":[\"test\"]}"
}

resource "aws_lambda_permission" "main" {
  count         = local.is_prod_envs
  statement_id  = "check_status_code_mainnet_chainstack"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.check_health_code[0].function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.main[0].arn
}



module "ingress_strictly_mainnet_node_glif_io" {
  count  = local.is_prod_envs
  name   = "strictly-mainnet-node-glif-io"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "strictly.node.glif.io"
  http_path = "/(.*)"

  service_name  = "api-read-master-lotus-service"
  service_port  = 1234
  ingress_class = "kong-external-lb"

  enable_path_transformer = true
  enable_access_control   = false
  enable_return_json      = true
}


resource "kubernetes_service" "chainstack" {
  count = local.is_prod_envs
  metadata {
    name      = "chainstack-service"
    namespace = "network"

    annotations = {
      "konghq.com/host-header" = "filecoin-mainnet.chainstacklabs.com"
    }
  }

  spec {
    port {
      name     = "http"
      protocol = "TCP"
      port     = 80
    }
    port {
      name     = "https"
      protocol = "TCP"
      port     = 443
    }
    type          = "ExternalName"
    external_name = "filecoin-mainnet.chainstacklabs.com"
  }
}

resource "aws_route53_health_check" "health_check_healthy_mainnet" {
  count                           = local.is_prod_envs
  type                            = "CLOUDWATCH_METRIC"
  cloudwatch_alarm_name           = "Health check for mainnet statusCode = 200"
  cloudwatch_alarm_region         = var.region
  insufficient_data_health_status = "Healthy"
}
