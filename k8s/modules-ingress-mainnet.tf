############CID Checker#######################################
module "ingress-kong_cid-checker-mainnet" {
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                              = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                            = local.is_mainnet_envs
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
  count                                   = local.is_mainnet_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "api-read-master-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 2346
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wss.node.glif.io"
  type_lb_scheme                          = "external"
  is_kong_auth_header_block_public_access = false
}

##########################################################


############## Internal LoadBalancer communication ##################
### FYI: Internal LoadBalancer works via API-GW

module "ingress-kong_api-read-v0-cache-8080" {
  count                                   = local.is_mainnet_envs
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

#TODO: think about sharing snapshots for apiread-nodes in the test env

#############common service external##########################

module "ingress-kong_mainnet_monitoring-80" {
  count                              = local.is_mainnet_envs
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
