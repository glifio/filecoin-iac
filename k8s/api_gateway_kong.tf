module "api_gateway_kong_dev" {
  count = local.is_dev_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "dev"
  domain_name = "api.dev.node.glif.io"

  ingress_class    = "kong-external-lb"
  namespace        = "network"
  upstream_service = "api-read-dev-lotus"

  enable_mirroring = true
  mirror_to        = [
    "https://kong-mirror.free.beeceptor.com"
  ]
}

module "api_gateway_kong_mainnet" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "mainnet"
  domain_name = "api.node.glif.io"

  ingress_class = "kong-external-lb"
  namespace     = "network"
  upstream_service = "api-read-master-lotus"
}

module "api_gateway_kong_calibration" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "calibration"
  domain_name = "api.calibration.node.glif.io"

  ingress_class    = "kong-external-lb"
  namespace        = "network"
  upstream_service = "calibrationapi-lotus"
}

module "api_gateway_kong_hyperspace" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "hyperspace"
  domain_name = "api.hyperspace.node.glif.io"

  ingress_class    = "kong-external-lb"
  namespace        = "network"
  upstream_service = "hyperspace-lotus"
}