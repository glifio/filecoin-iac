resource "aws_budgets_budget" "main" {
  count             = local.is_prod_envs
  name              = "filecoin-dev_costs_budget"
  budget_type       = "COST"
  limit_amount      = "24500"
  limit_unit        = "USD"
  time_period_start = "2022-06-01_00:00"
  time_period_end   = "2032-06-01_00:00"
  time_unit         = "MONTHLY"

  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 50
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["1679_dev@protofire.io"]
    subscriber_sns_topic_arns  = [aws_sns_topic.budgets_alarm_topic[0].arn]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 90
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["1679_dev@protofire.io"]
    subscriber_sns_topic_arns  = [aws_sns_topic.budgets_alarm_topic[0].arn]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 95
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = ["1679_dev@protofire.io"]
    subscriber_sns_topic_arns  = [aws_sns_topic.budgets_alarm_topic[0].arn]
  }
}


resource "aws_budgets_budget" "daily_budget" {
  count             = local.is_prod_envs
  name              = "daily-budget"
  budget_type       = "COST"
  limit_amount      = "1000"
  limit_unit        = "USD"
  time_period_end   = "2032-07-05_00:00"
  time_period_start = "2023-07-05_00:00"
  time_unit         = "DAILY"


  cost_types {
    include_credit             = true
    include_discount           = true
    include_other_subscription = true
    include_recurring          = true
    include_refund             = true
    include_subscription       = true
    include_support            = true
    include_tax                = true
    include_upfront            = true
    use_amortized              = false
    use_blended                = false
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_sns_topic_arns = [aws_sns_topic.budgets_alarm_topic[0].arn]
  }
}