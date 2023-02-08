module "api_gateway_kong_dev" {
  count = local.is_dev_envs

  source        = "../modules/api_gw_kong"
  global_config = local.make_global_configuration

  stage_name  = "dev"
  domain_name = "wss.dev.node.glif.io"

  ingress_class    = "kong-external-lb"
  namespace        = "network"
  upstream_service = "api-read-dev-lotus"
}
