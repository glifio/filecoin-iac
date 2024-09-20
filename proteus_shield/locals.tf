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
}
