############# Internal LoadBalancer communication ##################
## FYI: Internal LoadBalancer works via API-GW

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

module "ingress-atlantis-80" {
  count                              = local.is_dev_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_backend_service_name   = "atlantis"
  get_ingress_pathType               = "Prefix"
  as_is_ingress_backend_service_name = true // if value is false then the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "atlantis.dev.node.glif.io"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
  type_lb_scheme                     = "external"
}

#############################################################
