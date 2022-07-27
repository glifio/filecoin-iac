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

data "aws_lb" "kong_external" {
  tags = {
    Name = "${module.generator.prefix}-kong-external"
  }

  depends_on = [
    helm_release.konghq-external
  ]
}

data "aws_lb" "kong_internal" {
  tags = {
    Name = "${module.generator.prefix}-kong-internal"
  }

  depends_on = [
    helm_release.konghq-internal
  ]
}

data "aws_route53_zone" "selected" {
  name         = var.route53_domain
  private_zone = false
}

data "aws_route53_zone" "node_glif_io" {
  name         = "node.glif.io"
  private_zone = false
}

data "aws_secretsmanager_secret" "calibrationapi_archive_lotus" {
  count = local.is_dev_envs
  name  = "${module.generator.prefix}-calibrationapi-archive-lotus"
}

data "aws_secretsmanager_secret_version" "calibrationapi_archive_lotus" {
  count     = local.is_dev_envs
  secret_id = data.aws_secretsmanager_secret.calibrationapi_archive_lotus[0].id
}

data "aws_secretsmanager_secret" "calibrationapi_lotus" {
  count = local.is_dev_envs
  name  = "${module.generator.prefix}-calibrationapi-lotus"
}

data "aws_secretsmanager_secret_version" "calibrationapi_lotus" {
  count     = local.is_dev_envs
  secret_id = data.aws_secretsmanager_secret.calibrationapi_lotus[0].id
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

data "aws_secretsmanager_secret" "calibrationapi_jwt_lotus" {
  count = local.is_dev_envs
  name  = "${module.generator.prefix}-calibrationapi-jwt-lotus"
}

data "aws_secretsmanager_secret_version" "calibrationapi_jwt_lotus" {
  count     = local.is_dev_envs
  secret_id = data.aws_secretsmanager_secret.calibrationapi_jwt_lotus[0].id
}

data "aws_secretsmanager_secret" "monitoring" {
  name = "${module.generator.prefix}-monitoring"
}

data "aws_secretsmanager_secret_version" "monitoring" {
  secret_id = data.aws_secretsmanager_secret.monitoring.id
}
