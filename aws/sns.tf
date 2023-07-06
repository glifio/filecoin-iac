resource "aws_sns_topic" "budgets_alarm_topic" {
  name = "budget-alarms-topic"

  tags = module.generator.common_tags
}

resource "aws_sns_topic_policy" "account_budgets_alarm_policy" {
  arn    = aws_sns_topic.budgets_alarm_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
	sid    = "AWSBudgetsSNSPublishingPermissions"
	effect = "Allow"

	actions = [
	  "SNS:Receive",
	  "SNS:Publish"
	]

	principals {
	  type        = "Service"
	  identifiers = ["budgets.amazonaws.com"]
	}

	resources = [
	  aws_sns_topic.budgets_alarm_topic.arn
	]
  }
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.budgets_alarm_topic.arn
  protocol  = "email"
  endpoint  = (lookup(jsondecode(data.aws_secretsmanager_secret_version.budget_alarm_slack.secret_string), "email", null))
}
