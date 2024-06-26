locals {
  make_global_configuration = {
    project         = var.project
    region          = var.region
    environment     = var.environment
    sub_environment = var.sub_environment
    route53_domain  = var.route53_domain
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
    filecoin-dev-apn1-glif-eks     = 1
    filecoin-mainnet-apn1-glif-eks = 0
  }
  env_dev_route53_records = local.env_dev_route53_record[terraform.workspace]

  kong_external_replicas_map = {
    filecoin-dev-apn1-glif-eks     = 1
    filecoin-mainnet-apn1-glif-eks = 8
  }

  kong_external_replicas = local.kong_external_replicas_map[terraform.workspace]

  env_dev_ingress_record = {
    filecoin-dev-apn1-glif-eks     = 1
    filecoin-mainnet-apn1-glif-eks = 0
  }
  env_dev_ingress_records = local.env_dev_ingress_record[terraform.workspace]

  is_dev_env = {
    filecoin-dev-apn1-glif-eks     = 1
    filecoin-mainnet-apn1-glif-eks = 0
  }
  is_dev_envs = local.is_dev_env[terraform.workspace]

  is_prod_env = {
    filecoin-dev-apn1-glif-eks     = 0
    filecoin-mainnet-apn1-glif-eks = 1
  }
  is_prod_envs = local.is_prod_env[terraform.workspace]


  external_lb_certificate = {
    filecoin-dev-apn1-glif-eks = [
      "*.${var.route53_domain}",
      "calibration.node.glif.io",
      "*.calibration.node.glif.io",
      "calibration.filecoin.tools",
      "*.calibration.filecoin.tools",
      "wallaby.filecoin.tools",
      "*.wallaby.filecoin.tools",
      "wss.wallaby.node.glif.io",
      "*.wss.wallaby.node.glif.io"
    ]
    filecoin-mainnet-apn1-glif-eks = [
      "*.${var.route53_domain}",
      "*.calibration.node.glif.io",
      "*.dev.node.glif.io",
      "filecoin.tools",
      "*.filecoin.tools",
      "*.calibration.filecoin.tools",
      "api.chain.love",
    ]
  }
  external_lb_certificates = local.external_lb_certificate[terraform.workspace]

  auth = {
    username = jsondecode(data.aws_secretsmanager_secret_version.auth.secret_string)["username"]
    password = jsondecode(data.aws_secretsmanager_secret_version.auth.secret_string)["password"]
    db_name  = jsondecode(data.aws_secretsmanager_secret_version.auth.secret_string)["dbName"]
  }
}
