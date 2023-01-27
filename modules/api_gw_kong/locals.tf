locals {
  project = lookup(var.global_config, "project", "")
  region  = lookup(var.global_config, "region", "")
  env     = lookup(var.global_config, "environment", "")
  sub_env = lookup(var.global_config, "sub_environment", "")

  prefix = "kong-apigw-${var.stage_name}"

  upstream_service = "${var.upstream_service}-service"

  domain_names = {
    homepage                   = "node.glif.link"
    circulating_supply         = "circulatingsupply.s3.amazonaws.com"
    circulating_supply_staging = "circulatingsupply-staging.s3.amazonaws.com"
  }

  paths = {
    rpc_v0         = "/rpc/v0"
    rpc_v1         = "/rpv/v1"
    diluted_supply = "/diluted_supply.html"
    index          = "/index.html"
  }

  auth_token = lookup(jsondecode(data.aws_secretsmanager_secret_version.current.secret_string), "jwt_token_kong_rw")
}
