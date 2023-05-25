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
  enable_access_control   = false
  enable_return_json      = false
}
