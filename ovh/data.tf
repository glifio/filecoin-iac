data "aws_secretsmanager_secret" "ovh_cloud_credentials" {
  name = "${module.generator.prefix}/ovh-cloud-credentials"
}

data "aws_secretsmanager_secret_version" "ovh_cloud_credentials" {
  secret_id = data.aws_secretsmanager_secret.ovh_cloud_credentials.id
}

data "aws_secretsmanager_secret" "monitoring" {
  name = "${module.generator.prefix}-monitoring"
}

data "aws_secretsmanager_secret_version" "monitoring" {
  secret_id = data.aws_secretsmanager_secret.monitoring.id
}
