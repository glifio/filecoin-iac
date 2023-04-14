resource "aws_cloudwatch_event_rule" "default" {
  name                = "${module.generator.prefix}-cache-uptimerobot"
  event_bus_name      = "default"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "default" {
  for_each = toset(["mainnet", "calibration", "hyperspace"])

  rule = aws_cloudwatch_event_rule.default.name

  arn   = aws_lambda_function.default.arn
  input = "{\"network\": \"${each.key}\"}"

  retry_policy {
    maximum_retry_attempts       = 3
    maximum_event_age_in_seconds = 86400
  }
}
