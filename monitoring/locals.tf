locals {
  dev_count_map = {
    dev     = 1
    mainnet = 0
  }

  development = local.dev_count_map[var.environment]
  production  = abs(local.dev_count_map[var.environment] - 1)

  aws_eks_cluster_name = "${module.generator.prefix}-eks"

  ingress_class    = "kong-external-lb"
  ingress_class_lb = "${module.generator.prefix}-kong-external"

  route53_hosted_zone_map = {
    dev     = "dev.node.glif.io"
    mainnet = "node.glif.io"
  }

  route53_hosted_zone = local.route53_hosted_zone_map[var.environment]

  monitoring = {
    slack = {
      api_url = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["slack_api_url"]
      channel = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["slack_configs_0_channel"]
    }

    admin_password = jsondecode(data.aws_secretsmanager_secret_version.monitoring.secret_string)["admin_password"]

    pvc_size = "100Gi"
  }
}
