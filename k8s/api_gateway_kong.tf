module "api_gateway_kong_dev" {
  count = local.is_dev_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "dev"
  domain_name = "api.dev.node.glif.io"

  ingress_class    = "external"
  namespace        = "network"
  upstream_service = "api-read-dev-lotus"

  enable_ext_token_auth       = true
  enable_limit_reqs_wo_header = true
}

module "api_gateway_kong_mainnet" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "mainnet"
  domain_name = "api.node.glif.io"

  ingress_class    = "external"
  namespace        = "network"
  upstream_service = "api-read-master-lotus"

  enable_ext_token_auth       = true
  enable_limit_reqs_wo_header = true
}

module "api_gateway_kong_calibration" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "calibration"
  domain_name = "api.calibration.node.glif.io"

  ingress_class    = "external"
  namespace        = "network"
  upstream_service = "calibrationapi-0-lotus"
  upstream_port    = 8545 # remove this line to roll back to lotus gateway

  enable_ext_token_auth       = true
  enable_limit_reqs_wo_header = true
}


# ingress for reserve chainstack external name


module "api_gateway_kong_chainstack" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "chainstack"
  domain_name = "api.node.glif.io"

  ingress_class           = "chainstack"
  namespace               = "network"
  upstream_service        = "api-read-master-lotus"
  override_rpc_v0_service = "chainstack"
  override_rpc_v0_port    = 80
  override_rpc_v1_service = "chainstack"
  override_rpc_v1_port    = 80
  preserve_host           = "false"
}
