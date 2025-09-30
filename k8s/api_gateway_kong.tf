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
  enable_limit_reqs_wo_header = false

  enable_token_replacement        = false
  use_ext_token_auth_plugin       = false
  override_auth_ingress_namespace = "proteus-shield"
  override_auth_ingress_service   = "proteus-shield-proxy-svc"
  override_auth_ingress_port      = 8080
}

#module "api_gateway_kong_dev_mirror" {
#  count = local.is_dev_envs
#
#  source        = "../modules/api_gw_kong"
#  global_config = local.make_global_configuration
#
#  stage_name  = "mirror"
#  domain_name = "api.dev.node.glif.io"
#
#  ingress_class    = "mirror"
#  namespace        = "network"
#  upstream_service = "api-read-dev-lotus"
#
#  enable_ext_token_auth       = true
#  enable_limit_reqs_wo_header = true
#
#  enable_mirroring = true
#  mirror_to        = ["http://mirror-calibration-sender-svc.default:5000"]
#}

module "api_gateway_kong_mainnet" {
  count = local.is_prod_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "mainnet"
  domain_name = "api.node.glif.io"

  ingress_class    = "external"
  namespace        = "network"
  upstream_service = "api-read-master-lotus"

  enable_ext_token_auth       = false
  enable_limit_reqs_wo_header = false

  # Remove the lines below to roll back to kong
  enable_token_replacement        = false
  use_ext_token_auth_plugin       = false
  override_auth_ingress_namespace = "proteus-shield"
  override_auth_ingress_service   = "proteus-shield-proxy-svc"
  override_auth_ingress_port      = 8080

  enable_homepage_redirect = true
  homepage_redirect_url = "https://filecoin.chain.love"
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

  enable_ext_token_auth       = false
  enable_limit_reqs_wo_header = false

  enable_token_replacement        = false
  use_ext_token_auth_plugin       = false
  override_auth_ingress_namespace = "proteus-shield"
  override_auth_ingress_service   = "proteus-shield-proxy-svc"
  override_auth_ingress_port      = 8080
}

