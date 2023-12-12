
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
module "ingress_space06" {
  count = local.is_prod_envs

  name   = "space06-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/space06/lotus/(.*)"

  service_name = "api-read-master-lotus-service"
  service_port = 1234

  incress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
}

module "ingress_fvm_archive" {
  count = local.is_prod_envs

  name   = "fvm-archive-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/fvm-archive/lotus/(.*)"

  service_name  = "api-read-master-lotus-service"
  service_port  = 1234
  incress_class = "kong-external-lb"
  secret_name   = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
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
}

##########################################################


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

module "ingress-kong_api-read-dev-lotus-2346" {
  count                                   = local.is_prod_envs
  source                                  = "../modules/k8s_ingress"
  get_global_configuration                = local.make_global_configuration
  get_ingress_http_path                   = "/apigw/lotus/(.*)"
  get_ingress_backend_service_name        = "calibrationapi-0-lotus" // the "-service" string will be added automatically
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


###################atlantis.node.glif.io######################################

module "ingress-atlantis-80" {
  count                              = local.is_prod_envs
  source                             = "../modules/k8s_ingress"
  get_global_configuration           = local.make_global_configuration
  get_ingress_http_path              = "/"
  get_ingress_backend_service_name   = "atlantis"
  get_ingress_pathType               = "Prefix"
  as_is_ingress_backend_service_name = true // if value is false then the "-service" string will be added automatically
  get_ingress_backend_service_port   = 80
  get_ingress_namespace              = "default"
  get_rule_host                      = "atlantis.node.glif.io"
  is_kong_auth_header_enabled        = false
  is_kong_transformer_header_enabled = false
  type_lb_scheme                     = "external"
  aws_secret_name                    = "filecoin-mainnet-apn1-glif/credentials-atlantis"

  enable_whitelist_ip = true
  get_whitelist_ips = [
    "64.78.234.192/27"
  ]
}

module "ingress_coinfirm" {
  count = local.is_prod_envs

  name   = "coinfirm-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/coinfirm/lotus/(.*)"

  service_name  = "api-read-master-lotus-service"
  service_port  = 1234
  incress_class = "kong-external-lb"
  secret_name   = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
}

module "ingress_private_mainnet_fallback" {
  count  = local.is_prod_envs
  name   = "private-mainnet-fallback"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "private.node.glif.io"
  http_path = "/mainnet/(.*)"

  service_name  = "api-read-master-lotus-service"
  service_port  = 1234
  incress_class = "kong-external-lb"
  secret_name   = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
}

module "ingress_private_calibration_fallback" {
  count  = local.is_prod_envs
  name   = "private-calibration-fallback"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "private.node.glif.io"
  http_path = "/calibration/(.*)"

  service_name  = "calibrationapi-0-lotus-service"
  service_port  = 1234
  incress_class = "kong-external-lb"
  secret_name   = data.aws_secretsmanager_secret.calibrationapi_0_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
}

module "ingress_space07_1234" {
  count  = local.is_prod_envs
  name   = "ingress-space07-1234"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host      = "node.glif.io"
  http_path      = "/space07/lotus/(.*)"
  http_path_type = "Exact"

  service_name  = "api-read-master-lotus-service"
  service_port  = 1234
  incress_class = "kong-external-lb"
  secret_name   = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_letsencrypt      = false
  enable_return_json      = true
}
