module "api_gateway_kong_spacenet" {
  source        = "../modules/api_gw_kong"
  global_config = local.generator_config

  stage_name  = "spacenet"
  domain_name = "api.spacenet.node.glif.io"

  ingress_class       = "default"
  affix_ingress_class = false

  namespace              = "network"
  upstream_service       = "spacenet-public-lotus"

  certificate_issuer = "letsencrypt-issuer"
}
