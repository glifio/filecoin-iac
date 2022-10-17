############CID Checker Wallaby#######################################
module "ingress-kong_cid-checker-wallaby" {
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType              = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-wallaby-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default" 
  get_rule_host                      = "wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-wallaby-api" {
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType              = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-wallaby-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.wallaby.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-wallaby-api" {
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType              = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-calibration-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default" 
  get_rule_host                      = "calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-calibration-api" {
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_pathType              = "Prefix"
  get_ingress_backend_service_name   = "cid-checker-calibration-frontend" // the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "cid.calibration.filecoin.tools"
  type_lb_scheme                     = "external"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
}

module "ingress-kong_cid-checker-alternative-domain-calibration-api" {
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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
  count                              = local.is_dev_envs
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

module "ingress-kong_calibrationapi-node-archive" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/archive/lotus/(.*)"
  get_ingress_backend_service_name        = "calibrationapi-archive-node-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "calibration.node.glif.io"
  type_lb_scheme                          = "external"
}


module "ingress-kong_calibrationapi-ipfs-service-4001" {
  count                            = local.is_dev_envs
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
  count                            = local.is_dev_envs
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
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/archive/lotus/(.*)"
  get_ingress_backend_service_name        = "wallaby-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "wallaby.dev.node.glif.io"
  type_lb_scheme                          = "external"
}

module "ingress-kong_api-read-dev-lotus-2346" {
  count                                   = local.is_dev_envs
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

#########################################################



############# Internal LoadBalancer communication ##################
## FYI: Internal LoadBalancer works via API-GW

module "ingress-kong_calibrationapi-ingress-lotus-1" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/calibrationapi/lotus/(.*)"
  get_ingress_backend_service_name        = "calibrationapi-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "dev-internal.dev.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_api-read-cache-dev-cache-8080" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/api-read-dev/cache/(.*)"
  get_ingress_backend_service_name        = "api-read-cache-dev" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 8080
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "dev-internal.dev.node.glif.io"
  type_lb_scheme                          = "internal"
  #    is_kong_auth_header_enabled      = false
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_api-read-dev-lotus-1234" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/api-read-dev/lotus/(.*)"
  get_ingress_backend_service_name        = "api-read-dev-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "dev-internal.dev.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_wallaby-archive" {
  count                                   = local.is_dev_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/wallaby/lotus/(.*)"
  get_ingress_backend_service_name        = "wallaby-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port        = 1234
  get_ingress_namespace                   = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                           = "dev-internal.dev.node.glif.io"
  type_lb_scheme                          = "internal"
  is_kong_auth_header_block_public_access = false
}

module "ingress-kong_wallaby-dev-lotus-2346" {
  count                                   = local.is_dev_envs
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

#########################################################

#TODO: think about sharing snapshots for apiread-nodes in the test env

############common service external##########################

module "ingress-kong_monitoring-80" {
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_backend_service_name   = "monitoring-grafana"
  get_ingress_pathType               = "Prefix"
  as_is_ingress_backend_service_name = true // if value is false then the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = kubernetes_namespace_v1.monitoring.metadata[0].name
  get_rule_host                      = "monitoring.dev.node.glif.io"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
  type_lb_scheme                     = "external"
}

#############################################################
