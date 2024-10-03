module "ingress_ipfs" {
  name   = "ipfs"
  source = "../modules/ovh_ingress"

  namespace = var.kubernetes_namespace

  http_host      = "ipfs.${var.domain_zone}"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "ipfs"
  service_port = 5001

  ingress_class = "kong-external-lb"

  enable_path_transformer = false
  enable_return_json      = false
}

module "ingress_index" {
  name   = "index"
  source = "../modules/ovh_ingress"

  namespace = var.kubernetes_namespace

  http_host      = "index.${var.domain_zone}"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "graph-node-index"
  service_port = 8000

  ingress_class = var.ingress_class

  enable_path_transformer = false
  enable_return_json      = false
}

module "ingress_query" {
  name   = "query"
  source = "../modules/ovh_ingress"

  namespace = var.kubernetes_namespace

  http_host      = "query.${var.domain_zone}"
  http_path      = "/"
  http_path_type = "Prefix"

  service_name = "graph-node-query"
  service_port = 8000

  ingress_class = var.ingress_class

  enable_path_transformer = false
  enable_return_json      = false
}
