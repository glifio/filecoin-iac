resource "aws_secretsmanager_secret" "rds_credentials" {
  name                    = "${var.resource_prefix}-rds-credentals"
  recovery_window_in_days = 30

  tags = merge(var.common_tags, {
    Name = "${var.resource_prefix}-rds-credentials"
  })
}
