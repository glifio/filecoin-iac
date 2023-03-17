locals {
  project = lookup(var.global_config, "project", "")
  region  = lookup(var.global_config, "region", "")
  env     = lookup(var.global_config, "environment", "")
  sub_env = lookup(var.global_config, "sub_environment", "")

  prefix = "kong-apigw-${var.stage_name}"

  upstream_service = "${var.upstream_service}-service"
  rpc_v0_service   = var.override_rpc_v0_service == null ? local.upstream_service : "${var.override_rpc_v0_service}-service"
  rpc_v1_service   = var.override_rpc_v1_service == null ? local.upstream_service : "${var.override_rpc_v1_service}-service"

  rpc_v0_port = var.override_rpc_v0_port == null ? var.upstream_port : var.override_rpc_v0_port
  rpc_v1_port = var.override_rpc_v1_port == null ? var.upstream_port : var.override_rpc_v1_port

  domain_names = {
    homepage                   = "glif-static-website.s3-website-ap-northeast-1.amazonaws.com"
    circulating_supply         = "circulatingsupply-prod.s3.amazonaws.com"
    circulating_supply_staging = "circulatingsupply-staging.s3.amazonaws.com"
  }

  paths = {
    rpc_v0         = "/rpc/v0"
    rpc_v1         = "/rpc/v1"
    diluted_supply = "/diluted_supply.html"
    index          = "/index.html"
  }

  auth_token = lookup(jsondecode(data.aws_secretsmanager_secret_version.current.secret_string), "jwt_token_kong_rw")

  daemon_service_secret = var.override_daemon_service == null ? var.upstream_service : var.override_daemon_service
  daemon_service        = var.override_daemon_service == null ? local.upstream_service : "${var.override_daemon_service}-service"

  daemon_token = lookup(jsondecode(data.aws_secretsmanager_secret_version.daemon.secret_string), "jwt_token_kong_rw")

  mirror_plugin = var.enable_mirroring ? kubernetes_manifest.http_mirror-rpc[0].manifest.metadata.name : ""
}
