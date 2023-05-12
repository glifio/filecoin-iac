data "aws_secretsmanager_secret" "ovh_cloud_credentials" {
  name = "${module.generator.prefix}/ovh-cloud-credentials"
}

data "aws_secretsmanager_secret_version" "ovh_cloud_credentials" {
  secret_id = data.aws_secretsmanager_secret.ovh_cloud_credentials.id
}
