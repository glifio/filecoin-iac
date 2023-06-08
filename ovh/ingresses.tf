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
  enable_return_json      = false
}

module "wss_spacenet_public" {
  name   = "wss-spacenet-public"
  source = "../modules/ovh_ingress"

  namespace = "network"

  http_host = "wss.spacenet.node.glif.io"
  http_path = "/apigw/lotus/(.*)"

  service_name = "spacenet-public-lotus-service"
  service_port = 2346

  secret_name = module.spacenet_secret.aws_secret_name

  enable_access_control = true
  access_control_public = true
}
