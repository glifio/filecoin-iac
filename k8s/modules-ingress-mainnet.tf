############CID Checker Wallaby#######################################
module "ingress-kong_cid-checker-wallaby" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-wallaby-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-wallaby-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-wallaby-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-wallaby-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-wallaby" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-wallaby-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-wallaby-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-wallaby-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-wallaby-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-wallaby-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

############CID Checker Calibration#######################################
module "ingress-kong_cid-checker-calibration" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-calibration-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-calibration-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-calibration-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-calibration-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-calibration" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-calibration-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-calibration-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-calibration-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-calibration-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-calibration-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

############ Cid Checker Hyperspace ##########################
module "ingress-kong_cid-checker-hyperspace" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-hyperspace-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-hyperspace-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-hyperspace-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-hyperspace" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-hyperspace-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-hyperspace-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-hyperspace-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-hyperspace-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.hyperspace.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

############CID Checker#######################################
module "ingress-kong_cid-checker-mainnet" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-mainnet-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-mainnet-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-mainnet-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-mainnet-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-mainnet" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType               = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-mainnet-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-mainnet-api" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/api/(.*)"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-mainnet-docs" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-mainnet-docs-subresources" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/docs/(.*)"
  get_ingress_backend_service_name   = "cid-checker-mainnet-backend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 3000
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

#############node.glif.io##########################

module "ingress-kong_space00-1234" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space00/lotus/(.*)"
  get_ingress_backend_service_name = "space00-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  type_lb_scheme                   = "external"
}

module "ingress-kong_space06-1234" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space06/lotus/(.*)"
  get_ingress_backend_service_name = "space06-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  type_lb_scheme                   = "external"
}

module "ingress-kong_space07-1234" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space07/lotus/(.*)"
  get_ingress_backend_service_name = "space07-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  type_lb_scheme                   = "external"
}

module "ingress-kong_space06-cache-8080" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space06/cache/(.*)"
  get_ingress_backend_service_name = "space06-cache" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  type_lb_scheme                   = "external"
}

module "ingress-kong_space07-cache-8080" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space07/cache/(.*)"
  get_ingress_backend_service_name = "space07-cache" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  type_lb_scheme                   = "external"
}

module "ingress-kong_space00-ipfs-service-4001" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space00/ipfs/4001/(.*)"
  get_ingress_backend_service_name = "space00-ipfs" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 4001
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  is_kong_auth_header_enabled      = false
  type_lb_scheme                   = "external"
}

module "ingress-kong_space00-ipfs-service-8080" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/space00/ipfs/8080/(.*)"
  get_ingress_backend_service_name = "space00-ipfs" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "node.glif.io"
  is_kong_auth_header_enabled      = false
  type_lb_scheme                   = "external"
}

module "ingress-kong_lotusgateway-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "api-read-master-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 2346
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wss.node.glif.io"
  type_lb_scheme                          = "external"
  is_kong_auth_header_block_public_access = false

  enable_methods_blacklist = true
  methods_blacklist        = ["Filecoin.ChainNotify"]
}

##########################################################


############## Internal LoadBalancer communication ##################
### FYI: Internal LoadBalancer works via API-GW

module "ingress-kong_api-read-v0-cache-8080" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/api-read/cache/(.*)"
  get_ingress_backend_service_name        = "api-read-v0-cache" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 8080
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "mainnet-internal.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_calibrationapi-ingress-lotus-1" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/calibrationapi/lotus/(.*)"
  get_ingress_backend_service_name        = "calibrationapi-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "mainnet-internal.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_hyperspace" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/hyperspace/lotus/(.*)"
  get_ingress_backend_service_name        = "hyperspace-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "mainnet-internal.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_wss-hyperspace-lotus-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "hyperspace-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 2346
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wss.hyperspace.node.glif.io"
  type_lb_scheme                          = "external"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_hyperspace-archive-lotus-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/archive/lotus/(.*)"
  get_ingress_backend_service_name        = "hyperspace-private-0-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "hyperspace.node.glif.io"
  type_lb_scheme                          = "external"
}

module "ingress-kong_wallaby-archive" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/wallaby/lotus/(.*)"
  get_ingress_backend_service_name        = "wallaby-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "mainnet-internal.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_wallaby-dev-lotus-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "wallaby-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 2346
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wss.wallaby.node.glif.io"
  type_lb_scheme                          = "external"
  is_kong_auth_header_block_public_access = false
}

#TODO: think about sharing snapshots for apiread-nodes in the test env

#############common service external##########################

module "ingress-kong_mainnet_monitoring-80" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_backend_service_name   = "monitoring-grafana"
  get_ingress_pathType               = "Prefix"
  as_is_ingress_backend_service_name = true // if value is false then the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = kubernetes_namespace_v1.monitoring.metadata[0].name
  get_rule_host                      = "monitoring.node.glif.io"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
  type_lb_scheme                     = "external"
}

##############################################################

############calibration.node.glif.io##########################

#module "ingress-kong_calibrationapi-archive" {
#  count                            = local.is_dev_envs
#  source                           = "../modules/k8s_ingress"
#  get_global_configuration         = local.make_global_configuration
#  get_ingress_http_path            = "/archive/lotus/(.*)"
#  get_ingress_backend_service_name = "calibrationapi-archive-lotus" // the "-service" string will be added automatically
#  get_ingress_backend_service_port = 1234
#  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
#  get_rule_host                    = "calibration.node.glif.io"
#  type_lb_scheme                   = "external"
#}

module "ingress-kong_api-read-dev-lotus-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "calibrationapi-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 2346
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wss.calibration.node.glif.io"
  type_lb_scheme                          = "external"
  is_kong_auth_header_block_public_access = false
}


module "ingress-kong_calibrationapi-node-archive" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/archive/lotus/(.*)"
  get_ingress_backend_service_name = "calibrationapi-archive-node-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "calibration.node.glif.io"
  type_lb_scheme                   = "external"
}


module "ingress-kong_calibrationapi-ipfs-service-4001" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/calibrationapi/ipfs/4001/(.*)"
  get_ingress_backend_service_name = "calibrationapi-ipfs" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 4001
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "calibration.node.glif.io"
  is_kong_auth_header_enabled      = false
  type_lb_scheme                   = "external"
}

module "ingress-kong_calibrationapi-ipfs-service-8080" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/calibrationapi/ipfs/8080/(.*)"
  get_ingress_backend_service_name = "calibrationapi-ipfs" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "calibration.node.glif.io"
  is_kong_auth_header_enabled      = false
  type_lb_scheme                   = "external"
}

############wallaby.dev.node.glif.io##########################

module "ingress-kong_wallaby_external" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/archive/lotus/(.*)"
  get_ingress_backend_service_name = "wallaby-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "wallaby.dev.node.glif.io"
  type_lb_scheme                   = "external"
}

#########################################################

module "ingress-kong_wallaby_private_0" {
  count                            = local.is_prod_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/lotus/(.*)"
  get_ingress_backend_service_name = "wallaby-archive-private-0-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "archive.wallaby.node.glif.io"
  type_lb_scheme                   = "external"
}
