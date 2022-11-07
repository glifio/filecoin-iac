locals {
  get_project         = lookup(var.get_global_configuration, "project", "")
  get_region          = lookup(var.get_global_configuration, "region", "")
  get_environment     = lookup(var.get_global_configuration, "environment", "")
  get_sub_environment = lookup(var.get_global_configuration, "sub_environment", "")

  oidc_URL = replace(data.aws_eks_cluster.k8s_cluster.identity[0].oidc[0].issuer, "https://", "")
}
