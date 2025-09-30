
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

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true
}

module "ingress_fvm_archive" {
  count = local.is_prod_envs

  name   = "fvm-archive-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "proteus-shield"

  http_host = "node.glif.io"
  http_path = "/fvm-archive/lotus"
  http_path_type = "Prefix"

  service_name = "proteus-shield-proxy-svc"
  service_port = 8080

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.fvm_archive_lotus[0].name

  enable_path_transformer = false
  enable_return_json      = true
  enable_access_control   = false
}

module "ingress_thegraph" {
  count = local.is_prod_envs

  name   = "thegraph-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/thegraph/lotus/(.*)"

  service_name = "thegraph-lotus-service"
  service_port = 1234

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.fvm_archive_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true
  enable_ext_token_auth   = true

  enable_optional_query_param_auth = true
}

module "ingress-kong_lotusgateway-2346" {
  count = local.is_prod_envs

  name   = "wss-mainnet"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "wss.node.glif.io"
  http_path = "/apigw/lotus/(.*)"

  service_name = "api-read-master-lotus-service"
  service_port = 2346

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true

  enable_ext_token_auth       = true
  enable_limit_reqs_wo_header = true
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
module "ingress_wss_calibnet" {
  count = local.is_prod_envs

  name   = "wss-calibnet"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "wss.calibration.node.glif.io"
  http_path = "/apigw/lotus/(.*)"

  service_name = "calibrationapi-0-lotus-service"
  service_port = 2346

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.calibrationapi_0_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true

  enable_ext_token_auth       = true
  enable_limit_reqs_wo_header = true
}

module "ingress-kong_calibrationapi-node-archive" {
  count = local.is_prod_envs

  name   = "calibration-archive-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "proteus-shield"

  http_host = "calibration.node.glif.io"
  http_path = "/archive/lotus"
  http_path_type = "Prefix"

  service_name = "proteus-shield-proxy-svc"
  service_port = 8080

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.calibrationapi_archive_node_lotus[0].name

  enable_path_transformer = false
  enable_return_json      = true
  enable_access_control   = false
}

module "ingress_coinfirm" {
  count = local.is_prod_envs

  name   = "coinfirm-forwarding"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/coinfirm/lotus/(.*)"

  service_name = "fvm-archive-lotus-service"
  service_port = 1234

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.fvm_archive_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true
}

module "ingress_lava" {
  count = local.is_prod_envs

  name   = "lava"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "node.glif.io"
  http_path = "/lava/lotus/(.*)"

  service_name = "space07-lotus-service"
  service_port = 1234

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.space07_mainnet_lotus[0].name

  enable_path_transformer = true
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true

  # enable_ip_whitelist = true
  # ip_whitelist = [
  #   "212.106.124.243",
  # ]
}

module "ingress_space07_1234" {
  count  = local.is_prod_envs
  name   = "ingress-space07-1234"
  source = "../modules/ovh_ingress"

  namespace = "proteus-shield"

  http_host      = "node.glif.io"
  http_path      = "/space07/lotus"
  http_path_type = "Prefix"

  service_name = "proteus-shield-proxy-svc"
  service_port = 8080

  ingress_class = "kong-external-lb"

  secret_name   = data.aws_secretsmanager_secret.space07_mainnet_lotus[0].name

  enable_path_transformer = false
  enable_return_json      = true
  enable_access_control   = false
}

module "ingress_auth" {
  count  = local.is_prod_envs
  name   = "ingress-auth"
  source = "../modules/ovh_ingress"

  namespace = "proteus-shield"

  http_host      = "auth.node.glif.io"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name  = "proteus-shield-proxy-svc"
  service_port  = 8080
  ingress_class = "kong-external-lb"

  enable_path_transformer = false
  enable_access_control   = false
  enable_return_json      = false

  enable_redirect   = true
  redirect_location = "https://api.node.glif.io/"
}

module "ingress_api_chain_love" {
  count = local.is_prod_envs

  name   = "api-chain-love"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host      = "api.chain.love"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "api-read-master-lotus-service"
  service_port = 2346

  ingress_class = "kong-external-lb"

  secret_name = data.aws_secretsmanager_secret.api_read_master_mainnet_lotus[0].name

  enable_path_transformer = false
  enable_access_control   = true
  access_control_public   = true
  access_control_replace  = true
  enable_return_json      = true
}

module "ingress_prometheus_production" {
  count = local.is_prod_envs

  name   = "prometheus-production"
  source = "../modules/ovh_ingress"
  
  namespace = "monitoring"

  http_host      = "prometheus.node.glif.io"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "monitoring-kube-prometheus-prometheus"
  service_port = 9090

  ingress_class = "kong-external-lb"

  enable_path_transformer = false
  enable_return_json      = false

  enable_ip_whitelist = true
  ip_whitelist = [
    "13.49.83.28/32"
  ]
}
