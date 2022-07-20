locals {
  make_global_configuration = {
    project         = var.project
    region          = var.region
    environment     = var.environment
    sub_environment = var.sub_environment
  }

  oidc_URL = replace(data.aws_eks_cluster.k8s_cluster.identity[0].oidc[0].issuer, "https://", "")

# https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  get_registry_based_on_region = {
    "us-east-1"      = "602401143452.dkr.ecr.us-east-1.amazonaws.com"
    "us-east-2"      = "602401143452.dkr.ecr.us-east-2.amazonaws.com"
    "ap-northeast-1" = "602401143452.dkr.ecr.ap-northeast-1.amazonaws.com"
  }
  get_registry_based_on_regions = local.get_registry_based_on_region[var.region]

  env_dev_route53_record = {
    filecoin-dev-apn1-glif-eks  = 1
    filecoin-prod-apn1-glif-eks = 0
  }
  env_dev_route53_records = local.env_dev_route53_record[terraform.workspace]

  env_dev_ingress_record = {
    filecoin-dev-apn1-glif-eks  = 1
    filecoin-prod-apn1-glif-eks = 0
  }
  env_dev_ingress_records = local.env_dev_ingress_record[terraform.workspace]

  is_dev_env = {
    filecoin-dev-apn1-glif-eks  = 1
    filecoin-prod-apn1-glif-eks = 0
  }
  is_dev_envs = local.is_dev_env[terraform.workspace]
}
