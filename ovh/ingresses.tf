module "ingress_spacenet_daemon" {
  count = local.production

  name   = "spacenet-daemon"
  source = "../modules/ovh_ingress"

  http_host      = "api.spacenet.node.glif.io"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "spacenet-lotus-service"
  service_port = 1234

  enable_public_access = true
  secret_name          = "filecoin-mainnet-apn1-glif-spacenet"
}

module "ingress_monitoring" {
  name   = "monitoring"
  source = "../modules/ovh_ingress"

  namespace = "monitoring"

  http_host      = local.monitoring.domain_name
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "monitoring-grafana"
  service_port = 80

  enable_path_transformer = false
  enable_public_access    = false
}
