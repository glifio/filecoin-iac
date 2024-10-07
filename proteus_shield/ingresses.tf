module "ingress_proxy" {
  name   = "proxy"
  source = "../modules/ovh_ingress"

  namespace = var.kubernetes_namespace

  http_host      = "proxy.${local.domain_zone}"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "proteus-shield-proxy-svc"
  service_port = 8080

  ingress_class = var.ingress_class

  enable_path_transformer = false
  enable_return_json      = false
}