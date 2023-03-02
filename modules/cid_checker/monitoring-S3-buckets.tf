# Create a log group for lambda function. #

resource "aws_cloudwatch_log_group" "main" {
  name = "/aws/lambda/${aws_lambda_function.main.function_name}"
}

# Create a lambda function for checking s3 bucket updates. #

resource "aws_lambda_function" "main" {
  filename      = "${path.module}/templates/config/index.zip"
  function_name = "LogS3DataEvents-${var.bucket_name}"
  role          =  aws_iam_role.log-s3-lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs16.x"
}

# Create permission to access s3  for the lambda function. #

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.main.arn
}

# Create a separate topic for every s3 with a general email endpoint.  #

resource "aws_sns_topic" "main" {
  name = "s3-${var.bucket_name}-event-notification"

  policy = templatefile("${path.module}/templates/policies/sns_topic_policy.pol.tpl", {
    topic_name = "s3-${var.bucket_name}-event-notification"
    account_id = data.aws_caller_identity.current.id
    })
}

resource "aws_sns_topic_subscription" "main" {
  topic_arn = aws_sns_topic.main.arn
  protocol  = "email"
  endpoint  = "1658_filecoin_cid@protofire.io"
}

# Every time when s3 updates, is triggered the lambda function. #

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.main.id
  eventbridge = true

  lambda_function {
    lambda_function_arn = aws_lambda_function.main.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}

# Create cloudwatch metric filter for log group lambda function. #

resource "aws_cloudwatch_log_metric_filter" "metric_filter" {
  depends_on = [aws_lambda_function.main]
  log_group_name = aws_cloudwatch_log_group.main.name

  metric_transformation {
    name          = aws_cloudwatch_metric_alarm.main.metric_name
    namespace     = aws_lambda_function.main.function_name
    value         = "1"
    default_value = "0"
  }

  name    = "s3-${var.bucket_name}-file-updated-count"
  pattern = "FILE UPDATED"
}

# Create cloudwatch metric alarm when s3 wasn't updated. #

resource "aws_cloudwatch_metric_alarm" "main" {
  alarm_name          = "s3 ${var.bucket_name} file was not updated"
  alarm_description   = "File s3 ${var.bucket_name} wasn't updated for 6 hours"
  metric_name         = "s3-${var.bucket_name}-file-updated-count"
  namespace           = aws_lambda_function.main.function_name
  period              = "21600"
  comparison_operator = "LessThanOrEqualToThreshold"
  statistic           = "Sum"
  treat_missing_data  = "breaching"
  actions_enabled     = "true"
  datapoints_to_alarm = "1"
  alarm_actions       = [aws_sns_topic.main.arn]
  ok_actions          = [aws_sns_topic.main.arn]
  insufficient_data_actions = [aws_sns_topic.main.arn]
  evaluation_periods  = "1"
}