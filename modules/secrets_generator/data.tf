data "external" "secret" {
  program = ["python3", "${path.module}/scripts/generator.py"]
}

data "aws_secretsmanager_secret" "from" {
  count = local.from_secret_count
  name  = local.from_secret_name
}

data "aws_secretsmanager_secret_version" "from" {
  count     = local.from_secret_count
  secret_id = data.aws_secretsmanager_secret.from[0].id
}
