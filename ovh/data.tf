data "aws_secretsmanager_secret" "ovh_cloud_credentials" {
  count = local.production
  name  = "${module.generator.prefix}/ovh-cloud-credentials"
}

data "aws_secretsmanager_secret_version" "ovh_cloud_credentials" {
  count     = local.production
  secret_id = data.aws_secretsmanager_secret.ovh_cloud_credentials[0].id
}
