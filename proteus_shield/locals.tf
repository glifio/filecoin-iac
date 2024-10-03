locals {
  development_workspace = "filecoin-glif-dev-apn1"
  production_workspace  = "filecoin-glif-mainnet-apn1"

  resource_prefix_config = {
    "${local.development_workspace}" = "filecoin-dev-apn1-glif-ps"
    "${local.production_workspace}"  = "filecoin-mainnet-apn1-glif-ps"
  }
  resource_prefix = local.resource_prefix_config[terraform.workspace]

  kubernetes_cluster_name_config = {
    "${local.development_workspace}" = "filecoin-dev-apn1-glif-eks"
    "${local.production_workspace}"  = "filecoin-mainnet-apn1-glif-eks"
  }
  kubernetes_cluster_name = local.kubernetes_cluster_name_config[terraform.workspace]

  domain_zone_config = {
    "${local.development_workspace}" = "dev.node.glif.io"
    "${local.production_workspace}"  = "node.glif.io"
  }
  domain_zone = local.domain_zone_config[terraform.workspace]

  elb_name_tag_config = {
    "${local.development_workspace}" = "filecoin-dev-apn1-glif-kong-external"
    "${local.production_workspace}"  = "filecoin-mainnet-apn1-glif-kong-external"
  }
  elb_name_tag = local.elb_name_tag_config[terraform.workspace]
}
