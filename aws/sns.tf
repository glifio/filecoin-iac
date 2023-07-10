resource "aws_sns_topic" "budgets_alarm_topic" {
  count = local.is_prod_envs
  name = "budget-alarms-topic"

  tags = module.generator.common_tags
}

resource "aws_sns_topic_policy" "account_budgets_alarm_policy" {
  count = local.is_prod_envs
  arn    = aws_sns_topic.budgets_alarm_topic[0].arn
  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count = local.is_prod_envs
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
	  aws_sns_topic.budgets_alarm_topic[0].arn
	]
  }
}

resource "aws_sns_topic_subscription" "email-target" {
  count = local.is_prod_envs
  topic_arn = aws_sns_topic.budgets_alarm_topic[0].arn
  protocol  = "email"
  endpoint  = (lookup(jsondecode(data.aws_secretsmanager_secret_version.budget_alarm_slack[0].secret_string), "email", null))
}
