resource "aws_secretsmanager_secret" "default" {
  name = local.aws_secret_name

  recovery_window_in_days = 30

  tags = merge(module.generator.common_tags, {
    "Name" = local.aws_secret_name
  })
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = local.secret_string

  lifecycle {
    ignore_changes = [
      secret_string
    ]
  }
}
