data "archive_file" "default" {
  type        = "zip"
  source_file = "${path.module}/lambda/index.js"
  output_path = "${path.module}/lambda/index.zip"
}

resource "aws_lambda_function" "default" {
  function_name = "${module.generator.prefix}-uptimerobot-cacher"
  role          = aws_iam_role.lambda_default.arn

  filename         = data.archive_file.default.output_path
  source_code_hash = data.archive_file.default.output_base64sha256

  runtime = "nodejs12.x"
  handler = "index.handler"
  timeout = 300

  environment {
    variables = {
      API_KEY_HYPERSPACE  = jsondecode(data.aws_secretsmanager_secret_version.default.secret_string)["api_key_hyperspace"]
      API_KEY_CALIBRATION = jsondecode(data.aws_secretsmanager_secret_version.default.secret_string)["api_key_calibration"]
      API_KEY_MAINNET     = jsondecode(data.aws_secretsmanager_secret_version.default.secret_string)["api_key_mainnet"]
      BUCKET_NAME         = var.bucket_name
    }
  }
}

resource "aws_lambda_permission" "default" {
  statement_id  = "${module.generator.prefix}-allow-cloudwatch-events"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.default.arn
}
