resource "aws_lambda_permission" "sns" {
  count = local.enable_notifications

  statement_id  = "${aws_codebuild_project.codebuild.name}-allow-sns"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.slack_notif[0].function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.notif[0].arn
}

data "archive_file" "slack_notif" {
  count = local.enable_notifications

  type        = "zip"
  source_file = "${path.module}/lambda/slack_notification.py"
  output_path = "${path.module}/lambda/slack_notification.zip"
}

resource "aws_lambda_function" "slack_notif" {
  count = local.enable_notifications

  function_name    = "${aws_codebuild_project.codebuild.name}-slack-notif"
  filename         = "${path.module}/lambda/slack_notification.zip"
  source_code_hash = data.archive_file.slack_notif[0].output_base64sha256
  role             = aws_iam_role.slack_notif[0].arn
  runtime          = "python3.8"
  handler          = "slack_notification.handler"
  timeout          = 10

  environment {
    variables = {
        "WEBHOOK_URL" = lookup(jsondecode(data.aws_secretsmanager_secret_version.slack_monitoring_dev_channel[0].secret_string), "webhook_url", null)
        "CHANNEL_NAME" = lookup(jsondecode(data.aws_secretsmanager_secret_version.slack_monitoring_dev_channel[0].secret_string), "channel_name", null)
    }
  }
}

resource "aws_iam_role" "slack_notif" {
  count = local.enable_notifications

  name               = "${aws_codebuild_project.codebuild.name}-slack-notif-role"
  assume_role_policy = data.aws_iam_policy_document.slack_notif[0].json
}

data "aws_iam_policy_document" "slack_notif" {
  count = local.enable_notifications

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "slack_notif" {
  count = local.enable_notifications

  role       = aws_iam_role.slack_notif[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}