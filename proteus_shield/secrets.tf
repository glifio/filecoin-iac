# postgres secrets

resource "aws_secretsmanager_secret" "postgres" {
  name                    = "${local.resource_prefix}-postgres"
  recovery_window_in_days = 30

  tags = merge(var.common_tags, {
    Name = "${local.resource_prefix}-postgres"
  })
}

resource "aws_secretsmanager_secret" "redis" {
  name                    = "${local.resource_prefix}-redis"
  recovery_window_in_days = 30

  tags = merge(var.common_tags, {
    Name = "${local.resource_prefix}-redis"
  })
}

resource "aws_secretsmanager_secret" "influx" {
  name                    = "${local.resource_prefix}-influx"
  recovery_window_in_days = 30

  tags = merge(var.common_tags, {
    Name = "${local.resource_prefix}-influx"
  })
}

resource "aws_secretsmanager_secret" "auth" {
  name                    = "${local.resource_prefix}-auth"
  recovery_window_in_days = 30

  tags = merge(var.common_tags, {
    Name = "${local.resource_prefix}-auth"
  })
}
