locals {
  dev_count_map = {
    ipc_ovh_development = 1
    ipc_ovh_production  = 0
  }

  development = local.dev_count_map[terraform.workspace]
  production  = abs(local.dev_count_map[terraform.workspace] - 1)

  application_key    = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials[0].secret_string)["application_key"]
  application_secret = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials[0].secret_string)["application_secret"]
  consumer_key       = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials[0].secret_string)["consumer_key"]
  service_name       = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials[0].secret_string)["service_name"]
  endpoint           = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials[0].secret_string)["endpoint"]
}
