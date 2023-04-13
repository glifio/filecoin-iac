resource "aws_secretsmanager_secret" "default" {
  name                    = "${module.generator.prefix}/uptimerobot-cache"
  recovery_window_in_days = 30

  tags = merge(
    { "Name" = "${module.generator.prefix}/uptimerobot-cache" },
    module.generator.common_tags
  )
}
