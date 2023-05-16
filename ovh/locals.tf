locals {
  dev_count_map = {
    ipc_ovh_development = 1
    ipc_ovh_production  = 0
  }

  development = local.dev_count_map[terraform.workspace]
  production  = abs(local.dev_count_map[terraform.workspace] - 1)

  application_key    = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials.secret_string)["application_key"]
  application_secret = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials.secret_string)["application_secret"]
  consumer_key       = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials.secret_string)["consumer_key"]
  service_name       = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials.secret_string)["service_name"]
  endpoint           = jsondecode(data.aws_secretsmanager_secret_version.ovh_cloud_credentials.secret_string)["endpoint"]

  monitoring = {
    slack = {
      api_url = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["slack_api_url"]
      channel = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["slack_configs_0_channel"]
    }

    domain_name    = "ovh-monitoring.node.glif.io"
    admin_password = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["admin_password"]
    
    pvc_size = "100Gi"
  }

  external_dns = {
    name           = "external-dns"
    default_region = var.region
    namespace      = "default"
  }

  cert_manager = {
    name      = "letsencrypt"
    namespace = "default"
  }
}
