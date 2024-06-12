data "aws_caller_identity" "current" {}

data "aws_vpc" "current" {
  tags = { Name = "${module.generator.prefix}-vpc" }
}

data "aws_eks_cluster" "k8s_cluster" {
  name = terraform.workspace
}

data "aws_eks_cluster_auth" "k8s_cluster_auth" {
  name = terraform.workspace
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.current.id]
  }

  filter {
    name   = "tag:Name"
    values = ["${module.generator.prefix}-public*"]
  }
}

# data external load balancer

data "aws_lb" "kong_external" {
  tags = {
    Name = "${module.generator.prefix}-kong-external"
  }

  depends_on = [
    helm_release.konghq-external
  ]
}

data "aws_lb" "kong_drpc" {
  count = local.is_prod_envs

  tags = {
    Name = "${module.generator.prefix}-drpc"
  }
}

data "aws_route53_zone" "selected" {
  name         = var.route53_domain
  private_zone = false
}

data "aws_route53_zone" "node_glif_io" {
  name         = "node.glif.io"
  private_zone = false
}

data "aws_route53_zone" "dev_node_glif_io" {
  name         = "dev.node.glif.io"
  private_zone = false
}

data "aws_route53_zone" "filecoin_tools" {
  name         = "filecoin.tools"
  private_zone = false
}

data "aws_route53_zone" "api_chain_love" {
  name         = "api.chain.love"
  private_zone = false
}

data "aws_secretsmanager_secret" "calibrationapi_archive_node_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-calibrationapi-archive-node-lotus"
}

data "aws_secretsmanager_secret_version" "calibrationapi_archive_node_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.calibrationapi_archive_node_lotus[0].id
}

data "aws_secretsmanager_secret" "calibrationapi_0_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-calibrationapi-0-lotus"
}

data "aws_secretsmanager_secret_version" "calibrationapi_0_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.calibrationapi_0_lotus[0].id
}

data "aws_secretsmanager_secret" "api_read_dev_lotus" {
  count = local.is_dev_envs
  name  = "${module.generator.prefix}-api-read-dev-lotus"
}

data "aws_secretsmanager_secret_version" "api_read_dev_lotus" {
  count     = local.is_dev_envs
  secret_id = data.aws_secretsmanager_secret.api_read_dev_lotus[0].id
}

data "aws_secretsmanager_secret" "api_read_cache_dev" {
  count = local.is_dev_envs
  name  = "${module.generator.prefix}-api-read-cache-dev"
}

data "aws_secretsmanager_secret_version" "api_read_cache_dev" {
  count     = local.is_dev_envs
  secret_id = data.aws_secretsmanager_secret.api_read_cache_dev[0].id
}

data "aws_secretsmanager_secret" "monitoring" {
  name = "${module.generator.prefix}-monitoring"
}

data "aws_secretsmanager_secret_version" "monitoring" {
  secret_id = data.aws_secretsmanager_secret.monitoring.id
}

data "aws_secretsmanager_secret" "api_read_v0_cache_mainnet" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-api-read-v0-cache"
}

data "aws_secretsmanager_secret_version" "api_read_v0_cache_mainnet" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.api_read_v0_cache_mainnet[0].id
}

data "aws_secretsmanager_secret" "api_read_master_mainnet_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-api-read-master-lotus"
}

data "aws_secretsmanager_secret_version" "api_read_master_mainnet_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].id
}

data "aws_secretsmanager_secret" "space07_mainnet_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-space07-lotus"
}

data "aws_secretsmanager_secret_version" "space07_mainnet_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.space07_mainnet_lotus[0].id
}

data "aws_secretsmanager_secret" "fvm_archive_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-fvm-archive-lotus"
}

data "aws_secretsmanager_secret_version" "fvm_archive_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.fvm_archive_lotus[0].id
}

data "aws_secretsmanager_secret" "space07_cache_mainnet_lotus" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-space07-cache"
}

data "aws_secretsmanager_secret_version" "space07_cache_mainnet_lotus" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.space07_cache_mainnet_lotus[0].id
}

data "aws_secretsmanager_secret" "cid_checker" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-cid-checker"
}

data "aws_secretsmanager_secret_version" "cid_checker" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.cid_checker[0].id
}

data "aws_secretsmanager_secret" "cid_checker_calibration" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-cid-checker-calibration"
}

data "aws_secretsmanager_secret_version" "cid_checker_calibration" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.cid_checker_calibration[0].id
}

data "aws_secretsmanager_secret" "github_ssh_gist_updater" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}/github_ssh_gist_updater"
}

data "aws_secretsmanager_secret_version" "github_ssh_gist_updater" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.github_ssh_gist_updater[0].id
}


data "aws_secretsmanager_secret" "atlantis" {
  name = "${module.generator.prefix}/credentials-atlantis"
}

data "aws_secretsmanager_secret_version" "atlantis" {
  secret_id = data.aws_secretsmanager_secret.atlantis.id
}

data "aws_secretsmanager_secret" "credentials-grafana-users" {
  name = "${module.generator.prefix}/credentials-grafana-users"
}

data "aws_secretsmanager_secret_version" "credentials-grafana-users" {
  secret_id = data.aws_secretsmanager_secret.credentials-grafana-users.id
}

data "aws_secretsmanager_secret" "coinfirm" {
  count = local.is_prod_envs
  name  = "${module.generator.prefix}-coinfirm-lotus"
}

data "aws_secretsmanager_secret_version" "coinfirm" {
  count     = local.is_prod_envs
  secret_id = data.aws_secretsmanager_secret.coinfirm[0].id
}

data "aws_secretsmanager_secret" "monitoring_google_oauth" {
  name = "${module.generator.prefix}-monitoring-google-oauth"
}

data "aws_secretsmanager_secret_version" "monitoring_google_oauth" {
  secret_id = data.aws_secretsmanager_secret.monitoring_google_oauth.id
}

data "aws_secretsmanager_secret" "auth" {
  name = "${module.generator.prefix}-auth"
}

data "aws_secretsmanager_secret_version" "auth" {
  secret_id = data.aws_secretsmanager_secret.auth.id
}
