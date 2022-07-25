module "api_gw_dev" {
  count                             = local.is_dev_envs
  source                            = "../modules/api_gw_regional"
  get_stage_name                    = "dev"
  get_global_configuration          = local.make_global_configuration
  api_gateway_domain_name           = "api.dev.node.glif.io"
  get_zone_id                       = data.aws_route53_zone.dev_node_glif_io.zone_id
  get_acm_subject_alternative_names = ["*.dev.node.glif.io", "*.api.dev.node.glif.io"]
  http_endpoint_uri                 = "https://node.glif.link/"
  uri_service_endpoint_rpc_v0       = "api-read-dev/cache/rpc/v0"
  uri_service_endpoint_rpc_v1       = "api-read-dev/cache/rpc/v1"
  get_vpc_link_arns                 = [data.aws_lb.kong_internal.arn]
}

data "aws_route53_zone" "dev_node_glif_io" {
  name         = "dev.node.glif.io"
  private_zone = false
}

module "api_gw_calibration" {
  count                             = local.is_dev_envs
  source                            = "../modules/api_gw_regional"
  get_stage_name                    = "calibration"
  get_global_configuration          = local.make_global_configuration
  api_gateway_domain_name           = "api.calibration.node.glif.io"
  get_zone_id                       = data.aws_route53_zone.node_glif_io.zone_id
  get_acm_subject_alternative_names = ["*.calibration.node.glif.io", "*.api.calibration.node.glif.io"]
  http_endpoint_uri                 = "https://node.glif.link/"
  uri_service_endpoint_rpc_v0       = "api-read-dev/cache/rpc/v0"
  uri_service_endpoint_rpc_v1       = "api-read-dev/cache/rpc/v1"
  get_vpc_link_arns                 = [data.aws_lb.kong_internal.arn]
}
