resource "aws_sns_topic" "notif" {
  count = local.enable_notifications

  name = "${aws_codebuild_project.codebuild.name}-sns"
}

data "aws_iam_policy_document" "sns_access" {
  count = local.enable_notifications

  statement {
    actions = ["sns:Publish"]

    principals {
      type        = "Service"
      identifiers = ["codestar-notifications.amazonaws.com"]
    }

    resources = [aws_sns_topic.notif[0].arn]
  }
}

resource "aws_sns_topic_policy" "default" {
  count = local.enable_notifications

  arn    = aws_sns_topic.notif[0].arn
  policy = data.aws_iam_policy_document.sns_access[0].json
}

resource "aws_sns_topic_subscription" "slack_notif" {
  count = local.enable_notifications

  topic_arn = aws_sns_topic.notif[0].arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.slack_notif[0].arn
}