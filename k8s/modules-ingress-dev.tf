############calibration.node.glif.io##########################

module "ingress-kong_calibrationapi-archive" {
  count                            = local.is_dev_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/archive/lotus/(.*)"
  get_ingress_backend_service_name = "calibrationapi-archive-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "calibration.node.glif.io"
  type_lb_scheme                   = "external"
}


module "ingress-kong_calibrationapi-ipfs-service-4001" {
  count                            = local.is_dev_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/calibrationapi/ipfs/(.*)"
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
  get_ingress_http_path            = "/calibrationapi/ipfs/(.*)"
  get_ingress_backend_service_name = "calibrationapi-ipfs" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "calibration.node.glif.io"
  is_kong_auth_header_enabled      = false
  type_lb_scheme                   = "external"
}

#########################################################



############# Internal LoadBalancer communication ##################
## FYI: Internal LoadBalancer works via API-GW

module "ingress-kong_calibrationapi-ingress-lotus-1" {
  count                            = local.is_dev_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/calibrationapi/lotus/(.*)"
  get_ingress_backend_service_name = "calibrationapi-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "dev-internal.dev.node.glif.io"
  type_lb_scheme                   = "internal"
}

module "ingress-kong_api-read-cache-dev-cache-8080" {
  count                            = local.is_dev_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/api-read-dev/cache/(.*)"
  get_ingress_backend_service_name = "api-read-cache-dev" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 8080
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "dev-internal.dev.node.glif.io"
  type_lb_scheme                   = "internal"
  #    is_kong_auth_header_enabled      = false
}

module "ingress-kong_api-read-dev-lotus-1234" {
  count                            = local.is_dev_envs
  source                           = "../modules/k8s_ingress"
  get_global_configuration         = local.make_global_configuration
  get_ingress_http_path            = "/api-read-dev/lotus/(.*)"
  get_ingress_backend_service_name = "api-read-dev-lotus" // the "-service" string will be added automatically
  get_ingress_backend_service_port = 1234
  get_ingress_namespace            = kubernetes_namespace_v1.network.metadata[0].name
  get_rule_host                    = "dev-internal.dev.node.glif.io"
  type_lb_scheme                   = "internal"
}

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
